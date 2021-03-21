;;; package --- Summary

;;; Code:

(use-package mpdel
  :ensure t
  :defer 4
  :config
  (defun mpdel-current-song-cover-art ()
    (shell-command-to-string
     (concat "ffmpeg -y -i '/home/ecm/ext/Media/Music/"
             (libmpdel-song-file libmpdel--current-song)
             "' ~/.cache/mpd_curr.jpg 2&>/dev/null"))
    (if (null (get-buffer "mpd_curr.jpg"))
        (progn
          (split-window-horizontally)
          (find-file "~/.cache/mpd_curr.jpg")
          (auto-revert-mode))))
  (add-hook 'libmpdel-current-song-changed-hook 'mpdel-current-song-cover-art)
  (define-key mpdel-core-map "c" (lambda ()
                                   (interactive)
                                   (shell-command-to-string "mpc clear"))))

(provide 'mpd-settings)
;;; mpd-settings.el ends here
