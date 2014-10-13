;; (setq load-path (cons "/usr/share/emacs/site-lisp/icicles" load-path))
;; (require 'icicles)
;; (eval-after-load "ring" '(progn (require 'ring+)))

(setq inhibit-splash-screen t)
;; Prevent the cursor from blinking
(blink-cursor-mode 0)
;; Don't use messages that you don't read
(setq initial-scratch-message "")
(setq inhibit-startup-message t)

;; You need to set `inhibit-startup-echo-area-message' from the
;; customization interface:
;; M-x customize-variable RET inhibit-startup-echo-area-message RET
;; then enter your username
;; (setq inhibit-startup-echo-area-message "prash")


;; warn when opening files bigger than 100MB
(setq large-file-warning-threshold 100000000)

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
 '(blink-cursor-mode nil)
 '(c-basic-offset 4)
 '(c-default-style (quote ((c-mode . "linux") (c++-mode . "stroustrup") (java-mode . "java") (awk-mode . "awk") (other . "gnu"))))
 '(c-report-syntactic-errors t)
 '(column-number-mode t)
 '(cua-mode t nil (cua-base))
 '(current-language-environment "UTF-8")
 '(rng-nxml-auto-validate-flag nil)
 '(size-indication-mode t)
 '(text-mode-hook (quote (turn-on-auto-fill text-mode-hook-identify))))


; Define some additional "native-Windows" keystrokes (^tab, Alt/F4, ^A, ^F, ^O,
; ^S, ^W) and redefine (some of) the overridden Emacs functions.
(global-set-key [C-tab] 'next-multiframe-window)
(global-set-key [C-S-tab] 'previous-multiframe-window)
;; (global-set-key [M-f4] 'save-buffers-kill-emacs)
(global-set-key "\C-a" 'mark-whole-buffer)
(global-set-key "\C-f" 'isearch-forward)
(global-set-key "\C-o" 'find-file)
(global-set-key "\C-s" 'save-buffer)
(global-set-key "\C-w" 'kill-this-buffer)
(global-set-key (kbd "C-S-o") 'open-line)
(global-set-key (kbd "C-S-w") 'kill-region)
(define-key global-map (kbd "RET") 'newline-and-indent) ; For programming language modes
(define-key isearch-mode-map "\C-f" 'isearch-repeat-forward)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:slant normal :weight normal :height 75 :width normal :family "Monaco"))))
 '(bold-italic ((t (:slant oblique :weight bold))))
 '(font-lock-comment-face ((t (:foreground "dark gray"))))
 '(font-lock-doc-face ((t (:foreground "tan"))))
 '(font-lock-function-name-face ((t (:foreground "purple"))))
 '(font-lock-keyword-face ((t (:foreground "steel blue"))))
 '(font-lock-preprocessor-face ((t (:foreground "dark violet"))))
 '(font-lock-string-face ((t (:foreground "dark orange"))))
 '(font-lock-variable-name-face ((t (:weight bold))))
 '(glyphless-char ((t nil)))
 '(italic ((t (:slant oblique))))
 '(minibuffer-prompt ((t (:foreground "deep sky blue"))))
 '(tool-bar ((t nil)))
 '(trailing-whitespace ((t (:background "gray")))))


(add-to-list 'load-path "~/.emacs.d/vlfi")
(require 'vlf-integrate)

;; (autoload 'python-mode "python-mode.el" "Python mode." t)
;; (package-initialize)
;; (elpy-enable)

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
;; (require 'go-mode-load)

(autoload 'graphviz-dot-mode "graphviz-dot-mode.el" "graphviz dot mode." t)
(add-to-list 'auto-mode-alist '("\.dot" . graphviz-dot-mode))


(add-to-list 'load-path "~/.emacs.d/sparql-mode")
(autoload 'sparql-mode "sparql-mode.el"
    "Major mode for editing SPARQL files" t)
(add-to-list 'auto-mode-alist '("\\.sparql$" . sparql-mode))
(add-to-list 'auto-mode-alist '("\\.rq$" . sparql-mode))

(autoload 'ttl-mode "ttl-mode" "Major mode for OWL or Turtle files" t)
(setq auto-mode-alist (append '(("\.ttl$" . ttl-mode)
				("\.n3$" . ttl-mode)) auto-mode-alist))
