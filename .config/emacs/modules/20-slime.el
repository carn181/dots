;;; package --- Summary

;;; Code:
;; SLIME
(use-package slime
  :defer 5
  :ensure t
  :init
  (load (expand-file-name "~/.local/share/ql/slime-helper.el"))
  :config
  (setf slime-lisp-implementations
        '((sbcl-vanilla ("sbcl" "--dynamic-spac2e-size" "8GB"))
          (sbcl-custom ("sbcl" "--dynamic-space-size" "8GB" "--core" "/usr/share/sbcl/custom")))
        slime-default-lisp 'sbcl-custom)
  (defvar slime-repl-font-lock-keywords lisp-el-font-lock-keywords-2)
  (defun slime-repl-font-lock-setup ()
    (setq font-lock-defaults
          '(slime-repl-font-lock-keywords
            ;; From lisp-mode.el
            nil nil (("+-*/.<>=!?$%_&~^:@" . "w")) nil
            (font-lock-syntactic-face-function
             . lisp-font-lock-syntactic-face-function))))
  (add-hook 'slime-repl-mode-hook 'slime-repl-font-lock-setup)
  (defadvice slime-repl-insert-prompt (after font-lock-face activate)
    (let ((inhibit-read-only t))
      (add-text-properties
       slime-repl-prompt-start-mark (point)
       '(font-lock-face
         slime-repl-prompt-face
         rear-nonsticky
         (slime-repl-prompt read-only font-lock-face intangible))))))

(use-package slime-company
  :defer 3
  :ensure t
  :after (slime company)
  :init
  (slime-setup '(slime-fancy slime-company))
  :config
  (with-eval-after-load 'company
    (setq slime-company-completion 'fuzzy
          slime-company-after-completion 'slime-company-just-one-space)
    (add-to-list 'company-backends 'company-slime)))

(provide 'slime-settings)
;;; slime-settings.el ends here
