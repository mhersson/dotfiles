;;; go.el --- Go language configuration -*- lexical-binding: t -*-

;;; Commentary:

;; Go-specific configuration including project detection and mode setup.

;;; Code:

;; Go specific settings

;; Go mode configuration

;; Go mode local leader keybindings (SPC m in go-ts-mode)
(defun setup-go-local-leader ()
  "Setup local leader keybindings for Go mode."
  ;; Add major mode group to which-key (buffer local)
  (which-key-add-major-mode-key-based-replacements 'go-ts-mode
    "SPC m" "go-mode"
    "SPC m t" "test")

  ;; Buffer-local which-key descriptions for Go local leader
  (which-key-add-major-mode-key-based-replacements 'go-ts-mode
    "SPC m t b" "run benchmark on current test"
    "SPC m t c" "run unit test coverage"
    "SPC m t r" "rerun latest"
    "SPC m t t" "run current test"
    "SPC m t f" "run file tests"
    "SPC m t p" "run package tests")

  ;; Go-specific keybindings using gotest functions
  (evil-define-key 'normal 'local
    (kbd "SPC m t b") 'go-test-current-benchmark
    (kbd "SPC m t c") 'go-test-current-coverage
    (kbd "SPC m t r") 'go-test-current-test-cache
    (kbd "SPC m t t") 'go-test-current-test
    (kbd "SPC m t f") 'go-test-current-file
    (kbd "SPC m t p") 'go-test-current-project))

(add-hook 'go-ts-mode-hook #'setup-go-local-leader)

;; Flycheck assumes that all suitable checkers are plugged in the LSP
;; server.  To run a normal flycheck-checker we set the
;; flycheck-eglot-exclusive to nil
(use-package go-mode
  :hook (go-ts-mode . (lambda ()
                        (setq flycheck-eglot-exclusive nil)
                        (eglot-ensure))))

;; Use flycheck-golangci-lint package
(use-package flycheck-golangci-lint
  :hook (go-ts-mode . flycheck-golangci-lint-setup))

(provide 'go)
;;; go.el ends here
