;; Keybindings ;;
(with-eval-after-load "sqml-mode"
  (define-key html-mode-map (kbd "C-c RET") ; previously html-paragraph (>?)
    '(lambda () (interactive) html-paragraph indent-for-tab-command))
  (define-key html-mode-map (kbd "C-c C-n") 'sgml-delete-tag) ; previously sgml-name-char (>C-c c)
  (define-key html-mode-map (kbd "C-c c") 'sgml-name-char)) ; previously NOTHING
