// ==UserScript==
// @name         Annoying Font Remover
// @description  Remove annoying fonts to let the browser use less annoying fallbacks, and thicken thin text
// @version      1.8
// @author       pnr
// @namespace    greasyfork.org/en/users/301031
// @homepageURL  https://greasyfork.org/scripts/407513-annoying-font-remover
// @match        *://*/*
// Font showcase sites, where seeing the actual font is the point.
// ↓ Keep this list alphabetical.
// @exclude      *://*1001fonts.com/*
// @exclude      *://*dafont.com/*
// @exclude      *://fonts.adobe.com/*
// @exclude      *://fonts.google.com/*
// @exclude      *://*fontlibrary.org/*
// @exclude      *://*fontshare.com/*
// @exclude      *://*fontsinuse.com/*
// @exclude      *://*fontspace.com/*
// @exclude      *://*fontsquirrel.com/*
// @exclude      *://*myfonts.com/*
// @exclude      *://*typewolf.com/*
// @grant        none
// @run-at       document-start
// ==/UserScript==

(function() {
  // ↓ Keep this list alphabetical otherwise it can become unmanageable.
  var badFnt = new RegExp('^('+
                           ['-apple-system',
                            'arial.*',
                            'BlinkMacSystemFont',
                            'cambria',
                            'charter',
                            'courier.*',
                            'crimson text',
                            'faustina',
                            'franklin gothic',
                            'freesans',
                            'georgia',
                            'helvetica.*',
                            'itc-slimbach',
                            'liberation mono',
                            'libre baskerville',
                            'lucida.*',
                            'minion-pro',
                            'NexusSerif',
                            'PT Serif',
                            'roboto',
                            'roboto mono',
                            'roman',
                            'segoe.*',
                            'spectral',
                            'times.*',
                            'TwitterChirp'
                           ].join('|')+
                           ')$', 'i');

  // The monospace fonts among the annoying ones. When one of these is removed,
  // the fallback must stay monospace, or code and aligned text break up.
  var monoFnt = /^(courier.*|liberation mono|lucida console|lucida sans typewriter|roboto mono)$/i;

  // The page's own inline values for the properties this script overrides,
  // so they can be put back when an element is re-checked.
  var original = new WeakMap();

  // Emoji fonts carry glyphs for space, 0-9, # and * (keycap bases). If one
  // ends up first in the stack, those characters render from it: huge spaces
  // and odd digits.
  var emojiFnt = /emoji|twemoji/i;

  // Work out what an element needs, without writing anything.
  function check(el) {
    var style = window.getComputedStyle(el);
    var fonts = style.getPropertyValue('font-family');
    var weight = style.getPropertyValue('font-weight');
    var fix = {};
    if (fonts) {
      var all = fonts.split(',').map(function(f) { return f.trim(); });
      // Test each family in the stack on its own, with quotes stripped,
      // so that only whole names match.
      var kept = [], mono = false;
      all.forEach(function(f) {
        var name = f.replace(/^["']|["']$/g, '');
        if (!badFnt.test(name)) kept.push(f);
        else if (monoFnt.test(name)) mono = true;
      });
      if (kept.length < all.length) {
        var generic = mono ? 'monospace' : 'sans-serif';
        // Put a text font ahead of any emoji font left at the front.
        if (kept.length && emojiFnt.test(kept[0])) kept.unshift(generic);
        // If every family is annoying, fall back to the browser's default
        // font (or its monospace one). An empty string would just remove the
        // inline style and let the page's own stack apply again.
        fix.family = kept.length ? kept.join(', ') : mono ? 'monospace' : 'initial';
      }
      // Thin text is hard to read, so raise anything below 400 to 400.
      if (parseInt(weight, 10) < 400) {
        fix.weight = '400';
      }
    }
    return (fix.family || fix.weight) ? fix : null;
  }

  function apply(el, fix) {
    if (!original.has(el)) {
      original.set(el, {
        family: el.style.getPropertyValue('font-family'),
        familyPrio: el.style.getPropertyPriority('font-family'),
        weight: el.style.getPropertyValue('font-weight'),
        weightPrio: el.style.getPropertyPriority('font-weight')
      });
    }
    // !important, or the page's own !important rules would win.
    if (fix.family) el.style.setProperty('font-family', fix.family, 'important');
    if (fix.weight) el.style.setProperty('font-weight', fix.weight, 'important');
  }

  // Undo this script's changes so the page's styles show through again.
  function restore(el) {
    var o = original.get(el);
    if (!o) return;
    el.style.setProperty('font-family', o.family, o.familyPrio);
    el.style.setProperty('font-weight', o.weight, o.weightPrio);
    original.delete(el);
  }

  // Mutations come in bursts (scroll handlers toggling classes, frameworks
  // rendering in steps), so the affected subtrees are gathered and fixed once
  // per frame. Animation frame callbacks run before paint, so nothing is
  // shown unfixed.
  var pending = new Set(), scheduled = false;
  function schedule(roots) {
    roots.forEach(function(r) { pending.add(r); });
    if (scheduled || !pending.size) return;
    scheduled = true;
    requestAnimationFrame(function() {
      scheduled = false;
      // Nodes removed since they were queued need no fixing.
      var roots = Array.from(pending).filter(function(r) { return r.isConnected; });
      pending.clear();
      // Reset even newly added nodes: one that was moved from elsewhere in
      // the page still carries the fix for its old place.
      fixTrees(roots, true);
    });
  }

  var observer = new MutationObserver(function(mutations) {
    var roots = [];
    for (var i = 0; i < mutations.length; i++) {
      var m = mutations[i];
      if (m.type === 'attributes') {
        // Scripts often set a class that is already there, e.g. on every
        // scroll event. That changes nothing, so don't re-check for it.
        if (m.target.getAttribute(m.attributeName) !== m.oldValue) roots.push(m.target);
      } else {
        var nodes = m.addedNodes;
        for (var j = 0; j < nodes.length; j++) {
          if (nodes[j].nodeType === Node.ELEMENT_NODE) roots.push(nodes[j]);
        }
      }
    }
    schedule(roots);
  });

  // Pages that render content after load (infinite scroll, single-page
  // apps) add new elements, and theme switches change classes or theme
  // attributes. style is not watched: the script writes to it, so watching
  // it would make the script react to its own changes.
  function watch(root) {
    observer.observe(root, {childList: true, subtree: true,
                            attributes: true, attributeOldValue: true,
                            attributeFilter: ['class', 'data-bs-theme',
                                              'data-color-mode', 'data-theme']});
  }

  // Gather an element (or shadow root) and everything inside it, including
  // the contents of open shadow roots, which the page-level search can't see.
  function collect(root, out) {
    if (root.nodeType === Node.ELEMENT_NODE) out.add(root);
    if (root.shadowRoot) {
      watch(root.shadowRoot);
      collect(root.shadowRoot, out);
    }
    var elem = root.querySelectorAll('*');
    for (var i = 0; i < elem.length; i++) {
      out.add(elem[i]);
      if (elem[i].shadowRoot) {
        watch(elem[i].shadowRoot);
        collect(elem[i].shadowRoot, out);
      }
    }
  }

  // Fix a set of subtrees. All styles are read before any are written:
  // alternating the two makes the browser recalculate styles every time.
  function fixTrees(roots, reset) {
    if (!roots.length) return;
    var elems = new Set();
    roots.forEach(function(r) { collect(r, elems); });
    var list = Array.from(elems);
    if (reset) list.forEach(restore);
    var fixes = list.map(check);
    for (var i = 0; i < list.length; i++) {
      if (fixes[i]) apply(list[i], fixes[i]);
    }
  }

  function start() {
    // documentElement rather than body: SVG and XML documents have no body.
    fixTrees([document.documentElement], false);
    watch(document.documentElement);
    // Re-check the whole page whenever the styles that apply can change
    // without a watched mutation: a stylesheet finishing loading (the first
    // pass can run before it has, and would have fixed the browser's default
    // font instead of the page's), or the system switching light/dark.
    function recheckAll() { schedule([document.documentElement]); }
    // load doesn't bubble, so listen in the capture phase.
    document.addEventListener('load', function(e) {
      var t = e.target;
      if (t.localName === 'link' && /\bstylesheet\b/i.test(t.rel)) recheckAll();
    }, true);
    var scheme = window.matchMedia('(prefers-color-scheme: dark)');
    if (scheme.addEventListener) scheme.addEventListener('change', recheckAll);
  }

  // The script manager may inject this after DOMContentLoaded has fired.
  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', start);
  } else {
    start();
  }
})();
