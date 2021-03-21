;;; package --- Summary

;;; Commentary:
;; Configuration for default emacs

;;; Code:

;;--- Emacs Behaviour ---;;

;; Make emacs play well with tiling window managers
(setf frame-resize-pixelwise t)

;; Default Font
(set-face-attribute 'default nil :font "Monospace-10.5")

;; Make Emacs create autosave files in ~/.local/share/emacs_saves and not clutter current dir
(setq auto-save-file-name-transforms
      `((".*" "~/.local/share/emacs_saves/" t)))
(setq backup-directory-alist
      `(("." . ,(concat user-emacs-directory "backups"))))

;; Load packages from emacs/local/
(setq local-package-directory (concat user-emacs-directory "local/"))

;; Minimal UI
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

;; IDO
(ido-mode 1)

;; Highlight current line
(global-hl-line-mode 1)

;; Highlight parens
(show-paren-mode 1)

;; No Tabs
(setq-default indent-tabs-mode nil)

;; Whitespace
(setq whitespace-style '(face tabs tab-mark trailing))
(custom-set-faces
 '(whitespace-tab ((t (:foreground "#636363")))))
(setq whitespace-display-mappings
      '((tab-mark 9 [124 9] [92 9])))
(global-whitespace-mode)

;; For Transparency
(set-frame-parameter (selected-frame) 'alpha '(85 . 90))
(add-to-list 'default-frame-alist '(alpha . (85 . 90)))

;; Use a hook so the message doesn't get clobbered by other messages.
(add-hook 'emacs-startup-hook
          (lambda ()
            (message "Emacs ready in %s with %d garbage collections."
                     (format "%.2f seconds"
                             (float-time
                              (time-subtract after-init-time before-init-time)))
                     gcs-done)))

(provide 'init-defaults)

;;; init-defaults.el ends here
