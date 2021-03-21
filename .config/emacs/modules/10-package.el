;;; package --- Summary

;;; Commentary:
;; Setting up the package system

;;; Code:
;; (package-initialize)
;; Setting up MELPA
(with-eval-after-load 'package
  (setq package-enable-at-startup nil)
  (add-to-list 'package-archives
               '("melpa" . "https://melpa.org/packages/"))

;; (use-package ...)
  (unless (package-installed-p 'use-package)
    (package-refresh-contents)
    (package-install 'use-package)))

(provide 'package-defaults)

;;; package-defaults.el ends here
