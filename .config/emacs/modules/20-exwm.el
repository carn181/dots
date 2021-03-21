;;; package --- Summary

;;; Code:

(use-package exwm
  :ensure t
  :config
  (setq exwm-workspace-number 9)
  (setq exwm-input-prefix-keys
        '(?\C-x
          ?\C-u
          ?\C-h
          ?\M-x
          ?\M-&
          ?\M-:))
  (define-key exwm-mode-map [?\C-q] 'exwm-input-send-next-key)
  (setq exwm-input-global-keys
        `(;; Reset to line-mode (C-c C-k switches to char-mode via exwm-input-release-keyboard)
          ([?\s-r] . exwm-reset)

          ;; Move between windows
          ([s-j] . windmove-left)
          ([s-k] . windmove-right)
          ([s-h] . windmove-up)
          ([s-l] . windmove-down)

          ;; Launch applications via shell command
          ([?\s-d] . (lambda (command)
                       (interactive (list (read-shell-command "$ ")))
                       (start-process-shell-command command nil command)))

          ;; Switch workspace
          ([?\s-w] . exwm-workspace-move-window)

          ;; MPD
          ([?\s-m]  . mpdel-browser-open)

          ;; Elfeed
          ([?\s-y] . elfeed)

          ;; 's-[0-9]': Switch to certain workspace with Super (Win) plus a number key (0 - 9)
          ,@(mapcar (lambda (i)
                      `(,(kbd (format "s-%d" i)) .
                        (lambda ()
                          (interactive)
                          (exwm-workspace-switch-create ,i))))
                    (number-sequence 0 9))

          ;; Bindings for shell commands
          ,@(mapcar (lambda (e)
                      `(,(kbd (car e)) .
                        (lambda ()
                          (interactive)
                          (start-process-shell-command ,(cdr e) nil ,(cdr e)))))
                    '(;("KEY" . "command")
                      ("s-B"                    . "librewolf")
                      ("<s-return>"                    . "st")
                      ("<XF86AudioPlay>"        . "mpc toggle")
                      ("<XF86AudioNext>"        . "mpc next")
                      ("<XF86AudioPrev>"        . "mpc prev")
                      ("<print>"                . "screeny")
                      ("<C-print>"              . "screeny -s")
                      ("<XF86AudioRaiseVolume>" . "amixer sset Master 5%+")
                      ("<XF86AudioLowerVolume>" . "amixer sset Master 5%-")
                      ("<XF86AudioMute>"        . "amixer sset Master toggle")))))
  (setq display-time-day-and-date t)
  (display-battery-mode t)
  (display-time)
  (add-hook 'exwm-update-class-hook #'(lambda () (exwm-workspace-rename-buffer exwm-class-name)))
  (if (= (shell-command "pidof dwm") 1)
      (progn
        (exwm-enable)
        (eval-when-compile
          (require 'exwm-systemtray))
          (exwm-systemtray-enable))))

(provide 'exwm-settings)
;;; exwm-settings.el ends here
