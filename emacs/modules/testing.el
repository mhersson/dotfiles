;;; testing.el --- Language-agnostic test runner -*- lexical-binding: t -*-

;;; Commentary:

;; A flexible test runner that can be configured for different languages.
;; Currently supports Go, but designed to be easily extensible.

;;; Code:

(require 'compile)

;; Go test package with dependency fix
(use-package go-mode
  :after eglot
  :config
  ;; We need go-mode functions even if we use go-ts-mode for editing
  nil)

(use-package gotest
  :after go-mode
  :config
  ;; gotest should work with go-ts-mode automatically
  nil)

;; Placeholder for future non-Go test runners
;; Go testing is handled by the go-test package above
;; When adding other languages, consider using dedicated packages like:
;; - python-pytest for Python
;; - jest-test-mode for JavaScript
;; - etc.

(provide 'testing)
;;; testing.el ends here
