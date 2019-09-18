;; Keybindings ;;
(with-eval-after-load "c-mode"
  ;; prevent c-mode from overriding my-keys
  (define-key c-mode-keymap (kbd "C-d") nil))

;; Formatting ;;
(setq-default c-block-comment-prefix "* ")
