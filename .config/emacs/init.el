;; Remove atrocious bars
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

;; Transparency
(set-frame-parameter (selected-frame) 'alpha '(90 100))
(add-to-list 'default-frame-alist '(alpha 90 100))

;; Scrolling
(setq redisplay-dont-pause t
  scroll-margin 1
  scroll-step 1
  scroll-conservatively 10000
  scroll-preserve-screen-position 1)

;; y-n
(fset 'yes-or-no-p 'y-or-n-p)

;; Parens
(show-paren-mode 1)

;; Don't clutter folders with autosaves
(setq auto-save-file-name-transforms
      `((".*" "~/.local/share/emacs_saves/" t)))

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

;; Global HL Line
(global-hl-line-mode 1)

;; Font
(set-face-attribute 'default nil :font "Go Mono Nerd Font Mono" :height 110)

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

;; Quelpa
(use-package quelpa)
(use-package quelpa-use-package)

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
(use-package gruvbox-theme
  :init
  (load-theme 'gruvbox-dark-hard))

;; Modeline, first all-the-icons
(use-package all-the-icons)

;; Elfeed
(use-package elfeed)
(use-package elfeed-org
  :init (elfeed-org)
  :custom (rmh-elfeed-org-files (list "~/.config/emacs/elfeed.org")))

;; Lang modes
(use-package elixir-mode
  :mode ("\\.exs\\'" . elixir-mode))

(use-package haskell-mode
  :mode ("\\.hs\\'" . haskell-mode))

;; Company
(use-package company
  :hook ((emacs-lisp-mode org-mode-hook lisp-mode-hook common-lisp-mode ielm-mode sly-mode-hook elixir-mode-hook) . company-mode)
  :config
  (setq company-idle-delay 0.1
        company-minimum-prefix-length 1))

;; LSP
(use-package lsp-mode
  :hook ((c-mode python-mode-hook shell-mode-hook go-mode-hook elixir-mode) . lsp-deferred)
  :init
  (add-to-list 'exec-path (concat (getenv "HOME") "/git/elixir-ls/")))

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

(use-package dired-ranger)

;; Dired
(use-package dired
  :ensure nil
  :config
  (setq dired-listing-switches "-ahl")

  (defun my-dired-mode-setup ()
    (dired-hide-details-mode 1))
  (require 'dired-x)
  (setq dired-omit-files "^\\...+$")
  (add-hook 'dired-mode-hook 'my-dired-mode-setup)
  (add-hook 'dired-mode-hook (lambda () (dired-omit-mode 1)))
  
  (defun rcd/dired-view ()
    "View files"
    (interactive)
    (let* ((files (dired-get-marked-files))
           (how-many (length files)))
      (if (> how-many 1) (xdg-open-files files)
        (xdg-open (car files) t))))
  
  (defun xdg-open (file &optional async)
    "Opens file with xdg-open. Without optional argument ASYNC, it will wait for the file to finish playing or review."
    (let ((command (format "xdg-open '%s'" file)))
      (if async
          (call-process-shell-command command nil 0)
        (shell-command command))))
  
  (defun xdg-open-files (files)
    "Opens list of files with xdg-open one by one, waiting for each to finish."
    (dolist (file files)
      (xdg-open file)))
  
;; Finally mapping the key V to dired-mode-map
  (define-key dired-mode-map "V" 'rcd/dired-view)
  (define-key dired-mode-map "c" 'dired-ranger-copy)
  (define-key dired-mode-map "P" 'dired-ranger-paste)
  (define-key dired-mode-map "v" 'dired-ranger-move))

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
  :bind (:map pdf-view-mode-map
              ("C-s" . isearch-forward)
               ("C-r" . isearch-backward))
  :config
  (add-hook 'pdf-view-mode-hook 'pdf-isearch-minor-mode)
  (add-hook 'pdf-view-mode-hook 'pdf-view-midnight-minor-mode))

;; EPUB
(use-package nov
  :mode ("\\.epub\\'" . nov-mode))

;; Magit
(use-package  magit)

;; Org Bullets
(use-package org-bullets
  :config
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

;; Org Agenda settings
(use-package org
  :ensure nil
  :config
  (setq org-agenda-files (list "~/ext/Media/Docs/org/todo.org")
        org-todo-keywords '((sequence "TODO(t)" "ACTIVE(a)" "DONE(d)"))
        org-agenda-custom-commands
        '(("j" "Jobs" tags "jobs"
           ((org-agenda-overriding-header "Jobs to do")))
          ("b" "Books" tags "books"
           ((org-agenda-overriding-header "Books to read")
            (org-agenda-remove-tags t)
            (org-agenda-compact-blocks t)
            (ps-landscape-mode t)
            (org-agenda-prefix-format " -> ")
            (ps-number-of-columns 2))))))

;; Ibuffer
(use-package ibuffer
  :ensure nil
  :bind ("C-x C-b" . ibuffer)
  :config
  (add-hook 'ibuffer-mode-hook
            (lambda ()
              (ibuffer-switch-to-saved-filter-groups "default")))
  (setq ibuffer-saved-filter-groups
        '(("default"
           ("emacs-config" (or (filename . "emacs")
                               (filename . "init.el")))
           ("Org" (or (mode . org-mode)
                      (filename . "OrgMode")))
           ("Dired" (mode . dired-mode))
           ("Elfeed" (or (mode . elfeed-search-mode)
                         (mode . elfeed-show-mode)
                         (name . "\*elfeed\*")))
           ("PDF" (or (mode . pdf-view-mode)))
           ("Help" (or (name . "\*Help\*")
                       (name . "\*Apropos\*")
                       (name . "\*info\*")))))))

;; Mail
(use-package mu4e
  :load-path "/usr/share/emacs/site-lisp/mu4e"
  :ensure nil
  :config
  (setq mu4e-change-filenames-when-moving t
        mu4e-update-interval (* 10 60)
        mu4e-get-mail-command "mbsync -a"
        mu4e-maildir         "~/.mail"
        mu4e-drafts-folder   "/Drafts"
        mu4e-sent-folder     "/Sent Mail"
        mu4e-trash-folder    "/Trash"
        mu4e-maildir-shortcuts
        '(("/inbox" . ?i)
          ("/Drafts" . ?d)
          ("/Trash" . ?t)
          ("/Junk" . ?j)
          ("/Sent Mail" . ?s))))
