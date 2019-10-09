(defvar my-keys-minor-mode-map (make-keymap) "my-keys-minor-mode keymap.")

;; Text Navigation ;;
(define-key my-keys-minor-mode-map (kbd "C-a") 'backward-char)             ; previously move-beginning-of-line (>C-q)
(define-key my-keys-minor-mode-map (kbd "C-d") 'forward-char)              ; previously delete-char (>C-n)
(define-key my-keys-minor-mode-map (kbd "C-w") 'previous-line)             ; previously kill-region (>C-p)
(define-key my-keys-minor-mode-map (kbd "C-s") 'next-line)                 ; previously isearch-forward (>C-f)
(define-key my-keys-minor-mode-map (kbd "C-q") 'move-beginning-of-line)    ; previously quoted-insert (>?)
(define-key my-keys-minor-mode-map (kbd "C-e") 'move-end-of-line)          ; default

(define-key my-keys-minor-mode-map (kbd "M-a") 'backward-word)             ; previously backward-sentence (>M-q)
(define-key my-keys-minor-mode-map (kbd "M-d") 'forward-word)              ; previously kill-word (>M-n)
(define-key my-keys-minor-mode-map (kbd "M-q") 'backward-sentence)         ; previously fill-paragraph (>M-b)
(define-key my-keys-minor-mode-map (kbd "M-e") 'forward-sentence)          ; default

(define-key my-keys-minor-mode-map (kbd "M-w") 'dfp/scroll-up)             ; previously kill-ring-save (>M-p)
(define-key my-keys-minor-mode-map (kbd "M-s") 'dfp/scroll-down)           ; previous prefix for various search functions

;; Text Manipulation ;;
(define-key my-keys-minor-mode-map (kbd "C-n") 'delete-char)               ; previously next-line (>C-s)
(define-key my-keys-minor-mode-map (kbd "M-n") 'kill-word)                 ; previously NIL

(define-key my-keys-minor-mode-map (kbd "C-p") 'kill-region)               ; previously previous-line (>C-w)
(define-key my-keys-minor-mode-map (kbd "M-p") 'kill-ring-save)            ; previously NIL

(define-key my-keys-minor-mode-map (kbd "M-b") 'fill-paragraph)            ; previously backward-word (>M-a)

(define-key my-keys-minor-mode-map (kbd "C-c w") 'whitespace-cleanup)      ; previously NIL

;; Window Navigation ;;
(define-key my-keys-minor-mode-map (kbd "C-M-w") 'windmove-up)             ; previously append-next-kill (>?)
(define-key my-keys-minor-mode-map (kbd "C-M-a") 'windmove-left)           ; previously beginning-of-defun (>?)
(define-key my-keys-minor-mode-map (kbd "C-M-s") 'windmove-down)           ; previously isearch-forward-regexp (>?)
(define-key my-keys-minor-mode-map (kbd "C-M-d") 'windmove-right)          ; presviously down-list (>?)

;; Search ;;
(define-key my-keys-minor-mode-map (kbd "C-f") 'isearch-forward)           ; previously forward-char (>C-d)

;; Links ;;
(define-key my-keys-minor-mode-map (kbd "C-c l") 'org-store-link)          ; previously NIL

;; Modes ;;
(define-key my-keys-minor-mode-map (kbd "C-c m a") 'auto-fill-mode)        ; previously NIL
(define-key my-keys-minor-mode-map (kbd "C-c m m") 'menu-bar-mode)         ; previously undo
(define-key my-keys-minor-mode-map (kbd "C-c m s") 'subword-mode)          ; previously NIL
(define-key my-keys-minor-mode-map (kbd "C-c m p") 'show-paren-mode)       ; previously NIL

;; Miscellaneous ;;
(define-key my-keys-minor-mode-map (kbd "C-c q") 'quoted-insert)
(define-key my-keys-minor-mode-map (kbd "C-x t") 'dfp/cycle-transparency)  ; previously NIL


;; Mode Setup ;;
(define-minor-mode my-keys-minor-mode
  "a minor mode so that my key settings override annoying major modes."
  t " my-keys" 'my-keys-minor-mode-map)
(my-keys-minor-mode 1)
