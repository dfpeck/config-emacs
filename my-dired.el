;; Options for ls ;;
(setq dired-listing-switches "-lahLD")

(unless (string-match-p (regexp-quote "mingw")
                        (emacs-version))
  (setq dired-listing-switches
        (concat dired-listing-switches " --group-directories-first")))

;; Shell Command Defaults ;;
(setq dired-guess-shell-alist-user
      (list
       (list "\\.pdf$" "qpdfview --unique")
       (list "\\.epub$" "fbreader")
       (list "\\.odt$" "lowriter")
       (list "\\.docx?$" "lowriter")
       (list "\\.odp$" "loimpress")
       (list "\\.ods$" "localc")
       (list "\\.ppt$" "loimpress")
       (list "\\.tex$" "pdflatex")
       (list "\\.flac$" "clementine")
       (list "\\.mp3$" "clementine")
       (list "\\.mkv$" "smplayer")
       (list "\\.mp4$" "smplayer")
       (list "\\.avi$" "smplayer")
       (list "\\.html$" "firefox")
       (list "\\.xcf$" "gimp")
       (list "\\.png$" "pix")
       (list "\\.jpg$" "pix")
       (list "\\.gif$" "pix")
       (list "\\.cbr$" "comix")))

;; Omit Mode ;;
(setq-default dired-omit-files-p t) ; Buffer-local variable
(setq dired-omit-files (concat dired-omit-files "\\|^\\..+$"))

;; Asyncronous Copy Using rsync ;;
;; truongtx.me/2013/04/02/emacs-async-file-copying-in-dired-using-rsync/
(defun tmtxt/dired-rsync (dest)
  (interactive
   ;; offer dwim target as the suggestion
   (list (expand-file-name (read-file-name "Rsync to:" (dired-dwim-target-directory)))))
  ;; store all selected files into "files" list
  (let ((files (dired-get-marked-files nil current-prefix-arg)))
    ;; the rsync command
    (setq tmtxt/rsync-command "rsync -arvz --progress ")
    ;; add all selected file names as arguments to the rsync command
    (dolist (file files)
      (setq tmtxt/rsync-command
            (concat tmtxt/rsync-command
                    (shell-quote-argument file)
                    " ")))
    ;; append the destination
    (setq tmtxt/rsync-command
          (concat tmtxt/rsync-command
                  (shell-quote-argument dest)))
    ;; run the async shell command
    (async-shell-command tmtxt/rsync-command "*rsync*")
    ;; finally, switch to that window
    (other-window 1)))

;; Clementine Interaction ;;
(defun dfp/dired-clementine-append ()
  "Run 'clementine -a' on marked files.
See 'man clementine' for details."
  (interactive)
  (let ((files (dired-get-marked-files nil current-prefix-arg)))
    (dired-do-shell-command "clementine -a *" t files)))

(defun dfp/dired-clementine-load ()
  "Run 'clementine -l' on marked files.
See 'man clementine' for details."
  (interactive)
  (let ((files (dired-get-marked-files nil current-prefix-arg)))
    (dired-do-shell-command "clementine -l *" t files)))

;; Keybindings ;;
(with-eval-after-load "dired"
  ;; async copy
  (define-key dired-mode-map (kbd "@ C") 'tmtxt/dired-rsync)           ; previously unbound
  ;; mtp copy
  (define-key dired-mode-map (kbd "@ m") 'dired-mtp-sendfile)         ; previously unbound
  ;; copy full path to kill ring
  (define-key dired-mode-map (kbd "W")
    (lambda () (interactive) (dired-copy-filename-as-kill 0))))
  ;; clementine
  ;; (define-key dired-mode-map (kbd "c a") 'dfp/dired-clementine-append) ; previously unbound
  ;; (define-key dired-mode-map (kbd "c l") 'dfp/dired-clementine-load))  ; previously unbound
