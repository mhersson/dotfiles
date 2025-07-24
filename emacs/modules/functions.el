;;; funvtions.el --- Language-agnostic test runner -*- lexical-binding: t -*-

;;; Commentary:

;; Custom functions

;;; Code:

(defun my/kill-other-buffers ()
  "Kill all buffers except the current one."
  (interactive)
  (mapc 'kill-buffer
        (delq (current-buffer) (buffer-list))))

(defun my/toggle-vterm ()
  "Toggle vterm window."
  (interactive)
  (if (get-buffer-window "*vterm*")
      (delete-window (get-buffer-window "*vterm*"))
    (vterm-other-window)))

;;; Functions to decode JWT
(defun my/b64pad (str)
  (let ((padlen (% (length str) 4)))
    (if (= padlen 0)
        str
      (concat str (make-string (- 4 padlen) ?=)))))
(defun my/b64-url-decode-string (str)
  (base64-decode-string (my/b64pad str)))
(defun my/b64-url-decode-region ()
  (interactive)
  (if (use-region-p)
      (let ((base (buffer-substring-no-properties (region-beginning) (region-end))))
        (replace-region-contents
         (region-beginning)
         (region-end)
         (lambda () (my/b64-url-decode-string base))))))

(defun my/decode-jwt ()
  "Decode JWT"
  (interactive)
  (if (use-region-p)
      (letrec ((token (buffer-substring-no-properties (region-beginning) (region-end)))
               (json-encoding-pretty-print t)
               (parts (split-string token "\\."))
               (head (json-encode (json-read-from-string (my/b64-url-decode-string (elt parts 0)))))
               (body (json-encode (json-read-from-string (my/b64-url-decode-string (elt parts 1)))))
               (sig  (elt parts 2)))
        (replace-region-contents
         (region-beginning)
         (region-end)
         (lambda () (format "## HEAD \n%s\n## BODY \n%s\n## SIG \n%s\n" head body sig))))))


(provide 'functions)
;;; funvtions.el ends here
