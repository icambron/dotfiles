(setq-default dotspacemacs-configuration-layers '(clojure
                                                  colors
                                                  dockerfile
                                                  emacs-lisp
                                                  git
                                                  html
                                                  markdown
                                                  ruby
                                                  shell
                                                  spotify
                                                  themes-megapack)
              dotspacemacs-enable-paste-micro-state nil
              dotspacemacs-excluded-packages '(smartparens)
              dotspacemacs-themes '(ujelly)
              evil-shift-width 2
              show-trailing-whitespace t)

(setq evil-want-fine-undo 'no
      css-indent-offset 2
      js2-basic-offset 2
      js2-bounce-indent-p t
      magit-last-seen-setup-instructions "1.4.0"
      vc-follow-symlinks nil
      flycheck-rubocop-lint-only t
      flycheck-check-syntax-automatically '(mode-enabled save)
      system-uses-terminfo nil)

(defun dotspacemacs/config ()
  ;;override the theme's crazy trailing whitespace rage
  (set-face-background 'trailing-whitespace "dim gray")
  ;;the theme doesn't help with the persistent highlighting, which is impossible to read
  (set-face-attribute 'evil-search-highlight-persist-highlight-face nil
                      :foreground "white"
                      :background "sea green")
  ;;the theme's hl-line-face inherits from 'highlight, which sets the foreground color to white
  (set-face-attribute hl-line-face nil
                      :inherit nil
                      :background "gray9")
  ;;todo: this doesn't work on load, need to do this later?
  ;(set-face-attribute 'helm-selection nil
  ;                    :inherit nil
  ;                    :background "gray9")
)

(setq undo-tree-auto-save-history t
      undo-tree-history-directory-alist
      `(("." . ,(concat spacemacs-cache-directory "undo"))))

(unless (file-exists-p (concat spacemacs-cache-directory "undo"))
  (make-directory (concat spacemacs-cache-directory "undo")))

;;change the saturation of colored delimiters
(with-eval-after-load 'rainbow-delimiters
  (require 'color)
  (dotimes (i (- rainbow-delimiters-max-face-count 1))
    (let ((face (rainbow-delimiters-default-pick-face (+ i 1) t nil)))
        (set-face-foreground face (color-saturate-name (face-foreground face) 60)))))

(add-hook 'term-mode-hook (lambda () (setq term-buffer-maximum-size 10000)))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ahs-case-fold-search nil)
 '(ahs-default-range (quote ahs-range-whole-buffer))
 '(ahs-idle-interval 0.25)
 '(ahs-idle-timer 0 t)
 '(ahs-inhibit-face-list nil)
 '(paradox-github-token t)
 '(ring-bell-function (quote ignore) t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((((class color) (min-colors 89)) (:foreground "#ffffff" :background "#000000")))))
