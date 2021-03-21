;;; package --- Summary

;;; Code:

;; Golang
(use-package go-mode
  :ensure t
  :defer 2
  :hook (go-mode . lsp-deferred)
  :config
  (with-eval-after-load 'lsp-mode
    (defun lsp-go-install-save-hooks ()
      (add-hook 'before-save-hook #'lsp-format-buffer t t)
      (add-hook 'before-save-hook #'lsp-organize-imports t t))
    (add-hook 'go-mode-hook #'lsp-go-install-save-hooks)))

(use-package lsp-haskell
  :ensure t
  :defer 2)

;; Haskell
(use-package haskell-mode
  :ensure t
  :defer 2
  :config
  (with-eval-after-load 'lsp
    (add-hook 'haskell-mode-hook #'lsp-deferred)
    (add-hook 'haskell-literate-mode-hook #'lsp-deferred)))

(with-eval-after-load 'company
  (add-hook 'c-mode-hook 'company-mode)
  (add-hook 'go-mode-hook 'company-mode)
  (add-hook 'slime-mode-hook 'company-mode)
  (add-hook 'haskell-mode-hook 'company-mode)
  (add-hook 'python-mode-hook 'company-mode)
  (add-hook 'haskell-interactive-mode-hook 'company-mode))

(add-hook 'common-lisp-mode-hook 'prettify-symbols-mode)
(add-hook 'lisp-mode-hook 'prettify-symbols-mode)
(add-hook 'emacs-lisp-mode-hook 'prettify-symbols-mode)

(provide 'langs-settings)

;;; langs-settings.el ends here
