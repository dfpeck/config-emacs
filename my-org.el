(define-skeleton dfp/org-skeleton-notes-frame
  "An org file for class notes"
  nil
  "#+TITLE: " (skeleton-read "Title: ") \n
  (when (string= (skeleton-read "Math notes? (y/n): ") "y")
    (concat 
     "#+LATEX_CLASS_OPTIONS: [fleqn] \n" ; align equations left in LaTeX output
     "#+HTML_MATHJAX: align:\"left\""    ; align equations left in HTML output
     " path:\""
     (skeleton-read "Path to MathJax.js: " "/usr/share/javascript/mathjax/MathJax.js")
     "\" \n"))
  "* " _ '(whitespace-cleanup))

(with-eval-after-load "org-mode"
  (define-key org-mode-map (kbd "C-c t n") 'dfp/org-skeleton-notes-frame))
