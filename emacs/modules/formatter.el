;;; formatter.el --- Code formatting configuration -*- lexical-binding: t -*-

;;; Commentary:
;; This module contains configuration for code formatting using Apheleia.
;; Apheleia provides automatic code formatting on save with support for
;; many formatters and programming languages.

;;; Code:

;; Apheleia - Async code formatting
(use-package apheleia
  :ensure t
  :config
  ;; Enable apheleia globally
  (apheleia-global-mode +1)

  ;; Configure gofumpt for Go files
  (add-to-list 'apheleia-formatters
               '(gofumpt . ("gofumpt")))
  (add-to-list 'apheleia-mode-alist
               '(go-ts-mode . gofumpt))

  ;; Configure prettier for markdown files
  (add-to-list 'apheleia-formatters
               '(prettier-markdown . ("prettier" "--parser" "markdown" "--prose-wrap" "always")))

  (add-to-list 'apheleia-mode-alist
               '(markdown-mode . prettier-markdown))

  ;; Configure yamlfmt for YAML files
  (add-to-list 'apheleia-formatters
               '(yamlfmt . ("yamlfmt" "-")))

  (add-to-list 'apheleia-mode-alist
               '(yaml-ts-mode . yamlfmt))
  )

;; YAML mode configuration
(add-hook 'yaml-ts-mode-hook
          (lambda ()
            ;; Set appropriate indentation
            (setq-local indent-tabs-mode nil)
            (setq-local tab-width 2)))

(provide 'formatter)
;;; formatter.el ends here
