#!/bin/zsh

# List of plugins where all versions must remain installed
# Add plugin names to this array as needed
exceptions=("protonge")

# Plugins that take a long time to build — processed last so fast upgrades appear first
slow_plugins=("elixir" "erlang" "julia" "lean")

# --light skips the slow plugins entirely
light=0
if [[ "$1" == "--light" ]]; then
    light=1
fi

# Makes Erlang build-install faster
export KERL_CONFIGURE_OPTIONS="--disable-debug --without-javac"

# asdf plugin update --all # slow
all_plugins=($(asdf plugin list))

# Reorder: fast plugins first, slow ones deferred to the end
plugins=()
deferred=()
for plugin in $all_plugins; do
    if [[ " ${slow_plugins[@]} " =~ " $plugin " ]]; then
        deferred+=("$plugin")
    else
        plugins+=("$plugin")
    fi
done
if [[ $light -eq 0 ]]; then
    plugins+=($deferred)
fi

for plugin in $plugins; do
    # Get latest version
    latest=$(asdf latest $plugin 2>/dev/null)
    if [[ -z "$latest" ]] || [[ "$latest" == "No compatible versions"* ]] || [[ "$latest" == "unable to"* ]]; then
        echo "$plugin: no latest version found, skipping"
        continue
    fi
    # Get current global version before updating
    current=$(asdf current --no-header $plugin 2>/dev/null | awk '{print $2}')
    # Print plugin name immediately so progress is visible during long installs
    printf "%s: " "$plugin"
    # Install latest version (asdf handles if already installed)
    asdf install $plugin $latest >/dev/null 2>&1
    # Verify installation succeeded before proceeding
    if ! asdf list $plugin 2>/dev/null | grep -qE "^\s*\*?\s*${latest}\s*$"; then
        echo "failed to install $latest, skipping cleanup"
        continue
    fi
    # Set global to latest
    (cd ~ && asdf set $plugin $latest >/dev/null 2>&1)
    if [[ "$current" == "$latest" ]]; then
        echo "was already $latest"
    else
        echo "updated $current -> $latest"
    fi

    if [[ ! " ${exceptions[@]} " =~ " $plugin " ]]; then
        # Get all installed versions
        installed_versions=($(asdf list $plugin 2>/dev/null | awk 'NF{print $NF}'))
        for version in $installed_versions; do
            if [[ "$version" != "$latest" ]]; then
                asdf uninstall $plugin $version >/dev/null 2>&1
            fi
        done
    fi
done
