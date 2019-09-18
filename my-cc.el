;; Keybindings ;;
(with-eval-after-load "cc-mode"
  ;; disable electric comments
  (define-key c-mode-base-map "/" 'self-insert-command)
  (define-key c-mode-base-map "*" 'self-insert-command))
