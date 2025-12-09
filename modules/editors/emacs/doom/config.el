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
      org-roam-capture-templates
      '(("n" "note" plain "%?"
         :target (file+head
                  "%<%Y%m%dT%H%M%S>--${slug}%(my/org-roam-denote-keyword-suffix).org"
                  "#+title:      ${title}\n#+date:       %<%Y-%m-%d %H:%M>\n#+filetags:   %(my/org-roam-denote-filetags)\n#+identifier: %<%Y%m%dT%H%M%S>\n\n")
         :unnarrowed t))
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

(use-package dired
  :defer t
  :config
  (when (and (eq system-type 'darwin) (executable-find "gls"))
    (setq insert-directory-program "gls")))

(defvar my/org-roam-denote-last-keywords ""
  "Keywords for the last Org-roam capture, for reuse in templates.")

(defun my/org-roam-denote-keyword-suffix ()
  "Prompt once for Denote-style keywords and return `__kw1_kw2` or \"\"."
  (setq my/org-roam-denote-last-keywords
        (string-trim (downcase
                      (read-string "Keywords (space-separated, optional): "))))
  (if (string-empty-p my/org-roam-denote-last-keywords)
      ""
    (concat "__"
            (replace-regexp-in-string
             "[^[:alnum:]]+" "_"
             my/org-roam-denote-last-keywords))))

(defun my/org-roam-denote-filetags ()
  "Return last keywords as Denote-style :tag1:tag2: string.
Uses `my/org-roam-denote-last-keywords` set by
`my/org-roam-denote-keyword-suffix`."
  (if (or (not (boundp 'my/org-roam-denote-last-keywords))
          (string-empty-p my/org-roam-denote-last-keywords))
      ""
    (let* ((words (split-string my/org-roam-denote-last-keywords "[ ,;]+" t))
           (sanitized
            (mapcar (lambda (w)
                      (replace-regexp-in-string "[^[:alnum:]]+" "_" (downcase w)))
                    words)))
      (concat ":" (mapconcat #'identity sanitized ":") ":"))))

;; (use-package! ai-code-interface
;;   :config
;;   (ai-code-set-backend 'codex)
;;   ;; Main transient menu
;;   (global-set-key (kbd "C-c a") #'ai-code-menu)

;;   ;; Optional: faster auto-revert so Codex edits show up quickly
;;   (global-auto-revert-mode 1)
;;   (setq auto-revert-interval 1))
