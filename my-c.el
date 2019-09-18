;; Keybindings ;;
(with-eval-after-load "c-mode"
  ;; prevent c-mode from overriding my-keys
  (define-key c-mode-keymap (kbd "C-d") nil))

;; irony mode ;;
(add-hook 'c++-mode-hook 'irony-mode)
(add-hook 'c-mode-hook 'irony-mode)
(add-hook 'objc-mode-hook 'irony-mode)
(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)

;; Formatting ;;
(setq-default c-block-comment-prefix "* ")
