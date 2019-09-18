;; Adjusting Fonts ;;
(defun dfp/fonts-cjk-japanese ()
  (interactive)
  (set-fontset-font "fontset-default" 'han "TakaoExGothic"))
;; (defun dfp/fonts-cjk-chinese ()
;;   (interactive)
;;   (set-fontset-font "fontset-default" 'han ))

;; Monokai ;;
;; (setf custom-enabled-themes 'monokai)
;; (add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
;; (load-theme 'monokai t)
(load-file "~/.emacs.d/themes/monokai-theme.el")

;; Transparency ;;
(dfp/cycle-transparency)

;; Text-Appearance ;;
(setq-default fill-column 80)
(setq-default tab-width 4)
(set-fontset-font "fontset-default" 'kana "TakaoExGothic")
(dfp/fonts-cjk-japanese)
