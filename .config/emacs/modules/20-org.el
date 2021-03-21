;;; package --- Summary

;;; Code:

;; Setting up the latest org
(use-package org
  :ensure t
  :init
  (setq org-agenda-files (quote ("~/ext/Media/Docs/org/todo.org")))
  :config
  (add-hook 'org-mode-hook (lambda () (visual-line-mode 1))))

;; Org-bullets
(use-package org-bullets
  :ensure t
  :init
  (org-bullets-mode 1)
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

;; Org-mind mapping
(with-eval-after-load 'ox-org
  (use-package org-mind-map
    :ensure t
    :config
    (with-eval-after-load 'org
      (setq org-mind-map-engine "neato"))))

(provide 'org-settings)
;;; org-settings.el ends here
