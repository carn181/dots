;;; package --- Summary

;;; Commentary:
;; Emojis

;;; Code:
(use-package emojify
  :ensure t
  :defer 1
  :hook (after-init . global-emojify-mode))

(provide 'emojis)
;;; emojis.el ends here
