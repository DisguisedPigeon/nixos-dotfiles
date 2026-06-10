{ inputs, pkgs }:
inputs.wrappers.wrappers.emacs.wrap {
  inherit pkgs;

  earlyConfigFile = ''
    (let* ((xdg-cache (or (getenv "XDG_CACHE_HOME") "~/.cache"))
           (emacs-backup-dir (expand-file-name "emacs/backups/" xdg-cache)))

      ;; Ensure the directory actually exists so Emacs doesn't throw an error
      (unless (file-exists-p emacs-backup-dir)
        (make-directory emacs-backup-dir t))

      ;; Redirect standard backups (~file)
      (setq backup-directory-alist `(("." . ,emacs-backup-dir)))

      ;; Redirect auto-saves (#file#)
      (setq auto-save-file-name-transforms `((".*" ,emacs-backup-dir t))))

    ;; Optional: Still drop the symlink lockfiles (.#file) if desired
    (setq create-lockfiles nil)
  '';

  configFile = ''
    ;; Disable startup screen
    (setq inhibit-startup-message              t
          visible-bell                         t
          global-auto-revert-non-file-buffers  t
          use-dialog-box                       nil
          display-line-numbers-type            'relative)

    (menu-bar-mode -1)
    (tool-bar-mode -1)
    (scroll-bar-mode -1)

    (global-display-line-numbers-mode 1)

    (recentf-mode 1)

    (setq history-length 25)
    (savehist-mode 1)

    (save-place-mode 1)

    (global-auto-revert-mode 1)

    (require 'evil)
    (evil-mode 1)

    (defun dw/org-mode-setup ()
      (org-indent-mode)
      (variable-pitch-mode 1)
      (auto-fill-mode 0)
      (visual-line-mode 1)
      (setq evil-auto-indent nil))

    (use-package org
      :hook (org-mode . dw/org-mode-setup)
      :config
      (setq org-ellipsis " ▾"
            org-hide-emphasis-markers t))

    (use-package org-bullets
      :after org
      :hook (org-mode . org-bullets-mode)
      :custom
      (org-bullets-bullet-list '("◉" "○" "●" "○" "●" "○" "●")))

    ;; Replace list hyphen with dot
    (font-lock-add-keywords 'org-mode
                            '(("^ *\\([-]\\) "
                              (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))

    ;; Make sure org-indent face is available
    (require 'org-indent)

    ;; Ensure that anything that should be fixed-pitch in Org files appears that way
    (set-face-attribute 'org-block nil :foreground nil :inherit 'fixed-pitch)
    (set-face-attribute 'org-code nil   :inherit '(shadow fixed-pitch))
    (set-face-attribute 'org-indent nil :inherit '(org-hide fixed-pitch))
    (set-face-attribute 'org-verbatim nil :inherit '(shadow fixed-pitch))
    (set-face-attribute 'org-special-keyword nil :inherit '(font-lock-comment-face fixed-pitch))
    (set-face-attribute 'org-meta-line nil :inherit '(font-lock-comment-face fixed-pitch))
    (set-face-attribute 'org-checkbox nil :inherit 'fixed-pitch)

    (load "rose-pine-theme")
    (load-theme 'rose-pine t)
  '';

  emacsPackages =
    epkgs: with epkgs.melpaPackages; [
      evil

      org-bullets

      (epkgs.trivialBuild {
        pname = "pinerose-emacs";
        version = "unstable";
        src = pkgs.fetchFromGitHub {
          owner = "konrad1977";
          repo = "pinerose-emacs";
          rev = "main";
          hash = "sha256-+0/JadJlT8xRfqVvj4vYyrMRcvO2mschzwe58CPJfNU=";
        };
        packageRequires = [ autothemer ];
      })
    ];

  userDirectory = null;
}
