;; Treemacs
(use-package treemacs
  :ensure t
  :defer 2
  :config
  (define-key global-map (kbd "C-c t") 'treemacs)
  (define-key global-map (kbd "C-c 0") 'treemacs-select-window))
