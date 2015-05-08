(setq-default dotspacemacs-configuration-layers '(themes-megapack clojure ruby markdown git dockerfile colors html)
              dotspacemacs-excluded-packages '(smartparens)
              dotspacemacs-themes '(smyx)
              evil-shift-width 2
              show-trailing-whitespace t)

(setq evil-want-fine-undo 'no
      css-indent-offset 2
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
