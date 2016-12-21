;;; i3wm.el --- i3wm integration library for emacs

;; Copyright (C) 2016 Samuel Flint

;; Author: Samuel W. Flint <swflint@flintfam.org>
;; Version: 0.5
;; Package-requires: ((cl-lib "0.5") json)
;; Keywords: i3
;; URL: https://git.flintfam.org/swflint/emacs-i3wm

;;; Commentary:
;;



;;; Code:

(require 'json)
(require 'cl-lib)

(defun i3-command (command &rest arguments)
  "I3-command COMMAND &rest ARGUMENTS.

Execute the givenn COMMAND with the given ARGUMENTS."
  (json-read-from-string
   (shell-command-to-string
    (format "i3-msg \"%s\"" (apply #'format command arguments)))))

(defun i3-get-workspaces ()
  "I3-get-workspaces.

List all workspaces."
  (json-read-from-string
   (shell-command-to-string "i3-msg -t get_workspaces")))

(defun i3-get-outputs ()
  "I3-get-outputs.

List all outputs."
  (json-read-from-string
   (shell-command-to-string "i3-msg -t get_outputs")))

(defun i3-get-version ()
  "I3-get-version.

Retrieve i3 version."
  (json-read-from-string
   (shell-command-to-string "i3-msg -t get_version")))

(provide 'i3wm)

;;; i3wm.el ends here
