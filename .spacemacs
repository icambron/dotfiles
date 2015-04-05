(setq-default dotspacemacs-configuration-layers '(themes-megapack clojure ruby markdown git dockerfile
                                                 (colors :variables colors-enable-rainbow-identifiers t)))
(setq-default dotspacemacs-excluded-packages '(smartparens))
(setq-default dotspacemacs-themes '(wheatgrass))
(setq-default show-trailing-whitespace t)
(setq evil-want-fine-undo 'no)
(setq magit-last-seen-setup-instructions "1.4.0")
(setq vc-follow-symlinks nil)
;;(setq system-uses-terminfo nil)
(global-linum-mode t)

(defun dotspacemacs/config ()
  ;;override the theme's crazy trailing whitespace rage
  (set-face-background 'trailing-whitespace "dim gray")
  (global-hl-line-mode -1))

(setq undo-tree-auto-save-history t
      undo-tree-history-directory-alist
      `(("." . ,(concat spacemacs-cache-directory "undo"))))

(unless (file-exists-p (concat spacemacs-cache-directory "undo"))
  (make-directory (concat spacemacs-cache-directory "undo")))

(with-eval-after-load 'rainbow-delimiters
  (require 'color)
  (dotimes (i (- rainbow-delimiters-max-face-count 1))
    (let ((face (rainbow-delimiters-default-pick-face (+ i 1) t nil)))
        (set-face-foreground face (color-saturate-name (face-foreground face) 60)))))

(add-hook 'term-mode-hook
          (lambda ()
            (setq term-buffer-maximum-size 10000)))
