(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("d9046dcd38624dbe0eb84605e77d165e24fdfca3a40c3b13f504728bab0bf99d" default)))
 '(org-agenda-files nil)
 '(package-selected-packages
   (quote
    (use-package company tide csharp-mode exec-path-from-shell bash-completion slime rust-mode)))
 '(safe-local-variable-values
   (quote
    ((org-html-postamble)
     (org-html-postamble . "<p class=\"author\">&hearts; ~%a~ &hearts;</p>")
     (org-html-postamble . "<p class=\"author\">~ %a ~</p>")
     (org-html-postamble . "<p class=\"author\">Author: %a (%e)</p>")
     (org-html-postamble-format
      ("en" "<p class=\"author\">Author: %a (%e)</p>"))))))
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
(setq visible-bell 1)

;; Make Aliases Available in Subshell ;;
(setq shell-file-name "bash")
(setq shell-command-switch "-ic")

;; Load ;;
(add-to-list 'load-path (expand-file-name "~/.emacs.d/external"))

(require 'package)
(require 'dired-x)
;; (require 'tls)
;; (require 'erc)
(require 'dired-mtp)
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
(defalias 'quit-window 'delete-frame)

;; Mode Settings ;;
(tool-bar-mode -1)
;; (global-linum-mode 1)
(column-number-mode 1)
(scroll-bar-mode -1)
(setq-default indent-tabs-mode nil)
(setf pop-up-frames t)

;; Final ;;
(load "my-appearance.el")
(server-start)
(dired (expand-file-name "~"))