;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(setq user-full-name "tarmuid"
      user-mail-address "tarmuid@pm.me")

(setq doom-theme 'doom-tokyo-night
      doom-font (font-spec :family "JetBrainsMono Nerd Font" :size 12))

(dolist (frame-setting '((width . 150)
                         (height . 50)
                         (inhibit-double-buffering . t)))
  (add-to-list 'default-frame-alist frame-setting)
  (add-to-list 'initial-frame-alist frame-setting))

(setq display-line-numbers-type t)

(setq evil-split-window-below t
      evil-vsplit-window-right t)

(setq org-directory "~/org/"
      org-roam-directory org-directory
      org-roam-db-location (file-name-concat org-directory ".org-roam.db")
      org-roam-dailies-directory "journal/"
      org-log-done-with-time nil)

(after! org
  (add-to-list 'org-modules 'org-habit)
  (setq org-startup-folded 'show2levels
        org-agenda-files (list org-directory)
        org-ellipsis " [...] "
        org-capture-templates
        '(("t" "todo" entry (file+headline "todo.org" "Inbox")
           "* TODO %?"
           :prepend t))))

(use-package! denote
  :init
  (setq denote-directory (expand-file-name "notes/" org-directory)
        denote-file-type 'org
        denote-infer-keywords t
        denote-sort-keywords t
        denote-allow-multi-word-keywords t
        denote-prompts '(title keywords))
  :config
  (add-hook 'dired-mode-hook #'denote-dired-mode-in-directories)
  (map! :leader
        (:prefix ("n d" . "denote")
         :desc "New note" "n" #'denote
         :desc "New note (type)" "t" #'denote-type
         :desc "Open note" "f" #'denote-find-file
         :desc "Insert link" "l" #'denote-link
         :desc "Backlinks" "b" #'denote-link-backlinks
         :desc "Rename file" "r" #'denote-rename-file
         :desc "Dired rename" "R" #'denote-dired-rename-file
         :desc "Add link to buffer" "a" #'denote-link-add-links)))


(use-package dired
  :defer t
  :config
  (when (and (eq system-type 'darwin) (executable-find "gls"))
    (setq insert-directory-program "gls")))

(use-package! ai-code-interface
  :config
  (ai-code-set-backend 'codex)
  ;; Main transient menu
  (global-set-key (kbd "C-c a") #'ai-code-menu)

  ;; Optional: faster auto-revert so Codex edits show up quickly
  (global-auto-revert-mode 1)
  (setq auto-revert-interval 1))
