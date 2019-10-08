(setq load-path (cons "." load-path))
(require 'simple-math)

(defconst smm--buffer-name "*Interactive Simple Math*"
  "Name of the buffer")

(defvar simple-math-mode nil
  "Mode variable for the \"Simple Math\" exercise")

(defvar simple-math-mode-map nil
  "Keymap for the \"Simple Math\" exercise")

(defvar simple-math-first-value 1)
(make-variable-buffer-local 'simple-math-first-value)
(defvar simple-math-second-value 1)
(make-variable-buffer-local 'simple-math-second-value)

(defun smm-quit ()
  (interactive)
  (if (eq major-mode 'simple-math-mode)
      (kill-buffer)))

(defun smm--update-buffer ()
  (erase-buffer)
  (sm--print-simple-math-results (list simple-math-first-value
                                       simple-math-second-value)))

(defun smm-read-first-number ()
  (interactive)
  (when (eq major-mode 'simple-math-mode)
    (setq simple-math-first-value (sm--read-first-number))
    (smm--update-buffer)))

(defun smm-read-second-number ()
  (interactive)
  (when (eq major-mode 'simple-math-mode)
    (setq simple-math-second-value (sm--read-second-number))
    (smm--update-buffer)))

(unless simple-math-mode-map
  (setq simple-math-mode-map (make-sparse-keymap))
  (define-key simple-math-mode-map "1" 'smm-read-first-number)
  (define-key simple-math-mode-map "2" 'smm-read-second-number)
  (define-key simple-math-mode-map "q" 'smm-quit))

(defun smm--setup ()
  (font-lock-mode)
  (use-local-map simple-math-mode-map)
  (setq simple-math-first-value 1)
  (setq simple-math-second-value 1)
  (smm--update-buffer))

(defun simple-math-mode ()
  "Interactive version of the \"Simple Math\" exercise"
  (interactive)
  (kill-all-local-variables)
  (setq major-mode 'simple-math-mode)
  (setq mode-name smm--buffer-name)
  (smm--setup))

(provide 'simple-math-mode)
