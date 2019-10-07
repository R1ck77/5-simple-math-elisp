(require 'cl)

(defun sm--format (a b)
  (format "%g + %g = %g
%g - %g = %g
%g * %g = %g
%g / %g = %g"
          a b (+ a b)
          a b (- a b)
          a b (* a b)
          a b (/ a b)))

(defun sm--read-number (prompt)
  (let ((number (read-number prompt)))
    (if (< number 0)
        (sm--read-number prompt)
      number)))

(defun simple-math ()
  (interactive)
  (insert
   (sm--format (sm--read-number "First number: ")
               (sm--read-number "Second number: "))))

(provide 'simple-math)
