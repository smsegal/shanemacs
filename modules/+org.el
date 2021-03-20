;; -*- lexical-binding: t; -*-

;; We don't do much to customize Org. Set the notes directory for
;; ~org-capture~, enable some languages to be evaled in ~src~ blocks.
;; I also set up fancy heading symbols with org bullets.

;; I'm aiming to translate a lot of keys to vim-like equivalents, using
;; leader keys to replace the special ~C-c~ bindings.
(use-package org
  :straight nil
  :init
  (setq org-startup-indented t)
  (setq org-src-fontify-natively t)
  (setq org-directory "~/Documents/org")
  (setq org-default-notes-file (concat org-directory "/notes.org"))
  (setq org-export-backends '(beamer html md man latex))
  :config
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((emacs-lisp . t)
     (python . t)))
  :hook (org-mode . visual-line-mode)
  :general
  (:prefix-map '+open-map
   "c" #'org-capture)
  (+local-leader-def :keymaps 'org-mode-map
    "," #'org-ctrl-c-ctrl-c
    "'" #'org-edit-special
    "t" #'org-todo
    "o" #'org-open-at-point)
  (+local-leader-def :keymaps 'org-src-mode-map
    "," #'org-edit-src-exit
    "k" #'org-edit-src-abort))

(use-package org-superstar
  :straight nil
  :ghook ('org-mode-hook #'org-superstar-mode)
  :custom (org-superstar-special-todo-items t))

;; Table of Contents
;; Have an auto-updated TOC, primarily for github readme support
(use-package toc-org
  :straight nil
  :hook (org-mode . toc-org-mode))

(provide '+org)
