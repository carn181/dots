;;; package --- Summary

;;; Code:
;; LSP
(use-package lsp-mode
  :ensure t
  :defer 2
  :config
  (setq lsp-keymap-prefix "C-c l")
  (lsp-enable-which-key-integration t)
  (add-hook 'c-mode-hook 'lsp-deferred)
  (add-hook 'python-mode-hook 'lsp-deferred) )

(use-package lsp-ui
  :ensure t
  :defer 2)

(use-package lsp-ivy
  :ensure t
  :defer 2)

(use-package lsp-treemacs
  :ensure t
  :defer 2)

(provide 'lsp-settings)
;;; lsp-settings.el ends here
