(require 'cl)
(require 'buttercup)
(setq load-path (cons "." load-path))
(require 'simple-math)

(defun create-fake-read-number (results)
  (lexical-let ((results results))
    (lambda (prompt)
      (let ((current-result (first results)))
        (setq results (rest results))
        current-result))))

(describe "simple-math.el"
  (describe "simple-math"
    (it "asks the user for two numbers"
      (let ((results))
        (spy-on 'read-number :and-return-value 1)
        (simple-math)
        (expect (spy-calls-all-args 'read-number)
                :to-equal '(("First number: ")
                         ("Second number: ")))))
    (it "prints the results of all arithmetic operations in the current buffer"
      (let ((expected-result "10 + 5 = 15
10 - 5 = 5
10 * 5 = 50
10 / 5 = 2"))
        (with-temp-buffer
          (spy-on 'read-number :and-call-fake (create-fake-read-number '(10 5)))
          (simple-math)
          (expect (buffer-substring (point-min) (point-max))
                  :to-equal expected-result)
          (expect (point) :to-be (+ (length expected-result) 1)))))
    (it "discards the negative values returned"
      (let ((expected-result "10 + 5 = 15
10 - 5 = 5
10 * 5 = 50
10 / 5 = 2"))
        (with-temp-buffer
          (spy-on 'read-number :and-call-fake (create-fake-read-number '(-1 -2 -3.3 10 -72.3 -8.5 5)))
          (simple-math)
          (expect (buffer-substring (point-min) (point-max))
                  :to-equal expected-result)
          (expect (point) :to-be (+ (length expected-result) 1)))))    ))
