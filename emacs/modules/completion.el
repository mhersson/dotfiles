;;; completion.el --- Completion configuration -*- lexical-binding: t -*-

;;; Commentary:

;; Completion setup with Vertico, Orderless, Marginalia, Consult, and icons.

;;; Code:

;; Vertico for vertical completion
(use-package vertico
  :config
  (vertico-mode 1))

;; Orderless for flexible matching
(use-package orderless
  :config
  (setq completion-styles '(orderless basic)
        completion-category-defaults nil
        completion-category-overrides '((file (styles partial-completion)))))

;; Marginalia for rich annotations in completions
(use-package marginalia
  :config
  (marginalia-mode 1))

;; Consult for enhanced commands and search
(use-package consult
  :config
  ;; Use consult-buffer for better buffer switching
  (setq consult-buffer-sources
        '(consult--source-hidden-buffer
          consult--source-modified-buffer
          consult--source-buffer
          consult--source-recent-file
          consult--source-bookmark
          consult--source-project-buffer-hidden
          consult--source-project-recent-file-hidden))

  ;; Configure consult to work with projectile
  (autoload 'projectile-project-root "projectile")
  (setq consult-project-function (lambda (_) (projectile-project-root)))

  ;; Configure consult to use fd for file finding
  (setq consult-find-args "fd --color=never --full-path"))

;; Corfu for completion
(use-package corfu
  :config
  (global-corfu-mode)
  (setq corfu-auto t
        corfu-auto-prefix 2
        corfu-quit-no-match 'separator)
  ;; Configure Tab and S-Tab for navigation
  (define-key corfu-map (kbd "TAB") 'corfu-next)
  (define-key corfu-map (kbd "<S-tab>") 'corfu-previous))

;; Add nerd-icons to corfu completion items
(use-package nerd-icons-corfu
  :ensure t
  :after corfu
  :config
  (add-to-list 'corfu-margin-formatters #'nerd-icons-corfu-formatter))


(provide 'completion)
;;; completion.el ends here
