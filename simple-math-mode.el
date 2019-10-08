(require 'simple-math)

(defvar simple-math-mode nil
  "Mode variable for the \"Simple Math\" exercise")

(defvar simple-math-mode-map nil
  "Keymap for the \"Simple Math\" exercise")

(defun smm-quit ()
  (interactive)
  (kill-buffer))

(defun smm-read-first-number ()
  (interactive))

(defun smm-read-second-number ()
  (interactive))

(unless simple-math-mode-map
  (setq simple-math-mode-map (make-sparse-keymap))
  (define-key count-words-mode-map "1" 'smm-read-first-number)
  (define-key count-words-mode-map "2" 'smm-read-second-number)
  (define-key count-words-mode-map "q" 'smm-quit))

(defun smm--setup ()
  (font-lock-mode)
  (erase-buffer)
  (use-local-map simple-math-mode-map))

(defun simple-math-mode ()
  "Interactive version of the \"Simple Math\" exercise"
  (interactive)
  (kill-all-local-variables)
  (setq major-mode 'simple-math-mode)
  (setq mode-name "*Interactive Simple Math*"))

(provide 'simple-math-mode)
