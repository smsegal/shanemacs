;;; early-init.el -*- lexical-binding: t; -*-
;; mostly taken from doom emacs

(setq package-enable-at-startup nil)
(advice-add #'package--ensure-init-file :override #'ignore)

;; Prevent the glimpse of un-styled Emacs by disabling these UI elements early.
(push '(menu-bar-lines . 0) default-frame-alist)
(push '(tool-bar-lines . 0) default-frame-alist)
(push '(vertical-scroll-bars) default-frame-alist)

(defvar default-gc-cons-threshold 16777216 ; 16mb
  "my default desired value of `gc-cons-threshold'
during normal emacs operations.")

;; make garbage collector less invasive
(setq gc-cons-threshold  most-positive-fixnum
      gc-cons-percentage 0.6)

(setq default-file-name-handler-alist file-name-handler-alist
      file-name-handler-alist nil)

;; Resizing the Emacs frame can be a terribly expensive part of changing the
;; font. By inhibiting this, we easily halve startup times with fonts that are
;; larger than the system default.
(setq frame-inhibit-implied-resize t)

;; needs to be set before straight.el is loaded in order to fix
;; flycheck temp file creation
(setq straight-fix-flycheck t)

;; Ignore X resources; its settings would be redundant with the other settings
;; in this file and can conflict with later config (particularly where the
;; cursor color is concerned).
(fset #'x-apply-session-resources #'ignore)

;; reset the changes made here after the end of startup
(add-hook 'emacs-startup-hook
          (lambda (&rest _)
            (setq gc-cons-threshold default-gc-cons-threshold
                  gc-cons-percentage 0.1
                  file-name-handler-alist default-file-name-handler-alist)

            ;; delete no longer necessary startup variable
            (makunbound 'default-file-name-handler-alist)))
