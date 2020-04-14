;; Keybindings ;;
;; (with-eval-after-load "cc-mode"
;;   ;; disable electric comments
;;   (define-key c-mode-base-map "/" 'self-insert-command)
;;   (define-key c-mode-base-map "*" 'self-insert-command))

(c-add-style "ricoh-ascii"
             '("bsd"
               (c-basic-offset . 2)
               (c-offsets-alist
                (substatement-open . 0)
                (inline-open       . 0)
                (case-label        . +))))
