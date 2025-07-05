;;; treesitter.el --- Tree-sitter configuration -*- lexical-binding: t -*-

;;; Commentary:

;; Tree-sitter setup for modern syntax highlighting.

;;; Code:

;; tree-sitter settings (using built-in treesit)

;; Configure tree-sitter language sources
(setq treesit-language-source-alist
      '((go "https://github.com/tree-sitter/tree-sitter-go")
        (gomod "https://github.com/camdencheek/tree-sitter-go-mod")
        (python "https://github.com/tree-sitter/tree-sitter-python")
        (json "https://github.com/tree-sitter/tree-sitter-json")
        (yaml "https://github.com/tree-sitter-grammars/tree-sitter-yaml")
        (bash "https://github.com/tree-sitter/tree-sitter-bash")))

;; Auto-install missing tree-sitter grammars
(dolist (lang '(go gomod python json yaml bash))
  (unless (treesit-language-available-p lang)
    (treesit-install-language-grammar lang)))

;; Configure auto-mode-alist to use tree-sitter modes directly
(add-to-list 'auto-mode-alist '("Dockerfile.*\\'" . dockerfile-ts-mode))
(add-to-list 'auto-mode-alist '("\\.go\\'" . go-ts-mode))
(add-to-list 'auto-mode-alist '("\\.json\\'" . json-ts-mode))
(add-to-list 'auto-mode-alist '("\\.lua\\'" . lua-ts-mode))
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-ts-mode))
(add-to-list 'auto-mode-alist '("\\.sh\\'" . bash-ts-mode))
(add-to-list 'auto-mode-alist '("\\.yaml\\'" . yaml-ts-mode))
(add-to-list 'auto-mode-alist '("go\\.mod\\'" . go-mod-ts-mode))
(add-to-list 'auto-mode-alist '("go\\.work\\'" . go-mod-ts-mode))

;; Also set up major-mode-remap-alist as fallback
(setq major-mode-remap-alist
      '((dockerfile-mode . dockerfile-ts-mode)
        (go-mode . go-ts-mode)
        (js-json-mode . json-ts-mode)
        (json-mode . json-ts-mode)
        (lua-mode . lua-ts-mode)
        (python-mode . python-ts-mode)
        (sh-mode . bash-ts-mode)
        (yaml-mode . yaml-ts-mode)))

(provide 'treesitter)
;;; treesitter.el ends here
