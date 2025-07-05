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
;; (add-hook 'prog-mode-hook 'copilot-mode)
;; (add-hook 'markdown-mode-hook 'copilot-mode)

(provide 'ai)
;;; ai.el ends here
