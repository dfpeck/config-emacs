;; Hide/Show Minor Mode ;;
(with-eval-after-load "hideshow"
  (define-key hs-minor-mode-map (kbd "C-c 2 2") 'hs-toggle-hiding) ; previously NOTHING
  (define-key hs-minor-mode-map (kbd "C-c 2 h") 'hs-hide-block)    ; previously NOTHING
  (define-key hs-minor-mode-map (kbd "C-c 2 s") 'hs-show-block)    ; previously NOTHING
  (define-key hs-minor-mode-map (kbd "C-c 2 L") 'hs-hide-level)    ; previously NOTHING
  (define-key hs-minor-mode-map (kbd "C-c 2 H") 'hs-hide-all)      ; previously NOTHING
  (define-key hs-minor-mode-map (kbd "C-c 2 S") 'hs-show-all))     ; previously NOTHING
