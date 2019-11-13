(setq inhibit-splash-screen t)
;; (setq ring-bell-function 'ignore)
(setq visible-bell 1)
;; Prevent the cursor from blinking
(blink-cursor-mode 0)
;; Don't use messages that you don't read
(setq initial-scratch-message "")
(setq inhibit-startup-message t)

;; You need to set `inhibit-startup-echo-area-message' from the
;; customization interface:
;; M-x customize-variable RET inhibit-startup-echo-area-message RET
;; then enter your username
(setq inhibit-startup-echo-area-message "prash")


;;; Setup package.el
(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(unless package--initialized (package-initialize))

;;; Setup use-package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-when-compile
  (require 'use-package))
(setq use-package-always-ensure t)

;; warn when opening files bigger than 100MB
(setq large-file-warning-threshold 100000000)

;;(if (window-system)
;;    (set-frame-height (selected-frame) 30))
(setq nlinum-format "%d║")
(global-nlinum-mode t)

(add-hook 'before-save-hook 'whitespace-cleanup)

;; (require 'icicles)
;; (icy-mode 1)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#242424" "#e5786d" "#95e454" "#cae682" "#8ac6f2" "#333366" "#ccaa8f" "#f6f3e8"])
 '(ansi-term-color-vector
   [unspecified "#343d46" "#cc6666" "#b5bd68" "#f0c674" "#81a2be" "#b294bb" "#81a2be" "#dfe1e8"])
 '(blink-cursor-mode nil)
 '(c-basic-offset 4)
 '(c-default-style
   '((c-mode . "linux")
	 (c++-mode . "stroustrup")
	 (java-mode . "java")
	 (awk-mode . "awk")
	 (other . "gnu")))
 '(c-report-syntactic-errors t)
 '(column-number-mode t)
 '(cua-mode t nil (cua-base))
 '(current-language-environment "UTF-8")
 '(custom-enabled-themes '(manoj-dark))
 '(doc-view-continuous t)
 '(oz-indent-chars 4)
 '(package-selected-packages
   '(julia-mode company-lean lean-mode prolog forth-mode nlinum markdown-mode company))
 '(python-indent-guess-indent-offset t)
 '(rng-nxml-auto-validate-flag nil)
 '(scroll-step 1)
 '(size-indication-mode t)
 '(tab-width 4)
 '(text-mode-hook '(turn-on-auto-fill text-mode-hook-identify))
 '(tool-bar-max-label-size 10)
 '(tool-bar-mode nil)
 '(tool-bar-style 'text)
 '(visible-bell nil))

; Define some additional "native-Windows" keystrokes (^tab, Alt/F4, ^O)
; and redefine (some of) the overridden Emacs functions.
(global-set-key [C-tab] 'next-multiframe-window)
(global-set-key [C-S-tab] 'previous-multiframe-window)
;; (global-set-key [M-f4] 'save-buffers-kill-emacs)
(global-set-key "\C-o" 'find-file)
(global-set-key "\C-q" 'kill-this-buffer)
(global-set-key (kbd "C-S-o") 'open-line)
(global-set-key (kbd "C-S-w") 'kill-region)
(define-key isearch-mode-map "\C-f" 'isearch-repeat-forward)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:slant normal :weight normal :height 98 :width normal :family "Go Mono" :foundry "    "))))
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


(autoload 'python-mode "python-mode.el" "Python mode." t)
(setq auto-mode-alist (append '(("/.*\.py\'" . python-mode)) auto-mode-alist))
(setq auto-mode-alist (append '(("/*.\.py$" . python-mode)) auto-mode-alist))
(setq auto-mode-alist (append '(("/*.\.py2$" . python-mode)) auto-mode-alist))
(setq auto-mode-alist (append '(("/*.\.jpy$" . python-mode)) auto-mode-alist))

(setq auto-mode-alist (cons '("\.lua$" . lua-mode) auto-mode-alist))
(autoload 'lua-mode "lua-mode" "Lua editing mode." t)

(setq auto-mode-alist (append '(("/*.\.tex$" . context-mode)) auto-mode-alist))
(setq auto-mode-alist (append '(("/*.\.context$" . context-mode)) auto-mode-alist))

;; Shell script mode for Arch PKGBUILDs
(setq auto-mode-alist (cons '("\\PKGBUILD$" . sh-mode) auto-mode-alist))

(load "/usr/share/emacs/site-lisp/ProofGeneral/generic/proof-site")

;; (require 'mercury)
;;(add-hook 'prolog-mode-hook 'merc-maybe-minor)
;;(push '("\\.m$" . mercury-mode)
;;     auto-mode-alist)
;;(setq auto-mode-alist (append '(("/*.\.m$" . prolog-mode)) auto-mode-alist))

;;(autoload 'run-prolog "prolog" "Start a Prolog sub-process." t)
;;(autoload 'prolog-mode "prolog" "Major mode for editing Prolog programs." t)
;;(autoload 'mercury-mode "prolog" "Major mode for editing Mercury programs." t)
;;(setq prolog-system 'swi)
;;(setq auto-mode-alist (append '(("\.pl$" . prolog-mode)
;;								("\.m$" . mercury-mode))
;;							  auto-mode-alist))
;;
;;(add-to-list 'load-path "/usr/lib/mercury/elisp")
;;(autoload 'mdb "gud" "Invoke the Mercury debugger" t)
;; (require 'go-mode-load)

(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\.yml\'" . yaml-mode))


;; If the *scratch* buffer is killed, recreate it automatically
;; FROM: Morten Welind
;;http://www.geocrawler.com/archives/3/338/1994/6/0/1877802/
(save-excursion
  (set-buffer (get-buffer-create "*scratch*"))
  (lisp-interaction-mode)
  (make-local-variable 'kill-buffer-query-functions)
  (add-hook 'kill-buffer-query-functions 'kill-scratch-buffer))

(defun kill-scratch-buffer ()
  ;; The next line is just in case someone calls this manually
  (set-buffer (get-buffer-create "*scratch*"))
  ;; Kill the current (*scratch*) buffer
  (remove-hook 'kill-buffer-query-functions 'kill-scratch-buffer)
  (kill-buffer (current-buffer))
  ;; Make a brand new *scratch* buffer
  (set-buffer (get-buffer-create "*scratch*"))
  (lisp-interaction-mode)
  (make-local-variable 'kill-buffer-query-functions)
  (add-hook 'kill-buffer-query-functions 'kill-scratch-buffer)
  ;; Since we killed it, don't let caller do that.
  nil)
