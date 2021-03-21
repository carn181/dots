;;; package --- Summary
;;; Code:
(package-install-file (concat local-package-directory "rainbow.el"))
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

(provide 'rainbow-parens-settings)
;;; rainbow-parens-settings.el ends here
