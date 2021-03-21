;;; package --- Summary

;;; Code:

;; Company
(use-package company
  :ensure t
  :defer 2
  :init
  (global-company-mode)
  :config
  (setq company-idle-delay 0)
  (setq company-minimum-prefix-length 1))

(with-eval-after-load 'company
  (define-key company-active-map (kbd "M-n") 0)
  (define-key company-active-map (kbd "M-p") 0)
  (define-key company-active-map (kbd "C-n") #'company-select-next)
  (define-key company-active-map (kbd "C-p") #'company-select-previous))

(provide 'company-settings)

;;; company-settings.el ends here
