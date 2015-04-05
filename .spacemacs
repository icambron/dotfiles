(setq-default dotspacemacs-configuration-layers '(themes-megapack clojure ruby markdown git dockerfile
                                                 (colors :variables colors-enable-rainbow-identifiers t)))
(setq-default dotspacemacs-excluded-packages '(smartparens))
(setq-default dotspacemacs-themes '(wheatgrass))
(setq-default show-trailing-whitespace t)
(setq evil-want-fine-undo 'no)
(setq magit-last-seen-setup-instructions "1.4.0")
(global-linum-mode t)

(defun dotspacemacs/config ()
  (global-hl-line-mode -1))

(setq undo-tree-auto-save-history t
      undo-tree-history-directory-alist
      `(("." . ,(concat spacemacs-cache-directory "undo"))))

(unless (file-exists-p (concat spacemacs-cache-directory "undo"))
  (make-directory (concat spacemacs-cache-directory "undo")))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(rainbow-delimiters-depth-1-face ((t (:foreground "#fe1515"))))
 '(rainbow-delimiters-depth-2-face ((t (:foreground "#5faeff"))))
 '(rainbow-delimiters-depth-3-face ((t (:foreground "#ff5f5f"))))
 '(rainbow-delimiters-depth-4-face ((t (:foreground "#37ff37"))))
 '(rainbow-delimiters-depth-5-face ((t (:foreground "#8686ff"))))
 '(rainbow-delimiters-depth-6-face ((t (:foreground "#ff6464"))))
 '(rainbow-delimiters-depth-7-face ((t (:foreground "#37ff37"))))
 '(rainbow-delimiters-depth-8-face ((t (:foreground "#8686ff"))))
 '(rainbow-delimiters-depth-9-face ((t (:foreground "#fe5151")))))
