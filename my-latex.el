(define-skeleton dfp/latex-skeleton-essay-frame
  "A latex document for essays"
  nil ;; don't use default prompt
  "\\documentclass[12pt]{article}" \n
  "\\usepackage[" (skeleton-read "Paper type:  " "letter")
  ", margin=" (skeleton-read "Margins:  " "1in")
  "]{geometry}" \n
  "\\setlength\\parindent{" (skeleton-read "Indent:  " "0.5in")
  "}" \n
  "\\pagenumbering{gobble}" \n ;; TODO --- make page numbering optional
  "\\renewcommand*\\rmdefault{ptm}" \n \n
  "\\begin{document}" \n \n
  "\\noindent" \n
  '(dfp/latex-skeleton-homework-header) \n \n
  "\\begin{center}" \n
  (skeleton-read "Title:  ") '(fill-paragraph) \n
  "\\end{center}" \n \n _ \n \n
  "\\end{document}")

(define-skeleton dfp/latex-skeleton-homework-frame
  "A latex document for homework assignments"
  nil ;; don't use default prompt
  "\\documentclass[12pt]{article}" \n
  "\\usepackage{enumerate}" \n
  ((skeleton-read "Header option:  ") str \n)
  "\\setlength\\parindent{0pt}" \n
  "\\pagenumbering{gobble}" \n
  "\\renewcommand*\\rmdefault{ptm}" \n \n
  "\\begin{document}" \n \n
  "Dakota Peck\\\\" \n
  (skeleton-read "Course: ") ", "
  (skeleton-read "Assignment name: ") "\\\\" \n
  (skeleton-read "Due date: ") "\\\\" \n \n
  "\\end{document}")

(define-skeleton dfp/latex-skeleton-enumerate-commented
  "A latex enumerated list with comments above each item."
  nil
  '(setq v1 0) ; iterator

  ;; determine numbering style ;;
  '(while (/= v1 -2)
     (setq v2 (skeleton-read "Numbering style: "))
     (setq v1 (1- (length v2))) ; we'll iterate backwards
     (while (>= v1 0) ; check each character in input for valid style
       (if (member (string-nth v1 v2) dfp/numerate-styles)
           (progn (setq v2 (cons (string-nth v1 v2)
                                 (concat (substring v2 0 v1)
                                         "%s"
                                         (substring v2 (1+ v1)))))
                  (setq v1 -2))
         (setq v1 (1- v1)))))

  "\\begin{enumerate}[" (format (cdr v2) (dfp/numerate (car v2) 1)) "]" \n

  ;; TODO get numbering style ;;
  

  ;; determine offset (if any) ;;
  ;; '(setq v1 (string-to-number (skeleton-read "Starting number: ")))
  ;; (if (not (= v1 0))
  ;;     (concat "\\setcounter{enumi}{" (number-to-string(1- v1)) "}\n")
  ;;   (setq v1 1)
  ;;   "") ; skeleton prints return value, so return empty string on 0

  \n
  ;; output items ;; TODO add manual numbering
  ((skeleton-read "Comment: ")
   "% " (format (cdr v2) (dfp/numerate (car v2) v1)) " " str '(fill-paragraph)
   '(latex-insert-item) \n \n
   '(setq v1 (1+ v1)))

  "\\end{enumerate}" (funcall indent-line-function))

(define-skeleton dfp/latex-skeleton-description-commented
  "A latex description list with comments above each item."
  nil
  "\\begin{description}" \n \n
  ((skeleton-read "Comment:  ") "% " str '(fill-paragraph)
   '(latex-insert-item) -1 "[" (skeleton-read "Label:  ") "]" \n \n)
  "\\end{description}" (indent-for-tab-command))


;; Keybindings ;;
(with-eval-after-load "tex-mode"
  (define-key latex-mode-map (kbd "C-c t h") 'dfp/latex-skeleton-homework-frame)
  (define-key latex-mode-map (kbd "C-c t e") 'dfp/latex-skeleton-enumerate-commented)
  (define-key latex-mode-map (kbd "C-c t d") 'dfp/latex-skeleton-description-commented))
