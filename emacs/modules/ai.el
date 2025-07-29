;;; ai.el --- AI Emacs settings -*- lexical-binding: t -*-

;;; Commentary:

;; AI Emacs configuration - copilot

;;; AI:

;; Copilot - AI pair programmer
(use-package copilot
  :vc (:url "https://github.com/copilot-emacs/copilot.el"
            :branch "main"))

(define-key copilot-completion-map (kbd "C-<return>") 'copilot-accept-completion)
(setq copilot-lsp-settings '(:github-enterprise (:uri "https://dnb.ghe.com")))
(setq copilot-max-char 300000)  ; Increase max file size for completions
(setq copilot-indent-offset-warning-disable t)  ; Disable indentation warnings
(add-hook 'prog-mode-hook 'copilot-mode)
(add-hook 'markdown-mode-hook 'copilot-mode)
(add-hook 'yaml-mode-hook 'copilot-mode)

;; Copilot Chat
(use-package copilot-chat
  :straight (:host github :repo "mhersson/copilot-chat.el" :files ("*.el"))
  :init
  (setq copilot-chat-backend 'curl)
  (setq copilot-chat-frontend 'markdown)
  (setq copilot-chat-enterprise-uri "https://dnb.ghe.com")
  (setq copilot-chat-default-model "claude-sonnet-4")
  :after markdown-mode)

;; Claude Code IDE
(use-package claude-code-ide
  :straight (:type git :host github :repo "manzaltu/claude-code-ide.el")
  :bind ("C-c C-'" . claude-code-ide-menu) ; Set your favorite keybinding
  :config
  (claude-code-ide-emacs-tools-setup)) ; Optionally enable Emacs MCP tools

(provide 'ai)
;;; ai.el ends here
