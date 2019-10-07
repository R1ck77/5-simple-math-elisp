(require 'cl)

(defconst operations '(+ - * /))

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

(defun sm--merge-strings (seq)
  (reduce 'concat (interpose "\n" seq)))

(defun sm--represent-result (format-string name-result-seq)
  (mapcar (lambda (x)
            (apply 'format format-string x))
          name-result-seq))

(defun sm--apply-operation (operation values)
  (funcall operation
           (first values)
           (second values)))

(defun sm--operations-results (values)
  (mapcar (lambda (x)
            (list (symbol-name x)
                  (sm--apply-operation x values)))
          operations))

(defun sm--read-number (prompt)
  (let ((number (read-number prompt)))
    (if (< number 0)
        (sm--read-number prompt)
      number)))

(defun sm--read-numbers ()
  (list (sm--read-number "First number: ")
        (sm--read-number "Second number: ")))

(defun simple-math ()
  (interactive)
  (let ((values (sm--read-numbers)))
   (insert
    (sm--merge-strings
     (sm--represent-result (apply 'format "%g %%s %g = %%g" values)
                           (sm--operations-results values))))))

(provide 'simple-math)
