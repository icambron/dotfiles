;; -*- mode: Emacs-Lisp -*-

(defun dotspacemacs/layers ()
  (setq-default dotspacemacs-configuration-layers '(auto-completion
                                                    clojure
                                                    colors
                                                    javascript
                                                    dash
                                                    docker
                                                    ess
                                                    emacs-lisp
                                                    git
                                                    html
                                                    markdown
                                                    nginx
                                                    osx
                                                    ruby
                                                    yaml
                                                    syntax-checking
                                                    smex
                                                    shell
                                                    sql
                                                    spell-checking)
                dotspacemacs-additional-packages '(prettier-js)))

(defun dotspacemacs/init ()
  (setq-default
   dotspacemacs-enable-lazy-installation nil

   ;;rainbow delimiters, but no special highlighting for the "current" one
   dotspacemacs-highlight-delimiters 'any

   ;;these are annoying
   dotspacemacs-excluded-packages '(smartparens evil-little-word)

   ;;dark, duh
   dotspacemacs-themes '(spacemacs-dark)

   ;;spacemacs issues a weird--and as far as I can tell, incorrect--warning about having exports in my .zshrc file unless I do this
   exec-path-from-shell-check-startup-files nil))

(defun dotspacemacs/user-init ()

  ;;this is silly, but for some reason launching emacs in the terminal requires deleting bracketed-paste
  ;;but that deletion fails. The deletion is dumb but failing is dumber, so this makes it work
 (if (executable-find "trash")
      (defun system-move-file-to-trash (file)
        "Use `trash' to move FILE to the system trash.
Can be installed with `brew install trash', or `brew install osxutils`''."
        (call-process (executable-find "trash") nil 0 nil file))
    ;; regular move to trash directory
    (setq trash-directory "~/.Trash/emacs")))

(defun dotspacemacs/user-config ()

  ;; https://github.com/syl20bnr/spacemacs/issues/9549
  (require 'helm-bookmark)

  (setq-default fill-column 100)
  (setq recentf-save-file (format "/tmp/recentf.%s" (emacs-pid)))

  ;;general settings
  (setq show-trailing-whitespace t
        evil-want-fine-undo 'no
        make-backup-files nil
        backup-directory-alist '((".*" . "~/.emacs.d/backups/"))
        magit-last-seen-setup-instructions "1.4.0"
        vc-follow-symlinks nil
        flycheck-rubocop-lint-only t
        flycheck-check-syntax-automatically '(mode-enabled save)
        system-uses-terminfo nil
        shell-file-name "zsh")

  ;;indents
  (setq evil-shift-width 2
        coffee-tab-width 2
        css-indent-offset 2
        js2-basic-offset 2
        js-indent-level 2
        js2-bounce-indent-p t)

  (setq prettier-js-args '("--single-quote" "--print-width" "100"))

  ;unbold all the things
  (mapc
   (lambda (face)
     (set-face-attribute face nil :weight 'normal))
   (face-list))

  ;;override some colors from the theme, mostly to make things brighter
  (set-face-background 'default "gray5")
  (set-face-background 'region "#284050")
  (set-face-background 'font-lock-comment-face nil)

  ;;change some of the colors when not in terminal
  (when (display-graphic-p)
    (set-face-foreground 'font-lock-keyword-face "#dbbe00")          ;;yellow
    (set-face-foreground 'font-lock-constant-face "#e98e25")         ;;orange
    (set-face-foreground 'font-lock-type-face "#82a6df")             ;;light blue
    (set-face-foreground 'font-lock-function-name-face "#ea4873"))   ;;pink

  ;;save undo tree across sessions
  (setq undo-tree-auto-save-history t
        undo-tree-history-directory-alist
        `(("." . ,(concat spacemacs-cache-directory "undo"))))
  (unless (file-exists-p (concat spacemacs-cache-directory "undo"))
    (make-directory (concat spacemacs-cache-directory "undo")))

  (add-hook 'js2-mode-hook 'prettier-js-mode))

;;for some reason, trying to turn this off here disables all the highlighting for ruby...
;;but if i put it in the (user-config) section, it won't work becasue the face hasn't been created yet
;;(with-eval-after-load 'enh-ruby-mode
;;  (set-face-background 'enh-ruby-op-face nil))
;;so we do this dumb thing instead
(add-hook 'enh-ruby-mode-hook (lambda () (set-face-background 'enh-ruby-op-face nil)))

;;make a "word" in Clojure span over hyphens
(add-hook 'clojure-mode-hook #'(lambda () (modify-syntax-entry ?- "w")))

;;errors with less eyeball murder
(with-eval-after-load 'flycheck
  (set-face-attribute 'flycheck-error nil :underline "IndianRed3"))

;;again, eyeball murder is frowned on
(with-eval-after-load 'cider
  (set-face-attribute 'cider-error-highlight-face nil :underline "IndianRed3"))

;;up the saturation of colored delimiters
(with-eval-after-load 'rainbow-delimiters
  (require 'color)
  (dotimes (i (- rainbow-delimiters-max-face-count 1))
    (let ((face (rainbow-delimiters-default-pick-face (+ i 1) t nil)))
      (set-face-foreground face (color-saturate-name (face-foreground face) 30)))))
