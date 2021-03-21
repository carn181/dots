(use-package dashboard
  :ensure t
  :init
  (setq dashboard-banner-logo-title "Welcome to Emacs !"
        dashboard-startup-banner (concat user-emacs-directory "start.png"))
  :config
  (dashboard-setup-startup-hook)
  (setq initial-buffer-choice (lambda () (get-buffer "*dashboard*"))))
