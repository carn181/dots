;;; package --- Summary

;;; Code:
(mapcar (lambda (dir)
          (add-to-list 'load-path (concat user-emacs-directory "local/" dir)))
        '("elfeed-3.4.1" "elfeed-org"))

(eval-when-compile
  (progn
    (require 'elfeed)
    (require 'elfeed-org)))

(use-package elfeed
  :defer 2
  :bind ((:map elfeed-show-mode-map
                  ("p" . browse-url-mpv-open)
                  ("d" . browse-url-ytdl-open))
         ("M-p" . yt-play)))

(use-package elfeed-org
  :defer 2
  :config
  (elfeed-org)
  (setq rmh-elfeed-org-files (list (concat user-emacs-directory "elfeed.org"))))

(defun browse-url-mpv-open (url &optional ignored)
  "Pass the specified URL to the \"mpv\" command.
xdg-open is a desktop utility that calls your preferred web browser.
The optional argument IGNORED is not used."
  (interactive (browse-url-interactive-arg "URL: "))
  (call-process "mpv" nil 0 nil "-ao=jack" "--ytdl-format=`bestvideo[height<=480]+(bestaudio[acodec=opus]/bestaudio[acodec=vorbis]/bestaudio[acodec=aac]/bestaudio)/best`" url))

(defun browse-url-ytdl-open (url &optional ignored)
  "Pass the specified URL to the \"mpv\" command.
xdg-open is a desktop utility that calls your preferred web browser.
The optional argument IGNORED is not used."
  (interactive (browse-url-interactive-arg "URL: "))
  (call-process "zsh" nil 0 nil "-c" (format "`yt-buf '%s' && notify-send 'Done Downloading %s'`" url url))
  (message "Downloading %s" url))

(defun yt-play ()
  (interactive)
  (call-process "mpv" nil 0 nil
                (ivy-read "Which Video? " (directory-files-recursively
                                           (concat "/home/ecm/ext/Media/Vids/YT/" (format-time-string "%Y-%m-%d")) ""))))

(provide 'elfeed-settings)

;;; elfeed-settings.el ends here
