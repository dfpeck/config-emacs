(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auth-source-save-behavior nil)
 '(custom-safe-themes
   '("e5b7b99ec658a89ec23bf88765c0720f04cacb0f994832f7044967bda7f15914" "d9046dcd38624dbe0eb84605e77d165e24fdfca3a40c3b13f504728bab0bf99d" default))
 '(delete-selection-mode nil)
 '(org-agenda-files nil)
 '(package-selected-packages
   '(company-irony-c-headers company-irony irony use-package company tide csharp-mode exec-path-from-shell bash-completion slime rust-mode markdown-mode kivy-mode)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; General Variables ;;
(setq inhibit-startup-screen 1)
(setq initial-frame-alist (quote ((fullscreen . maximized))))
(setq async-shell-command-buffer 'new-buffer)
(setq save-interprogram-paste-before-kill t)
(setq initial-buffer-choice (expand-file-name "~"))
(setq next-screen-context-lines 4)

;; Make Aliases Available in Subshell ;;
(unless (string-match-p (regexp-quote "mingw")
                        (emacs-version))
  (setq shell-file-name "bash")
  (setq shell-command-switch "-ic"))

;; Load ;;
(add-to-list 'load-path (expand-file-name "~/.emacs.d/external"))

(require 'package)
(require 'dired-x)
(require 'dired-mtp)

(if (file-exists-p "renpy-mode/renpy.el")
    (load "renpy-mode/renpy.el"))
(if (file-exists-p "yaml-mode/yaml-mode.el")
    (load "yaml-mode/yaml-mode.el"))

(load "my-functions.el")
(load "my-keys.el")
(load "my-arduino.el")
(load "my-cc.el")
(load "my-c.el")
(load "my-dired.el")
(load "my-html.el")
(load "my-latex.el")
(load "my-man.el")
(load "my-matlab.el")
(load "my-org.el")
(load "my-python.el")
(load "my-shell.el")
(load "my-slime.el")
(load "my-tide.el")
(load "my-minor-modes.el")

;; Packages and Repositories ;;
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

(use-package tide
  :ensure t
  :after (typescript-mode company flycheck)
  :hook ((typescript-mode . tide-setup)
         (typescript-mode . tide-hl-identifier-mode)
         (before-save  . tide-format-before-save)))

;; async-shell-command ;;
(add-to-list 'display-buffer-alist (cons "\\*Async Shell Command\\*.*" (cons #'display-buffer-no-window nil)))

;; Aliases ;;
(defalias 'str= 'string=)
(defalias 'yes-or-no-p 'y-or-n-p) ; force y/n
(defalias 'async-shell-command 'dfp/async-shell-command) ; allow specifying output-buffer interactively
(setq ring-bell-function 'ignore)

;; Mode Settings ;;
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(column-number-mode 1)
(setq-default indent-tabs-mode nil)
(setq-default subword-mode 1)

;; Additional Settings for Tiling WMs ;;
(when (and (not (string-match-p (regexp-quote "mingw") ; if we are not on Windows
                                (emacs-version)))
           (or (string-match-p (regexp-quote "i3") (shell-command-to-string "echo $DESKTOP_SESSION"))         ; and if we are on i3
               (string-match-p (regexp-quote "sway") (shell-command-to-string "echo $DESKTOP_SESSION"))))      ; or sway
  (defalias 'quit-window 'delete-frame)                ; tiling WM-friendly settings
  (setf pop-up-frames t))

;; Final ;;
(load "my-appearance.el")
