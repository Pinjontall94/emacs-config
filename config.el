;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Sam Johnson"
      user-mail-address "sambjohnson94@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


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

;;   =======================
;;  == Sammi's config :3 ==
;; =======================

(custom-set-variables
 '(initial-frame-alist (quote ((fullscreen . maximized)))))

;; Tell emacs to source the user shell (fix npm via nvm)
(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))


;; Roswell/Sly integration
(after! sly
  (sly-completion-hide-completions)
  (setq inferior-lisp-program "ros -Q run")
  (setq sly-lisp-implementations
        '((sbcl ("/home/linuxbrew/.linuxbrew/bin/ros" "-L" "sbcl-bin" "-Q" "run") :coding-system utf-8-unix)
          (clisp ("/home/linuxbrew/.linuxbrew/bin/ros" "-L" "clisp" "-Q" "run"))
          (clozure-cl ("/home/linuxbrew/.linuxbrew/bin/ros" "-L" "ccl-bin" "-Q" "run"))
          (cmucl ("/home/linuxbrew/.linuxbrew/bin/ros" "-L" "cmu-bin" "-Q" "run"))
          (ecl ("/home/linuxbrew/.linuxbrew/bin/ros" "-L" "ecl" "-Q" "run") :coding-system utf-8-unix)
          (abcl ("/home/linuxbrew/.linuxbrew/bin/ros" "-L" "abcl-bin" "-Q" "run")))))


;; Dart/Flutter
(after! dart-mode
  (setq lsp-dart-sdk-dir "/home/sammi/Apps/flutter/bin/cache/dart-sdk")
  (setq lsp-dart-flutter-sdk-dir "/home/sammi/Apps/flutter")
  ;; (setq  hover-flutter-sdk-path (concat (getenv "HOME") "/flutter") ; remove if `flutter` is already in $PATH
  (setq hover-command-path (concat (getenv "HOME") "/go/bin/hover") ; remove if `hover` is already in $PATH
        hover-hot-reload-on-save t
        hover-screenshot-path (concat (getenv "HOME") "/Pictures")
        hover-screenshot-prefix "my-prefix-"
        hover-observatory-uri "http://my-custom-host:50300"
        hover-clear-buffer-on-hot-restart t))


;; Python
(setq conda-anaconda-home "~/mambaforge")


;; IRC Stuff
(set-irc-server! "irc.libera.chat"
  `(:tls t
    :port 6697
    :nick "trannus_aran"
    :sasl-username ,(+pass-get-user "irc/libera.chat")
    :sasl-password (lambda (&rest _) (+pass-get-secret "irc/libera.chat"))
    :channels ("#emacs")))


;; Unicode font support
(setq doom-unicode-font (font-spec :family "Fira Mono"))


;; Supercollider
(add-to-list 'load-path "/home/sammi/.local/share/SuperCollider/downloaded-quarks/scel/el")
(require 'sclang)


;; Org Mode
(after! org-mode
  (set-company-backend! 'org-mode nil))


;; APL
(defun em-gnu-apl-init ()
  (setq buffer-face-mode-face 'gnu-apl-default)
  (buffer-face-mode))

(add-hook 'gnu-apl-interactive-mode-hook 'em-gnu-apl-init)
(add-hook 'gnu-apl-mode-hook 'em-gnu-apl-init)
