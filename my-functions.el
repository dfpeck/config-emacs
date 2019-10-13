;; List Processing ;;
(defun dfp/lr-list (l)
  "Left-rotate a list non-destructively"
  (append (cdr l) (list (car l))))

(defmacro dfp/lr-list! (l)
  "Left rotate a list in place"
  `(setq ,l (dfp/lr-list ,l)))

(defmacro delete! (element list)
  "Delete an element from a list destructively"
  `(setq ,list (delete ,element ,list)))

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
(defvar dfp/base-frame-alphas (list 90 45))

(defun dfp/set-frame-alpha (new-alpha &optional frame)
  "Change the transparency of a frame

The transparency of FRAME will be set to NEW-ALPHA. Optional
parameter FRAME defaults to the result of `current-frame'.

If used interactively, this function may only be used to set the
transparency of the current frame."
  (interactive
   (list (if current-prefix-arg
             current-prefix-arg
           (read-number "Value: "))))
  (setq frame (if frame frame (selected-frame))) ; frame defaults to selected frame
  (set-frame-parameter frame 'alpha `(,new-alpha ,new-alpha)))

(defun dfp/set-default-frame-alpha (new-alpha)
  "Set the default frame transparency

NEW-ALPHA will be the transparency of all future frames. Existing
frames are not affected."
  (delete! (assoc 'alpha default-frame-alist) default-frame-alist)
  (add-to-list 'default-frame-alist `(alpha ,new-alpha ,new-alpha)))

(defun dfp/cycle-frame-alpha (&optional frame)
  (interactive)
  (dfp/set-frame-alpha (car dfp/base-frame-alphas) frame)
  (dfp/lr-list! dfp/base-frame-alphas))

(defun dfp/get-quick-alpha ()
  (string-to-number
   (single-key-description
    (read-key
     (apply 'concat
            "Select an alpha value: "
            (cl-loop for alpha-choice in dfp/base-frame-alphas
                     for i from 1 to (length dfp/base-frame-alphas)
                     collecting (format "[%d: %d%%]  " i alpha-choice)))))))

(defun dfp/set-frame-quick-alpha (alpha-choice &optional frame)
  (interactive
   (list
    (or current-prefix-arg (dfp/get-quick-alpha))
    nil))
  (dfp/set-frame-alpha (nth (1- alpha-choice) dfp/base-frame-alphas) frame))


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
