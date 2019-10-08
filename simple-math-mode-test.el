(require 'buttercup)
(setq load-path (cons "." load-path))
(require 'simple-math-mode)

(defconst expected-mode-name "*Interactive Simple Math*")

(describe "simple-math-mode.el"
  (describe "simple-math-mode"
    (it "turns the current buffer to the specified mode"
      (with-temp-buffer
        (simple-math-mode)
        (expect major-mode :to-be 'simple-math-mode)
        (expect mode-name :to-equal expected-mode-name)))
    (it "will erase the current buffer and write a template"
      (with-temp-buffer
        (simple-math-mode)
        (expect (buffer-substring (point-min) (point-max))
                :to-equal "1 + 1 = 2
1 - 1 = 0
1 * 1 = 1
1 / 1 = 1"))))
  (describe "smm-quit"
    (it "will do nothing on the wrong buffer"
      (with-temp-buffer
        (simple-math-mode)
        (let ((first-buffer (current-buffer)))
          (with-temp-buffer
            (let ((second-buffer (current-buffer)))
              (smm-quit)
              (expect (buffer-live-p second-buffer) :to-be t)
              (expect (buffer-live-p first-buffer) :to-be t))))))
    (it "will kill the current buffer, if in simple-math-mode"
      (with-temp-buffer
        (let ((first-buffer (current-buffer)))
          (with-temp-buffer
            (simple-math-mode)
            (let ((second-buffer (current-buffer)))
              (smm-quit)
              (expect (buffer-live-p second-buffer) :not :to-be t)
              (expect (buffer-live-p first-buffer) :to-be t)))))))
  (describe "smm-read-first-number"
    (it "will do nothing on the wrong buffer"
      (spy-on 'read-number)
      (smm-read-first-number)
      (expect 'read-number :not :to-have-been-called))
    (it "will make the current content change"
      (with-temp-buffer
        (simple-math-mode)
        (spy-on 'read-number :and-return-value 12)
        (smm-read-first-number)
        (expect 'read-number :to-have-been-called)
        (expect (buffer-substring (point-min) (point-max))
                :to-equal "12 + 1 = 13
12 - 1 = 11
12 * 1 = 12
12 / 1 = 12"))))
  (describe "smm-read-second-number"
    (it "will do nothing on the wrong buffer"
      (spy-on 'read-number)
      (smm-read-second-number)
      (expect 'read-number :not :to-have-been-called)))
    (it "will make the current content change"
      (with-temp-buffer
        (simple-math-mode)
        (spy-on 'read-number :and-return-value 12.0)
        (smm-read-second-number)
        (expect 'read-number :to-have-been-called)
        (expect (buffer-substring (point-min) (point-max))
                :to-equal "1 + 12 = 13
1 - 12 = -11
1 * 12 = 12
1 / 12 = 0.0833333"))))
