;; List Processing ;;
(defun dfp/lr-list (l)
  "Left-rotate a list and return the result"
  (append (cdr l) (list (car l))))

;; (defun dfp/rr-list (l)
;;   "Right-rotate a list and return the result"
;;   (append (last l) (!!)))


;; Buffer Browsing Functions ;;
(defun dfp/scroll-down ()
  (interactive)
  (scroll-up 1))

(defun dfp/scroll-up ()
  (interactive)
  (scroll-down 1))


;; Frame Transparency ;;
(defvar dfp/transparencies (list 90 45))
(setf dfp/transparencies (list 85 45))

(defun dfp/set-transparency (new-alpha)
  (set-frame-parameter (selected-frame) 'alpha `(,new-alpha ,new-alpha))
  (add-to-list 'default-frame-alist `(alpha ,new-alpha ,new-alpha)))

(defun dfp/cycle-transparency ()
  (interactive)
  (dfp/set-transparency (car dfp/transparencies))
  (setq dfp/transparencies (dfp/lr-list dfp/transparencies)))


;; Async Shell Command Execution in Named Buffer ;;
(defun dfp/async-shell-command (command &optional output-buffer error-buffer)
  "Execute string COMMAND asynchronously in the background.

Like `async-shell-command', but allows the user to specify the
OUTPUT-BUFFER interactively if the prefix argument is non-nil."
  (interactive
   (list
    (read-shell-command "Async shell command: " nil nil
			(let ((filename
			       (cond
				(buffer-file-name)
				((eq major-mode 'dired-mode)
				 (dired-get-filename nil t)))))
			  (and filename (file-relative-name filename))))
    (if current-prefix-arg
        (read-buffer "Output buffer: "))
    shell-command-default-error-buffer))
  (unless (string-match "&[ \t]*\\'" command)
    (setq command (concat command " &")))
  (shell-command command output-buffer error-buffer))


;; String Functions ;;
(defun string-nth (n string)
  "Return the Nth element of STRING."
  (substring string n (1+ n)))

(defun string-position (a string)
  "Return the first position of character A in STRING."
  (cl-position (string-to-char a) (cl-loop for c across string collecting c)))


;; Numeration Functions ;;
(defconst dfp/numerate-styles '("a" "A" "i" "I" "1")
  "Valid styles for dfp/numerate. Each does more or less exactly
  what you would expect.")

(defconst roman-numeral-values `(("M" . 1000) ("CM" . 900)
				 ("D" . 500) ("CD" . 400)
				 ("C" . 100) ("XC" . 90)
				 ("L" . 50) ("XL" . 40)
				 ("X" . 10) ("IX" . 9)
				 ("V" . 5) ("IV" . 4)
				 ("I" . 1))
  "The value of each symbol used in roman numerals. Values
  represented with a subtractive component (IV, IX, XL, etc.)
  are considered their own symbol.")

(defun dfp/alphabet-to-number (a)
  ""
  (string-position (downcase a) "abcdefghijklmnopqrstuvwxyz")) ; TODO

(defun dfp/number-to-alphabet (n)
  "Returns the Nth lower-case numerated letter."
  (setq n (- n 1)) ; parameter indexes from 1, so we need to convert it
  (if (< n 26)
      (char-to-string (+ ?a n))
    (concat (dfp/number-to-alphabet (/ n 26)) (char-to-string(+ ?a (mod n 26))))))

(defun dfp/number-to-roman (n)
  "Return the roman numeral representation of N.

If N contains a fractional value, it will be truncated. If N is
less than 1, the function returns an empty string."
  (let
      (counter this-car this-cdr return-val)
    (if (< n 1)
        (setq return-val "")
      (setq counter 0)
      (while (< counter (length roman-numeral-values))
        (setq this-car (car (nth counter roman-numeral-values)))
        (setq this-cdr (cdr (nth counter roman-numeral-values)))
        (if (>= n this-cdr)
            (progn (setq counter (length roman-numeral-values))
                   (setq return-val
                         (concat this-car (dfp/number-to-roman (- n this-cdr)))))
          (setq counter (+ counter 1)))))
    return-val))

(defun dfp/numerate (style n)
  "Returns a string representing the Nth element of the series of
numeration methods represented by STYLE. Valid styles are a, A,
i, I, and 1."
  (cond ((str= style "a")
         (dfp/number-to-alphabet n))
        ((str= style "A")
         (upcase (dfp/number-to-alphabet n)))
        ((str= style "i")
         (downcase (dfp/number-to-roman n)))
        ((str= style "I")
         (dfp/number-to-roman n))
        ((str= style "1")
         n)))
