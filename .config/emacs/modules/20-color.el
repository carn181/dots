;;; package --- Summary

;;; Code:

;; Colorscheme
(use-package doom-themes
  :ensure t
  :defer 1
  :init
  (load-theme 'doom-material t)
  (enable-theme 'doom-material))

(if window-system
    (enable-theme 'doom-material))

(provide 'color-settings)

;;; color-settings.el ends here
