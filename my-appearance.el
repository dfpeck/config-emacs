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

;; Cursor Color ;;
(setq default-frame-alist '((cursor-color . "white")))

;; Transparency ;;
(dfp/set-default-frame-alpha (car dfp/base-frame-alphas))

;; Text-Appearance ;;
(setq-default fill-column 80)
(setq-default tab-width 4)
(set-fontset-font "fontset-default" 'kana "TakaoExGothic")
(let ((font-size
       ;; Use font size 9 on Windows
       (if (string-match-p (regexp-quote "mingw") (emacs-version)) "9"
         ;; Use font size 10 elsewhere
         "10.5")))
  (add-to-list 'default-frame-alist `(font . ,(concat "DejaVu Sans Mono-" font-size))))
(dfp/fonts-cjk-japanese)

;; Scroll Bars ;;
(defun dfp/disable-scroll-bars (frame)
  (modify-frame-parameters frame
                           '((vertical-scroll-bars . nil)
                             (horizontal-scroll-bars . nil))))
(add-hook 'after-make-frame-functions 'dfp/disable-scroll-bars)

;; Comment Sytle ;;
;; (setq comment-style 'multi-line)
