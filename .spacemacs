(setq-default dotspacemacs-configuration-layers '(clojure
                                                  colors
                                                  dockerfile
                                                  emacs-lisp
                                                  git
                                                  html
                                                  markdown
                                                  ruby
                                                  shell
                                                  spotify)
              dotspacemacs-highlight-delimiters nil
              dotspacemacs-enable-paste-micro-state nil
              dotspacemacs-enable-helm-micro-state nil
              dotspacemacs-excluded-packages '(smartparens)
              dotspacemacs-themes '(spacemacs-dark)
              evil-shift-width 2
              show-trailing-whitespace t)

(defun dotspacemacs/config ()

  ;;the theme doesn't help with the persistent highlighting, which is impossible to read
  (set-face-attribute 'evil-search-highlight-persist-highlight-face nil
                      :foreground "white"
                      :background "sea green")

  ;;unbold all the things
  (mapc
   (lambda (face)
     (set-face-attribute face nil :weight 'normal :underline nil))
   (face-list))

  ;;override some colors from the theme, mostly to make things brighter
  (set-face-background 'default "gray5")
  (set-face-background 'region "#284050")
  (set-face-background 'font-lock-comment-face nil)

  (when (display-graphic-p)
    (set-face-foreground 'font-lock-keyword-face "#dbbe00")          ;;yellow
    (set-face-foreground 'font-lock-constant-face "#e98e25")         ;;orange
    (set-face-foreground 'font-lock-type-face "#82a6df")             ;;light blue
    (set-face-foreground 'font-lock-function-name-face "#ea4873")    ;;pink
  )
)

;;for some reason, trying to turn this off here disables all the highlighting for ruby...
;;(with-eval-after-load 'enh-ruby-mode
;;  (set-face-background 'enh-ruby-op-face nil))

;;up the saturation of colored delimiters
(with-eval-after-load 'rainbow-delimiters
  (require 'color)
  (dotimes (i (- rainbow-delimiters-max-face-count 1))
    (let ((face (rainbow-delimiters-default-pick-face (+ i 1) t nil)))
      (set-face-foreground face (color-saturate-name (face-foreground face) 60)))))

(setq evil-want-fine-undo 'no
      css-indent-offset 2
      js2-basic-offset 2
      js2-bounce-indent-p t
      magit-last-seen-setup-instructions "1.4.0"
      vc-follow-symlinks nil
      flycheck-rubocop-lint-only t
      flycheck-check-syntax-automatically '(mode-enabled save)
      system-uses-terminfo nil
      shell-file-name "zsh")

;;save undo tree across sessions
(setq undo-tree-auto-save-history t
      undo-tree-history-directory-alist
      `(("." . ,(concat spacemacs-cache-directory "undo"))))
(unless (file-exists-p (concat spacemacs-cache-directory "undo"))
  (make-directory (concat spacemacs-cache-directory "undo")))
