;;; markdown.el --- Markdown language configuration -*- lexical-binding: t -*-

;;; Commentary:

;; Markdown-specific configuration.

;;; Code:

;; Markdown mode
(use-package markdown-mode
  :mode (("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode)
         ("README\\.md\\'" . gfm-mode))
  :config
  (setq markdown-command "multimarkdown"
        markdown-fontify-code-blocks-natively t))

;; Flycheck assumes that all suitable checkers are plugged in the LSP
;; server.  To run a normal flycheck-checker we set the
;; flycheck-eglot-exclusive to nil
(use-package markdown-mode
  :hook ((markdown-mode gfm-mode) . (lambda ()
                                      (setq flycheck-eglot-exclusive nil)
                                      (eglot-ensure))))

;; Flycheck markdownlint-cli2 checker
(flycheck-define-checker markdownlint-cli2
  "A Markdown linter using markdownlint-cli2."
  :command ("markdownlint-cli2" source)
  :error-patterns
  ((warning line-start (file-name) ":" line ":" column " " (message) line-end)
   (warning line-start (file-name) ":" line " " (message) line-end))
  :modes (markdown-mode gfm-mode))

(add-to-list 'flycheck-checkers 'markdownlint-cli2)

;; MPLS language server for markdown
(defun mpls-open-preview ()
  "Open preview of current buffer using Eglot."
  (interactive)
  (if (not (or (derived-mode-p 'markdown-mode)
               (derived-mode-p 'gfm-mode)))
      (message "This command is only available in markdown buffers")
    (when (eglot-current-server)
      (eglot-execute-command (eglot-current-server) "open-preview" nil))))

(defun setup-markdown-local-leader ()
  "Setup local leader keybindings for Markdown modes."
  (let ((mode-name (if (derived-mode-p 'gfm-mode) "gfm-mode" "markdown-mode"))
        (current-mode (if (derived-mode-p 'gfm-mode) 'gfm-mode 'markdown-mode)))
    ;; Add major mode group to which-key (buffer local)
    (which-key-add-major-mode-key-based-replacements current-mode
      "SPC m" mode-name
      "SPC m p" "open preview")
    ;; Markdown-specific keybinding
    (evil-define-key 'normal 'local
      (kbd "SPC m p") 'mpls-open-preview)))

;; Add hooks for both modes
(add-hook 'markdown-mode-hook #'setup-markdown-local-leader)
(add-hook 'gfm-mode-hook #'setup-markdown-local-leader)

;; Add mpls to eglot server programs
(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs
               '((markdown-mode gfm-mode) .
                 ("mpls" "--dark-mode" "--enable-emoji" "--enable-footnotes"
                  "--plantuml-server" "localhost:8080" "--plantuml-path" "/"
                  "--plantuml-disable-tls"))))

;; Send mpls/editorDidChangeFocus events
(defvar last-focused-markdown-buffer nil)

(defun send-markdown-focus-notification ()
  (when (and (memq major-mode '(markdown-mode gfm-mode))
             (not (eq (current-buffer) last-focused-markdown-buffer))
             (eglot-current-server))
    (setq last-focused-markdown-buffer (current-buffer))
    (let* ((file-name (buffer-file-name))
           (uri (eglot-path-to-uri file-name)))
      (jsonrpc-notify (eglot-current-server) :mpls/editorDidChangeFocus
                      (list :uri uri :fileName file-name)))))

(add-hook 'buffer-list-update-hook
          (lambda ()
            (when (and (memq major-mode '(markdown-mode gfm-mode))
                       (eq (current-buffer) (window-buffer (selected-window)))
                       (buffer-file-name))
              (send-markdown-focus-notification))))

(provide 'markdown)

;;; markdown.el ends here
