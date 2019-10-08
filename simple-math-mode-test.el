(require 'buttercup)
(setq load-path (cons "." load-path))
(require 'simple-math-mode)

(defconst expected-mode-name "*Interactive Simple Math*")

(describe "Simple Math Mode"
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
              (expect (buffer-live-p first-buffer) :to-be t))))))))
