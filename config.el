;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Enrico Risa"
      user-mail-address "enrico.risa@gmail.com")

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

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-laserwave)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

(setq compilation-scroll-output t)
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

(global-set-key (kbd "C-s") '+default/search-buffer)

(blink-cursor-mode 10)


(add-hook 'after-save-hook (lambda () (when (eq 'org-mode major-mode)
                                        (org-re-reveal-export-to-html))))

(setq treemacs-position 'right)



(setq gc-cons-threshold 100000000)
(setq lsp-idle-delay 0.500)
(use-package nyan-mode
  :init
  (nyan-mode))

(setq company-dabbrev-downcase 0)
(setq company-idle-delay 0)
(add-to-list 'default-frame-alist '(fullscreen . maximized))


(with-eval-after-load 'evil
  (defalias #'forward-evil-word #'forward-evil-symbol)
  ;; make evil-search-word look for symbol rather than word boundaries
  (setq-default evil-symbol-word-search t))


(setq lsp-enable-file-watchers nil)
(setq lsp-file-watch-threshold 1000000)
(setq lsp-elixir-dialyzer-enabled nil)
(setq lsp-elixir-fetch-deps nil)
(setq lsp-elixir-mix-env "dev")
(setq lsp-elixir-enable-test-lenses nil)


(map! :n "TAB" #'next-buffer)
(map! :n [backtab] 'previous-buffer)

(require 'which-key)
(setq which-key-idle-delay 0.1)


(defun insert-after-char (key)
  "New line after first matched char"
  (interactive "sInsert after: ")
  (insert-after--char key)
  )

(defun insert-after--char (key)
  (evil-snipe-seek 1 key)
  (forward-char)
  (call-interactively 'newline)
  (call-interactively 'evil-open-above)
  )

(defun insert-after-curly-bracket ()
  "Insert newline after {"
  (interactive)
  (insert-after--char "{")
  )

(map!
 (:prefix "g"
  :desc "New line after first curly bracket matched" :n "{" #'insert-after-curly-bracket
  ))

(map! :leader
      :desc "Go Back Position"
      "c p" #'xref-go-back)

(map! :leader
      :desc "Go Next Position"
      "c n" #'xref-go-forward)
