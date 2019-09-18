;; Keybindings ;;
(with-eval-after-load "c-mode"
  ;; prevent c-mode from overriding my-keys
  (define-key c-mode-keymap (kbd "C-d") nil))

;; Irony Mode ;;
(add-hook 'c++-mode-hook 'irony-mode)
(add-hook 'c-mode-hook 'irony-mode)
(add-hook 'objc-mode-hook 'irony-mode)
(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)

;; Company Irony ;;
(with-eval-after-load "company"
  (add-to-list 'company-backends 'company-irony))

;; Formatting ;;
(setq-default c-block-comment-prefix "* ")
