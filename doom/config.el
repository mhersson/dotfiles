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

;; (GUI) set initial frame size, splash image and cursor colors
(when (display-graphic-p)
  (set-frame-size (selected-frame) 185 67)
  (setq fancy-splash-image (concat doom-user-dir "yoshi.png"))
  (setq evil-emacs-state-cursor '("red" box)
        evil-normal-state-cursor '("orange" box)
        evil-visual-state-cursor '("orange" box)
        evil-insert-state-cursor '("red" bar)
        evil-replace-state-cursor '("red" bar)
        evil-operator-state-cursor '("red" hollow)))



;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:

(setq doom-font (font-spec :family "RobotoMono Nerd Font" :size 15 :weight 'Regular))

;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'catppuccin)

;; Override background color to catppuccin-mocha
;;(custom-set-faces! '(default :background "#1E1E2E"))

;; Don't nag about me wanting to exit
;; (setq confirm-kill-emacs nil)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Documents/org-mode/")

;; Set max length for branch name on the modeline
(setq doom-modeline-vcs-max-length 40)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
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
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; Enable the documentation pop-up
(setq lsp-ui-doc-show-with-cursor t)
(setq lsp-ui-doc-delay 0.2)
(setq lsp-ui-doc-max-width 120)

;; Expand magit sections by default
(setq magit-section-initial-visibility-alist
      '((stashes . show) (untracked . show) (unpushed . show)))

;; Set custom global keybindings
(map! :map global-map
      "M-k" #'drag-stuff-up
      "M-j" #'drag-stuff-down)

;; Always middle click paste at cursors position
(setq mouse-yank-at-point t)

;; Set some spelling defaults
(after! ispell
  (setq ispell-dictionary "en_US")
  (setq ispell-local-dictionary "en_US")
  (setq ispell-local-dictionary-alist
        '(("en_US" "[[:alpha:]]" "[^[:alpha:]]" "[']" nil ("-d" "en_US") nil utf-8))))

;; Formatting

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

;; Lsp settings

(after! lsp-mode
  (setq lsp-inlay-hint-enable t))

(add-hook! go-mode
  (setq lsp-gopls-gofumpt t)
  (setq lsp-gopls-complete-unimported t)
  (setq lsp-gopls-deep-completion t)
  (setq lsp-gopls-use-placeholders t)
  (setq lsp-gopls-semantic-tokens t)
  (setq lsp-go-build-flags ["-tags=integration"]))

;; Rust
(setq lsp-rust-analyzer-display-lifetime-elision-hints-enable "skip_trivial")
(setq lsp-rust-analyzer-display-lifetime-elision-hints-use-parameter-names t)
(setq lsp-rust-analyzer-display-chaining-hints t)
(setq lsp-rust-analyzer-display-closure-return-type-hints t)
(setq lsp-rust-analyzer-display-parameter-hints t)
;; (setq lsp-rust-analyzer-display-reborrow-hints t)

;; Add mpls to markdown-mode for preview
(after! markdown-mode
  ;; Automatically open markdown preview (start mpls)
  (add-hook 'markdown-mode-local-vars-hook #'lsp!))

(after! lsp-mode
  (defgroup lsp-mpls nil
    "Settings for the mpls language server client."
    :group 'lsp-mode
    :link '(url-link "https://github.com/mhersson/mpls"))

  (defun lsp-mpls-open-preview ()
    "Open preview of current buffer"
    (interactive)
    (lsp-request
     "workspace/executeCommand"
     (list :command "open-preview")))

  (defcustom lsp-mpls-server-command "/Users/morten/Development/mpls/mpls"
    "The binary (or full path to binary) which executes the server."
    :type 'string
    :group 'lsp-mpls)

  (lsp-register-client
   (make-lsp-client :new-connection (lsp-stdio-connection
                                     (lambda ()
                                       (list
                                        (or (executable-find lsp-mpls-server-command)
                                            (lsp-package-path 'mpls)
                                            "mpls")
                                        "--enable-emoji"
                                        "--enable-footnotes"
                                        "--plantuml-server" "localhost:8080"
                                        "--plantuml-path" "/"
                                        "--plantuml-disable-tls"
                                        )))
                    :activation-fn (lsp-activate-on "markdown")
                    :initialized-fn (lambda (workspace)
                                      (with-lsp-workspace workspace
                                        (lsp--set-configuration
                                         (lsp-configuration-section "mpls"))
                                        ))
                    :priority 1
                    :add-on? t
                    :server-id 'mpls)))

;; Plantuml
(after! plantuml-mode
  (setq plantuml-default-exec-mode 'jar
        plantuml-preview-theme "toy"))

;; Copilot
(use-package! copilot
  ;; :hook (prog-mode . copilot-mode)
  :bind (:map copilot-completion-map
              ("C-<return>" . 'copilot-accept-completion)
              ;; ("TAB" . 'copilot-accept-completion)
              ("C-TAB" . 'copilot-accept-completion-by-word)
              ("C-<tab>" . 'copilot-accept-completion-by-word)
              ("M-n" . 'copilot-next-completion)
              ("M-p" . 'copilot-previous-completion))

  :config
  (add-to-list 'copilot-indentation-alist '(prog-mode 2))
  (add-to-list 'copilot-indentation-alist '(org-mode 2))
  (add-to-list 'copilot-indentation-alist '(text-mode 2))
  (add-to-list 'copilot-indentation-alist '(closure-mode 2))
  (add-to-list 'copilot-indentation-alist '(emacs-lisp-mode 2)))


;; Debugging with dape
(use-package! dape
  :config
  ;; Info buffers to the right
  (setq dape-buffer-window-arrangement 'right)
  ;; (setq dape-buffer-window-arrangement 'gud)
  ;; (setq dape-info-hide-mode-line nil)

  ;; Showing inlay hints
  (setq dape-inlay-hints t)

  ;; Set project root as current working dir
  (setq dape-cwd-fn 'projectile-project-root)


  (add-to-list 'dape-configs
               `(delve-debug-test
                 modes (go-mode go-ts-mode)
                 ensure dape-ensure-command
                 fn (dape-config-autoport dape-config-tramp)
                 command "dlv"
                 command-insert-stderr t
                 command-args ("dap" "--listen" "127.0.0.1::autoport")
                 command-cwd (lambda()(if (string-suffix-p "_test.go" (buffer-name))
                                          default-directory (dape-cwd)))
                 port :autoport
                 :type "debug"
                 :request "launch"
                 :mode (lambda() (if (string-suffix-p "_test.go" (buffer-name)) "test" "debug"))
                 :program "."
                 :cwd "."
                 :args
                 (lambda ()
                   (require 'which-func)
                   (if-let* ((file-name (buffer-file-name))
                             ((string-suffix-p "_test.go" file-name))
                             (fn-name (which-function)))
                       `["-test.v"
                         ,(substring-no-properties (concat "^" fn-name "$"))]
                     []))))

  (add-to-list 'dape-configs
               `(delve-ginkgo-suite
                 modes (go-mode go-ts-mode)
                 ensure dape-ensure-command
                 fn (dape-config-autoport dape-config-tramp)
                 command "dlv"
                 command-insert-stderr t
                 command-args ("dap" "--listen" "127.0.0.1::autoport")
                 command-cwd (lambda()(if (string-suffix-p "_test.go" (buffer-name))
                                          default-directory (dape-cwd)))
                 port :autoport
                 :type "debug"
                 :request "launch"
                 :mode (lambda() (if (string-suffix-p "_test.go" (buffer-name)) "test" "debug"))
                 :program "."
                 :cwd "."
                 :args ["-test.run" "."] ))

  (add-to-list 'dape-configs
               `(delve-ginkgo-focus
                 modes (go-mode go-ts-mode)
                 ensure dape-ensure-command
                 fn (dape-config-autoport dape-config-tramp)
                 command "dlv"
                 command-insert-stderr t
                 command-args ("dap" "--listen" "127.0.0.1::autoport")
                 command-cwd (lambda()(if (string-suffix-p "_test.go" (buffer-name))
                                          default-directory (dape-cwd)))
                 port :autoport
                 :type "debug"
                 :request "launch"
                 :mode (lambda() (if (string-suffix-p "_test.go" (buffer-name)) "test" "debug"))
                 :program "."
                 :cwd "."
                 :args
                 (lambda ()
                   (require 'which-func)
                   (if-let* ((file-name (buffer-file-name))
                             ((string-suffix-p "_test.go" file-name))
                             (test-name (extract-ginkgo-describe-string)))
                       `["-ginkgo.v" "-ginkgo.focus"
                         ,(substring-no-properties test-name )]
                     [])))))

(defun extract-ginkgo-describe-string ()
  "Return the string in double quotes that follows `ginkgo.Describe(` or
`ginkgo.It(' on the current line."
  (interactive)
  (let ((line (thing-at-point 'line t)))
    (if (string-match "ginkgo\\.Describe(\"\\(.*?\\)\"\\|ginkgo\\.It(\"\\(.*?\\)\"" line)
        (or (match-string 1 line) (match-string 2 line))
      "No matching test found.")))


(map! :map dape-mode-map
      :leader
      :prefix ("d" . "dap")
      :desc "dape hydra" "h" #'hydra-dap/body

      :desc "dape debug"   "s" #'dape
      :desc "dape quit"    "q" #'dape-quit
      :desc "dape restart" "r" #'dape-restart

      :desc "dape breakpoint toggle"     "b" #'dape-breakpoint-toggle
      :desc "dape breakpoint remove all" "B" #'dape-breakpoint-remove-all
      :desc "dape breakpoint log"        "l" #'dape-breakpoint-log

      :desc "dape continue" "c" #'dape-continue
      :desc "dape next"     "n" #'dape-next
      :desc "dape step in"  "i" #'dape-step-in
      :desc "dape step out" "o" #'dape-step-out

      :desc "dape eval" "e" #'dape-evaluate-expression)

(require 'hydra)
(defhydra hydra-dap (:color pink :hint nil)
  "
^Dape Hydra^
------------------------------------------------
_n_: Next       _e_: Eval    _Q_: Disconnect
_i_: Step In
_o_: Step Out
_c_: Continue
_r_: Restart

"
  ("n" #'dape-next)
  ("i" #'dape-step-in)
  ("o" #'dape-step-out)
  ("c" #'dape-continue)
  ("e" #'dape-evaluate-expression)
  ("r" #'dape-restart)
  ("q" nil "Quit" :color blue)
  ("Q" #'dape-quit :color blue))
