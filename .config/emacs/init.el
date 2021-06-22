;; Remove atrocious bars
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

;; Parens
(show-paren-mode 1)

;; Whitespace
(add-hook 'prog-mode-hook #'whitespace-mode)
(setq whitespace-style `(face spaces tabs newline space-mark tab-mark newline-mark ))
(setq whitespace-display-mappings
      ;; all numbers are unicode codepoint in decimal. e.g. (insert-char 182 1)
      '(
        (space-mark 32 [183] [46]) ; SPACE 32 「 」, 183 MIDDLE DOT 「·」, 46 FULL STOP 「.」
        (newline-mark nil nil nil) ; LINE FEED,
        (tab-mark 9 [9655 9] [92 9]) ; tab
        ))

;; No tabs
(setq-default indent-tabs-mode nil)

;; Font
(set-face-attribute 'default nil :font "Iosevka Nerd Font Mono" :height 105)

;; Custom emacs directory
(setq user-emacs-directory (concat (getenv "HOME") "/.config/emacs/"))

;; STOP CLUTTERING init.el EMACS !
(setq custom-file (concat user-emacs-directory "/custom.el"))

;; Packages
(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org"   . "https://orgmode.org/elpa/")
                         ("elpa"  . "https://elpa.gnu.org/packages/")))
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; use-package
(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)

;; Redo
(use-package undo-tree
  :init (global-undo-tree-mode))

;; Ivy, Counsel and Swiper
(use-package ivy
  :diminish
  :config
  (ivy-mode 1))

(use-package counsel)

(use-package swiper
  :bind (("C-s" . swiper)))

;; Theme
(use-package modus-themes
  :init
  (modus-themes-load-themes)
  (modus-themes-load-vivendi))

;; Modeline, first all-the-icons
(use-package all-the-icons)

;; Doom-modeline
(use-package doom-modeline
  :init (doom-modeline-mode 1)
  :custom
  (doom-modeline-height 18)
  (doom-modeline-buffer-encoding nil))

;; Elfeed
(use-package elfeed)
(use-package elfeed-org
  :init (elfeed-org)
  :custom (rmh-elfeed-org-files (list "~/.config/emacs/elfeed.org")))

;; Company
(use-package company
  :hook ((emacs-lisp-mode org-mode-hook lisp-mode-hook common-lisp-mode ielm-mode-hook eshell-mode) . company-mode)
  :config
  (setq company-idle-delay 0.1
        company-minimum-prefix-length 1))

;; LSP
(use-package lsp-mode
  :hook ((c-mode python-mode-hook shell-mode-hook go-mode-hook) . lsp-deferred))

;; Sly
(use-package sly
  :config
  (setq inferior-lisp-program "/usr/bin/sbcl"))

;; Colors !
;;(use-package rainbow-mode
;;  :init
;;  (define-globalized-minor-mode my-global-rainbow-mode rainbow-mode
;;    (lambda () (rainbow-mode 1)))
;;  (my-global-rainbow-mode 1))

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

;; Dashboard
(use-package dashboard
  :init (dashboard-setup-startup-hook)
  :config
  (setq initial-buffer-choice (lambda () (get-buffer "*dashboard*"))
        dashboard-center-content t
        dashboard-items '((recents . 5))
        dashboard-set-file-icons t
        dashboard-set-heading-icons t
        dashboard-startup-banner (concat user-emacs-directory "start.png")))

;; PDF
(use-package pdf-tools
  :mode ("\\.pdf\\'" . pdf-view-mode)
  :hook (pdf-view-mode-hook . pdf-isearch-minor-mode)
  :bind (:map pdf-view-mode-map
              ("C-s" . isearch-forward)
              ("C-r" . isearch-backward)))

;; Magit
(use-package  magit)
