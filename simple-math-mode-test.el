(require 'buttercup)
(setq load-path (cons "." load-path))
(require 'simple-math-mode)

(defconst expected-mode-name "*Interactive Simple Math*")

(describe "Simple Math Mode"
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
