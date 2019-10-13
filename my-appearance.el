;; Monokai ;;
(load-file "~/.emacs.d/themes/monokai-theme.el")

;; Cursor Color ;;
(add-to-list 'default-frame-alist '((cursor-color . "white")))

;; Transparency ;;
(dfp/set-default-frame-alpha (car dfp/quick-alphas))

;; Text-Appearance ;;
(setq-default fill-column 80)
(setq-default tab-width 4)

;; Scroll Bars
(add-to-list 'default-frame-alist '(vertical-scroll-bars . nil))
(add-to-list 'default-frame-alist '(horizontal-scroll-bars . nil))
