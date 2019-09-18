;; Hide/Show Minor Mode ;;
(with-eval-after-load "hideshow"
  (define-key hs-minor-mode-map (kbd "C-c @ @") 'hs-toggle-hiding)) ; previously NOTHING
