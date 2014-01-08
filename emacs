(setq inhibit-splash-screen t)
;; scroll one line at a time (less "jumpy" than defaults)
(setq scroll-step           1
	  scroll-conservatively 10000)
;;(if (window-system)
;;    (set-frame-height (selected-frame) 30))
(setq linum-format "%d ")
(global-linum-mode 1)

(add-hook 'before-save-hook 'whitespace-cleanup)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(c-basic-offset 4)
 '(c-default-style (quote ((c-mode . "linux") (c++-mode . "stroustrup") (java-mode . "java") (awk-mode . "awk") (other . "gnu"))))
 '(c-report-syntactic-errors t)
 '(custom-enabled-themes (quote (prash1)))
 '(custom-safe-themes (quote ("196639d69de2dc0e4cdd4fce765265f28e8fe9fdd641bc2387b0a7b24f6a6b50" "60f0fe87bfd78d1ade73743bf88ec3d773ce8949cac937188b1feff347d3af19" "1e7e097ec8cb1f8c3a912d7e1e0331caeed49fef6cff220be63bd2a6ba4cc365" "fc5fcb6f1f1c1bc01305694c59a1a861b008c534cae8d0e48e4d5e81ad718bc6" default)))
 '(custom-theme-load-path (quote ("~/.emacs.d/emacs-color-theme-solarized" custom-theme-directory t)))
 '(electric-indent-mode t)
 '(rng-nxml-auto-validate-flag nil)
 '(show-trailing-whitespace t)
 '(tab-stop-list (quote (4 8 12 16 20 24 28 32 36 40 44 48 52 56 60 64 68 72 76 80 84 88 92 96 100 104 108 112 116 120))))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:slant normal :weight normal :height 75 :width normal :family "Monaco"))))
 '(bold-italic ((t (:slant oblique :weight bold))))
 '(font-lock-function-name-face ((t (:foreground "dark violet"))))
 '(font-lock-keyword-face ((t (:foreground "medium blue"))))
 '(font-lock-string-face ((t (:foreground "dark orange"))))
 '(font-lock-variable-name-face ((t (:weight bold))))
 '(glyphless-char ((t nil)))
 '(italic ((t (:slant oblique))))
 '(tool-bar ((t nil)))
 '(trailing-whitespace ((t (:background "gray")))))



;; (autoload 'python-mode "python-mode.el" "Python mode." t)
(package-initialize)
(elpy-enable)

;;(setq auto-mode-alist (append '(("/*.\.py$" . python-mode)) auto-mode-alist))
;;(setq auto-mode-alist (append '(("/*.\.py2$" . python-mode)) auto-mode-alist))

(setq auto-mode-alist (cons '("\.lua$" . lua-mode) auto-mode-alist))
(autoload 'lua-mode "lua-mode" "Lua editing mode." t)

(setq auto-mode-alist (append '(("/*.\.tex$" . context-mode)) auto-mode-alist))
(setq auto-mode-alist (append '(("/*.\.context$" . context-mode)) auto-mode-alist))

;; Shell script mode for Arch PKGBUILDs
(setq auto-mode-alist (cons '("\\PKGBUILD$" . sh-mode) auto-mode-alist))

(add-to-list 'load-path "/usr/share/emacs/site-lisp/auto-complete")
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "/usr/share/emacs/site-lisp/auto-complete/ac-dict")
(ac-config-default)


;; (require 'mercury)
;;(add-hook 'prolog-mode-hook 'merc-maybe-minor)
;;(push '("\\.m$" . mercury-mode)
;;     auto-mode-alist)
;;(setq auto-mode-alist (append '(("/*.\.m$" . prolog-mode)) auto-mode-alist))
(autoload 'run-prolog "prolog" "Start a Prolog sub-process." t)
(autoload 'prolog-mode "prolog" "Major mode for editing Prolog programs." t)
(autoload 'mercury-mode "prolog" "Major mode for editing Mercury programs." t)
(setq prolog-system 'swi)
(setq auto-mode-alist (append '(("\.pl$" . prolog-mode)
								("\.m$" . mercury-mode))
								auto-mode-alist))

(add-to-list 'load-path "/usr/lib/mercury/elisp")
(autoload 'mdb "gud" "Invoke the Mercury debugger" t)
(require 'go-mode-load)

(autoload 'graphviz-dot-mode "graphviz-dot-mode.el" "graphviz dot mode." t)
(add-to-list 'auto-mode-alist '("\.dot" . graphviz-dot-mode))
