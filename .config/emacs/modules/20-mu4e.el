;;; package --- Summary

;;; Code:

(add-to-list 'load-path "/usr/share/emacs/site-lisp/mu4e")

(use-package mu4e
  :defer 2
  :config
  (setq mu4e-change-filenames-when-moving t)
  (setq user-mail-address "fatscout@airmail.cc")
  (setq mu4e-update-interval (* 2 60))
  (setq mu4e-maildir "~/.mail")
  (setq mu4e-get-mail-command "mbsync -a")
  (setq mu4e-sent-folder "/Sent")
  (setq mu4e-trash-folder "/Trash")
  (setq mu4e-maildir-shortcuts
        '(("/Inbox"         . ?i)
          ("/Sent"          . ?s))))

(provide 'mu4e-settings)
;;; mu4e-settings.el ends here
