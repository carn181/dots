;;; package --- Summary
;;; Code:

(use-package pdf-tools
  :defer 2
  :ensure t
  :config
  (add-hook 'pdf-tools-enabled-hook 'pdf-view-midnight-minor-mode)
  (add-hook 'pdf-tools-enabled-hook 'auto-revert-mode))

(provide 'pdf-settings)
;;; pdf-settings.el ends here
