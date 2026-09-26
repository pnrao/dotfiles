// Set a random dark terminal background via OSC 11.
// Build: rustc --edition 2024 -C opt-level=3 -C strip=symbols bin/bgcolor.rs -o ~/bin/bgcolor

use std::env;
use std::fs::File;
use std::io::{self, IsTerminal, Read, Write};
use std::process::ExitCode;

const BRIGHT_MIN: u8 = 0x20;
const BRIGHT_RANGE: u8 = 0x20;

struct Rgb {
    r: u8,
    g: u8,
    b: u8,
}

// h in [0, 1), s and v in [0, 1]
fn hsv_to_rgb(h: f32, s: f32, v: f32) -> Rgb {
    let c = v * s;
    let hp = h * 6.0;
    let x = c * (1.0 - (hp % 2.0 - 1.0).abs());
    let (r, g, b) = match hp as u8 {
        0 => (c, x, 0.0),
        1 => (x, c, 0.0),
        2 => (0.0, c, x),
        3 => (0.0, x, c),
        4 => (x, 0.0, c),
        _ => (c, 0.0, x),
    };
    let m = v - c;
    let to_u8 = |f: f32| ((f + m) * 255.0).round() as u8;
    Rgb {
        r: to_u8(r),
        g: to_u8(g),
        b: to_u8(b),
    }
}

fn env_is(name: &str, values: &[&str]) -> bool {
    env::var(name).is_ok_and(|s| values.contains(&s.as_str()))
}

fn supports_osc11(out: &impl IsTerminal) -> bool {
    out.is_terminal()
        && env_is("COLORTERM", &["truecolor", "24bit"])
        && !env_is("TERM_PROGRAM", &["vscode"])
}

fn main() -> ExitCode {
    let mut verbose = false;
    let mut force = false;

    for arg in env::args().skip(1) {
        let Some(flags) = arg.strip_prefix('-').filter(|f| !f.is_empty()) else {
            eprintln!("usage: bgcolor [-v] [-f]");
            return ExitCode::FAILURE;
        };
        for flag in flags.chars() {
            match flag {
                'v' => verbose = true,
                'f' => force = true,
                _ => {
                    eprintln!("bgcolor: invalid option -- '{flag}'");
                    return ExitCode::FAILURE;
                }
            }
        }
    }

    let mut hsv = [0u8; 3];
    if File::open("/dev/urandom")
        .and_then(|mut f| f.read_exact(&mut hsv))
        .is_err()
    {
        return ExitCode::FAILURE;
    }

    let [h, s, v] = hsv;
    let c = hsv_to_rgb(
        f32::from(h) / 256.0,
        f32::from(s) / 255.0,
        f32::from(BRIGHT_MIN + v % BRIGHT_RANGE) / 255.0,
    );

    let mut out = io::stdout().lock();
    let mut result = Ok(());

    if force || supports_osc11(&out) {
        result = write!(out, "\x1b]11;#{:02x}{:02x}{:02x}\x1b\\", c.r, c.g, c.b);
    }

    // for terminals that don't support ANSI code to set background
    // (e.g. urxvt -bg), no trailing newline: callers that splice the
    // output into a command line don't all strip it
    if verbose {
        result = result.and_then(|()| write!(out, "rgb:{:02x}/{:02x}/{:02x}", c.r, c.g, c.b));
    }

    match result.and_then(|()| out.flush()) {
        Ok(()) => ExitCode::SUCCESS,
        Err(_) => ExitCode::FAILURE,
    }
}
