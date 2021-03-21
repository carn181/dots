;;; package --- Summary


;;; Commentary:
;; My Emacs Configuration
;;                   __ _
;;   ___ ___  _ __  / _(_) __ _
;;  / __/ _ \| '_ \| |_| |/ _` |
;; | (_| (_) | | | |  _| | (_| |
;;  \___\___/|_| |_|_| |_|\__, |
;;                        |___/

;;; Code:

(defvar last-file-name-handler-alist file-name-handler-alist)
(setq gc-cons-threshold 402653184
      gc-cons-percentage 0.6
      file-name-handler-alist nil)

(setq user-emacs-directory "~/.config/emacs/")
(defvar user-modules-directory (concat user-emacs-directory "modules/"))

(with-eval-after-load "cl-lib"
  (cl-loop for file in (append (directory-files-recursively user-modules-directory "\\.el$"))
           do (condition-case ex
                  (load (file-name-sans-extension file))
                ('error (with-current-buffer "*scratch*"
                          (insert (format "[INIT ERROR]\n%s \n%s\n\n" file ex)))))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(font-lock-variable-name-face ((t (:foreground "#00d3d0" :slant italic :weight bold :height 1.05))))
 '(ivy-current-match ((t (:inherit (modus-themes-intense-cyan bold) :extend t :slant italic))))
 '(slime-repl-prompt-face ((t (:inherit font-lock-keyword-face :slant italic))))
 '(whitespace-tab ((t (:foreground "#636363")))))

(add-hook 'emacs-startup-hook
          (lambda ()
            (setq gc-cons-threshold 16777216
                  gc-cons-percentage 0.1
                  file-name-handler-alist last-file-name-handler-alist)))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("fce3524887a0994f8b9b047aef9cc4cc017c5a93a5fb1f84d300391fba313743" "2c49d6ac8c0bf19648c9d2eabec9b246d46cb94d83713eaae4f26b49a8183fc4" "76bfa9318742342233d8b0b42e824130b3a50dcc732866ff8e47366aed69de11" default))
 '(package-selected-packages '(nov use-package rainbow-delimiters)))

(provide 'init)
;;; init.el ends here
