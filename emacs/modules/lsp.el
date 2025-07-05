;;; lsp.el --- LSP configuration -*- lexical-binding: t -*-

;;; Commentary:

;; Language Server Protocol setup with Eglot.

;;; Code:

;; eglot settings

(defun eglot-format-buffer-before-save ()
  "Add format-on-save hook for current buffer."
  (add-hook 'before-save-hook #'eglot-format-buffer -10 t))

(defun eglot-organize-imports-before-save ()
  "Add organize-imports-on-save hook for current buffer."
  (add-hook 'before-save-hook (lambda ()
                                (call-interactively #'eglot-code-action-organize-imports))
            nil t))

(use-package eglot
  :ensure t
  :config
  ;; We want to use treesit-simple-imenu for imenu index creation
  (add-to-list 'eglot-stay-out-of 'imenu)

  ;; Shutdown LSP server when last project buffer is closed as well
  (setq eglot-autoshutdown t)

  ;; Enable eglot for the following modes
  (dolist (mode '(go-ts-mode-hook markdown-mode-hook gfm-mode-hook bash-ts-mode-hook yaml-ts-mode-hook))
    (add-hook mode 'eglot-ensure))

  ;; Buffer-local hooks which install before-save hooks
  (add-hook 'go-ts-mode-hook #'eglot-organize-imports-before-save))

(provide 'lsp)
;;; lsp.el ends here
