;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-
(setq doom-theme 'doom-tokyo-night
      doom-font (font-spec :family "JetBrainsMono Nerd Font" :size 12))

(setq display-line-numbers-type t)

(setq evil-split-window-below t
      evil-vsplit-window-right t)

(setq org-directory "~/org/"
      org-roam-directory org-directory
      org-roam-dailies-directory "journal/"
      org-log-done-with-time nil)

(after! org
  (add-to-list 'org-modules 'org-habit)
  (setq org-startup-folded 'show2levels
        org-ellipsis " [...] "
        org-capture-templates
        '(("t" "todo" entry (file+headline "todo.org" "Inbox")
           "* [ ] %?"
           :prepend t)
          ("c" "check out later" entry (file+headline "todo.org" "Check out later")
           "* [ ] %?\n%i\n%a"
           :prepend t))))


(use-package dired
  :defer t
  :config
  (when (and (eq system-type 'darwin) (executable-find "gls"))
    (setq insert-directory-program "gls")))