;; Use SBCL ;;
(setq inferior-lisp-program "/usr/bin/sbcl")
(setq slime-contribs '(slime-fancy))

;; Keybindings ;;
(with-eval-after-load "slime"
  ;; prevent Slime Mode from overriding my custom keys
  (define-key slime-mode-map (kbd "M-n") nil) ; previously slime-next-note (>C-c n)
  (define-key slime-mode-map (kbd "M-p") nil) ; previously slime-previous-note (>C-c p)
  ;; redefine the keys I robbed Slime Mode of
  (define-key slime-mode-map (kbd "C-c n") 'slime-next-note)
  (define-key slime-mode-map (kbd "C-c p") 'slime-previous-note))

(with-eval-after-load "slime-repl"
  ;; prevent Slime Repl from overriding my custom keys
  (define-key slime-repl-mode-map (kbd "M-n") nil)  ;previously slime-repl-next-input
  (define-key slime-repl-mode-map (kbd "M-p") nil)) ;previously slime-repl-previous-input
