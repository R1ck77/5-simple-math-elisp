(setq load-path (cons "." load-path))
(require 'simple-math)

(defconst smm--buffer-name "*Interactive Simple Math*"
  "Name of the buffer")

(defvar simple-math-mode nil
  "Mode variable for the \"Simple Math\" exercise")

(defvar simple-math-mode-map nil
  "Keymap for the \"Simple Math\" exercise")

(defun smm-quit ()
  (interactive)
  (if (eq major-mode 'simple-math-mode)
      (kill-buffer)))

(defun smm-read-first-number ()
  (interactive))

(defun smm-read-second-number ()
  (interactive))

(unless simple-math-mode-map
  (setq simple-math-mode-map (make-sparse-keymap))
  (define-key simple-math-mode-map "1" 'smm-read-first-number)
  (define-key simple-math-mode-map "2" 'smm-read-second-number)
  (define-key simple-math-mode-map "q" 'smm-quit))

(defun smm--update-buffer (a b)
  (erase-buffer)
  (insert "1 + 1 = 2
1 - 1 = 0
1 * 1 = 1
1 / 1 = 1"))

(defun smm--setup ()
  (font-lock-mode)
  (use-local-map simple-math-mode-map)
  (smm--update-buffer 1 1))

(defun simple-math-mode ()
  "Interactive version of the \"Simple Math\" exercise"
  (interactive)
  (kill-all-local-variables)
  (setq major-mode 'simple-math-mode)
  (setq mode-name smm--buffer-name)
  (smm--setup))

(provide 'simple-math-mode)
