;; Monokai ;;
(load-file "~/.emacs.d/themes/monokai-theme.el")

;; Cursor Color ;;
(add-to-list 'default-frame-alist '((cursor-color . "white")))

;; Transparency ;;
(dfp/set-default-frame-alpha (car dfp/quick-alphas))
(if (selected-frame) (dfp/set-frame-alpha (car dfp/quick-alphas)))

;; Text-Appearance ;;
(setq-default fill-column 90)
(setq-default tab-width 4)
;(set-face-attribute 'default t :font "DejaVu Sans Mono-10.5")
;(set-frame-font "DejaVu Sans Mono-10.5" nil t)

;; Scroll Bars
(add-to-list 'default-frame-alist '(vertical-scroll-bars . nil))
(add-to-list 'default-frame-alist '(horizontal-scroll-bars . nil))
