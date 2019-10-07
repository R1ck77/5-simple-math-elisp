
(defun sm--format (a b)
  (format "%g + %g = %g
%g - %g = %g
%g * %g = %g
%g / %g = %g"
          a b (+ a b)
          a b (- a b)
          a b (* a b)
          a b (/ a b)))

(defun simple-math ()
  (interactive)
  (insert
   (sm--format (read-number "First number: ")
               (read-number "Second number: "))))

(provide 'simple-math)
