(require 'cl)

(defconst operations '(+ - * /))

(defun sm--read-number (prompt)
  (let ((number (read-number prompt)))
    (if (< number 0)
        (sm--read-number prompt)
      number)))

(defun sm--do-interpose (seq sep)
  (let* ((tmp (reverse seq))
        (result (list (first tmp)))
        (source (rest tmp)))
    (while source
      (setq result (cons (first source) (cons sep result)))
      (setq source (rest source)))
    result))

(defun interpose (sep seq)
  (cond
   ((< (length seq) 2) seq)
   (:otherwise (sm--do-interpose seq sep))))

(defun simple-math ()
  (interactive)
  (let* ((a (sm--read-number "First number: "))
         (b (sm--read-number "Second number: "))
         (format-string (format "%g %%s %g = %%g" a b)))
    (insert
     (reduce 'concat
             (interpose "\n" (mapcar (lambda (x)
                                (format format-string (first x) (second x)))
                              (mapcar (lambda (x) (list (symbol-name x)
                                                        (funcall x a b)))
                                      operations)))))))

(provide 'simple-math)
