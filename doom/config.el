;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

(defun autobots-rules-greater ()
  (let* ((banner '(
"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⣠⣤⣤⣶⣶⣶⣶⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣶⣶⣶⣤⣤⣤⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
"⠠⣤⣤⣤⣤⣄⣀⣀⣀⣀⠀⠀⣠⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣤⠀⠀⢀⣀⣀⣀⣀⣤⣤⣤⣤⠄"
"⠀⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀⠀⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⠀⠀⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀"
"⠀⢸⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀⠸⣿⣿⣿⣿⣿⣿⣿⣯⣍⡉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⢉⣩⣿⣿⣿⣿⣿⣿⣿⣿⠃⠀⢰⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀"
"⠀⠈⣿⣿⣿⣿⠻⢿⣿⣿⣿⡀⠀⠙⠻⣿⣿⣿⣿⣿⣿⣿⣿⣶⣄⠀⠀⠀⠀⠀⠀⠀⢀⣠⣶⣿⣿⣿⣿⣿⣿⣿⡿⠟⠉⠀⢀⣼⣿⣿⣿⠟⢻⣿⣿⣿⠁⠀"
"⠀⠀⢹⣿⣿⣿⣄⡀⠉⠻⣿⣿⣷⣤⣀⠀⠙⠻⣿⣿⣿⣿⣿⣿⣿⣿⣦⣄⠀⢀⣠⣶⣿⣿⣿⣿⣿⣿⣿⣿⠟⠋⠀⣀⣤⣾⣿⣿⠟⠋⢀⣠⣿⣿⣿⡏⠀⠀"
"⠀⠀⠘⣿⣿⣿⣿⣿⣶⣄⡀⠉⠻⣿⣿⣷⣦⣄⠀⠙⠻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠟⠋⠀⣠⣴⣾⣿⣿⠟⠋⢀⣠⣶⣿⣿⣿⣿⣿⠃⠀⠀"
"⠀⠀⠀⢻⣿⣿⣧⠈⠛⢿⣿⣶⣄⡀⠙⠻⣿⣿⣿⣶⣄⡈⠙⠿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠟⠋⢀⣠⣴⣿⣿⣿⠟⠋⠀⣠⣶⣿⡿⠛⠁⣸⣿⣿⡟⠀⠀⠀"
"⠀⠀⠀⠸⣿⣿⣿⣷⣦⣀⠈⠛⢿⣿⣶⣄⡀⠙⣿⣿⣿⣷⠀⠀⡈⠙⠿⣿⣿⣿⣿⠿⠋⢀⠀⠀⣾⣿⣿⣿⠋⠀⣠⣶⣿⡿⠛⠁⢀⣤⣾⣿⣿⣿⠃⠀⠀⠀"
"⠀⠀⠀⠀⢿⣿⣿⣿⣿⣿⣷⣦⣀⠈⠛⢿⣿⣶⣼⣿⣿⣿⡀⠀⢹⣶⣄⠈⠙⠋⠁⣠⣴⡿⠀⢀⣿⣿⣿⣿⣴⣿⡿⠟⠉⢀⣤⣾⣿⣿⣿⣿⣿⡿⠀⠀⠀⠀"
"⠀⠀⠀⠀⠀⠙⠻⣿⣿⣿⣿⣿⣿⣷⣦⣀⠈⠛⢿⣿⣿⣿⡇⠀⢸⣿⣿⣿⣦⣴⣿⣿⣿⡇⠀⢸⣿⣿⣿⡿⠛⠉⢀⣤⣾⣿⣿⣿⣿⣿⣿⠿⠋⠀⠀⠀⠀⠀"
"⠀⠀⠀⠀⠀⠀⡀⠈⠙⢿⣿⣿⣿⣿⣿⣿⣷⣦⡀⣿⣿⣿⣷⠀⠈⣿⣿⣿⣿⣿⣿⣿⣿⠇⠀⣾⣿⣿⣿⢀⣤⣾⣿⣿⣿⣿⣿⣿⡿⠛⠁⢀⡀⠀⠀⠀⠀⠀"
"⠀⠀⠀⠀⠀⠀⣿⣷⣤⡀⠉⠻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡀⠀⣿⣿⣿⣿⣿⣿⣿⣿⠀⢀⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠟⠉⢀⣠⣶⣿⠀⠀⠀⠀⠀⠀"
"⠀⠀⠀⠀⠀⠀⣿⣿⣿⣿⣶⠀⠀⠀⠈⠉⠉⠛⠛⠛⠿⠿⢿⡇⠀⢹⣿⣿⣿⣿⣿⣿⣿⠀⢸⡿⠿⠿⠛⠛⠛⠉⠉⠁⠀⠀⠀⣶⣿⣿⣿⣿⠀⠀⠀⠀⠀⠀"
"⠀⠀⠀⠀⠀⠀⣿⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⣿⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣿⣿⣿⣿⣿⠀⠀⠀⠀⠀⠀"
"⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⣿⣿⣷⣄⡀⠀⠀⠀⠀⢀⣠⣴⣾⡇⠀⢸⣿⣿⣿⣿⣿⣿⣿⠀⢸⣷⣦⣄⡀⠀⠀⠀⠀⠀⣠⣶⣿⣿⣿⣿⣿⡟⠀⠀⠀⠀⠀⠀"
"⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⣿⣿⣿⣿⣿⡆⠀⢰⣾⣿⣿⣿⣿⡇⠀⢸⣿⣿⣿⣿⣿⣿⣿⠀⢸⣿⣿⣿⣿⣷⡆⠀⢰⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀"
"⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀⢸⣿⣿⣿⣿⣿⡇⠀⢸⣿⣿⣿⣿⣿⣿⣿⠀⢸⣿⣿⣿⣿⣿⡇⠀⢸⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀"
"⠀⠀⠀⠀⠀⠀⠈⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀⢸⣿⣿⣿⣿⣿⡇⠀⢸⣿⣿⣿⣿⣿⣿⣿⠀⢸⣿⣿⣿⣿⣿⡇⠀⢸⣿⣿⣿⣿⣿⣿⣿⣿⠇⠀⠀⠀⠀⠀⠀"
"⠀⠀⠀⠀⠀⠀⠀⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀⢸⣿⣿⣿⣿⣿⡇⠀⢸⣿⣿⣿⣿⣿⣿⣿⠀⢸⣿⣿⣿⣿⣿⡇⠀⢸⣿⣿⣿⣿⣿⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀"
"⠀⠀⠀⠀⠀⠀⠀⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀⢸⣿⣿⣿⣿⣿⡇⠀⠸⠿⠿⠿⠿⠿⠿⠿⠀⢸⣿⣿⣿⣿⣿⡇⠀⢸⣿⣿⣿⣿⣿⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀"
"⠀⠀⠀⠀⠀⠀⠀⢿⣿⣿⣿⣿⣿⣿⣿⡇⠀⢸⣿⣿⣿⣿⣿⣇⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣸⣿⣿⣿⣿⣿⡇⠀⢸⣿⣿⣿⣿⣿⣿⣿⡿⠀⠀⠀⠀⠀⠀⠀"
"⠀⠀⠀⠀⠀⠀⠀⠀⠙⠿⣿⣿⣿⣿⣿⡇⠀⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀⢸⣿⣿⣿⣿⣿⡿⠋⠀⠀⠀⠀⠀⠀⠀⠀"
"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠻⣿⣿⣿⡇⠀⢸⣿⣿⣿⣿⣿⡟⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⢻⣿⣿⣿⣿⣿⡇⠀⢸⣿⣿⣿⠟⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⢿⡇⠀⢸⣿⣿⣿⣿⡿⠀⠀⣶⣶⣶⣶⣶⣶⣶⣶⡀⠀⢻⣿⣿⣿⣿⡇⠀⢸⡿⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠁⠀⢸⣿⣿⣿⡿⠁⠀⣼⣿⣿⣿⣿⣿⣿⣿⣿⣧⠀⠈⢿⣿⣿⣿⡇⠀⠈⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠻⣿⣿⠃⠀⣼⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣇⠀⠈⣿⣿⠟⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠃⠀⣼⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣆⠀⠈⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"))
         (longest-line (apply #'max (mapcar #'length banner))))
    (put-text-property
     (point)
     (dolist (line banner (point))
       (insert (+doom-dashboard--center
                +doom-dashboard--width
                (concat line (make-string (max 0 (- longest-line (length line))) 32)))
               "\n"))
     'face 'doom-dashboard-banner)))

(setq +doom-dashboard-ascii-banner-fn #'autobots-rules-greater)

(custom-set-faces!
  '(doom-dashboard-banner :foreground "#61afef" ))



;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Morten Hersson"
      user-mail-address "mher@stibodx.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))
(setq doom-font (font-spec :family "JetBrainsMono Nerd Font" :size 15))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq custom-theme-directory "~/.config/doom/themes")
(setq doom-theme 'catppuccin)
;; (load-theme 'github t)
(setq catppuccin-flavor 'macchiato) ;; or 'latte, 'macchiato, or 'mocha

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Development/org-files")

;; Set max length for branch name on the modeline
(setq doom-modeline-vcs-max-length 40)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; Always middle click paste at cursors position
(setq mouse-yank-at-point t)

;; Copy from terminal emacs to the system clipboard
(xclip-mode 1)

;; Set cursor colors on mode change
(unless (display-graphic-p)
  (evil-terminal-cursor-changer-activate))

(when (display-graphic-p)
(setq evil-emacs-state-cursor '("red" box)
    evil-normal-state-cursor '("orange" box)
    evil-visual-state-cursor '("orange" box)
    evil-insert-state-cursor '("red" bar)
    evil-replace-state-cursor '("red" bar)
    evil-operator-state-cursor '("red" hollow)))

(defun normal-mode-and-save ()
  "Enter 'evil-normal-state and 'evil-write in sequence."
  (interactive)
  (evil-normal-state)
  (evil-write nil nil))

;; Set custom global keybindings
(map! :map global-map
      "C-s" #'normal-mode-and-save
      "C-q" #'evil-quit
      "M-k" #'drag-stuff-up
      "M-j" #'drag-stuff-down)

;; Remap SPC-c-x to flycheck-list-errors with vertico
(map!
 (:leader
  (:prefix "c"
   :desc "List flycheck errors" "x" #'flycheck-list-errors)))


;; Add autocompletion on local file paths
(add-to-list 'company-backends 'company-files)
(add-to-list '+lsp-company-backends 'company-files)

;; Set shell indent to 2 spaces
(add-hook! sh-mode
  (setq sh-basic-offset 2)
  (setq tab-width 2))

;; Override shfmt to use two spaces instead of tabs
(after! format-all
  (set-formatter! 'shfmt
    '("shfmt"
      "-i" "2" "-ci" "-bn"
      ;; Mode selection ropied from the default config
      ("-ln" "%s" (cl-case (and (boundp 'sh-shell) (symbol-value 'sh-shell))
                    (bash "bash") (mksh "mksh") (t "posix"))))
    :modes 'sh-mode))

;; Disable the documentation pop-up
(setq lsp-ui-doc-enable nil)

(add-hook! rustic-mode
  (setq lsp-rust-analyzer-server-display-inlay-hints t))

;; Set up flycheck checkers combined with lsp
;; https://github.com/hlissner/doom-emacs/issues/1530#issuecomment-725588733
(add-hook! 'lsp-after-initialize-hook
  (run-hooks (intern (format "%s-lsp-hook" major-mode))))

(defun sh-flycheck-setup ()
  (flycheck-add-next-checker 'lsp 'sh-shellcheck))
(add-hook 'sh-mode-lsp-hook #'sh-flycheck-setup)

(defun python-flycheck-setup ()
  (flycheck-add-next-checker 'lsp 'python-pylint))
(add-hook 'python-mode-lsp-hook #'python-flycheck-setup)

(defun go-flycheck-setup ()
  (flycheck-add-next-checker 'lsp 'golangci-lint))
(add-hook 'go-mode-lsp-hook #'go-flycheck-setup)

(add-hook! go-mode
  (setq lsp-gopls-gofumpt t)
  (setq lsp-gopls-complete-unimported t)
  (setq lsp-gopls-deep-completion t)
  (setq lsp-gopls-use-placeholders t)
  (setq lsp-gopls-semantic-tokens t)
  (setq lsp-go-build-flags ["-tags=integration"]))

(after! lsp-mode
  (add-to-list 'lsp-file-watch-ignored-directories "[/\\\\]\\moto")
  (add-to-list 'lsp-file-watch-ignored-directories "[/\\\\]\\vendor"))

;; Use yamlfmt instead of lsp to format yaml files
(after! yaml-mode
  (add-hook 'yaml-mode-hook
            (lambda ()
              (add-hook 'before-save-hook #'yamlfmt-format-buffer nil t))))

(defun yamlfmt-format-buffer ()
  "Format the current buffer using yamlfmt."
  (when (executable-find "yamlfmt")
    (let ((current-point (point)))
      (shell-command-on-region (point-min) (point-max) "yamlfmt -" nil t)
      (goto-char current-point))))

;; Plantuml
(after! plantuml-mode
  (setq plantuml-default-exec-mode 'jar
        plantuml-preview-theme "toy"))

;; Copilot
;; accept completion from copilot and fallback to company
(use-package! copilot
  :hook (prog-mode . copilot-mode)
  :bind (:map copilot-completion-map
              ("<tab>" . 'copilot-accept-completion)
              ("TAB" . 'copilot-accept-completion)
              ("C-TAB" . 'copilot-accept-completion-by-word)
              ("C-<tab>" . 'copilot-accept-completion-by-word)))
