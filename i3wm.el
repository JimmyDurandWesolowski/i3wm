;;; i3wm.el --- i3wm integration library

;; Copyright (C) 2016 Samuel Flint

;; Author: Samuel W. Flint <swflint@flintfam.org>
;; Version: 0.5
;; Package-requires: ((cl-lib "0.5") (json))
;; Keywords: convenience, exteensions
;; URL: https://git.flintfam.org/swflint/emacs-i3wm

;;; Commentary:
;;



;;; Code:

(require 'json)
(require 'cl-lib)

;;; Primitive functions:

(defun i3wm-command (command &rest arguments)
  "I3wm-command COMMAND &rest ARGUMENTS.

Execute the givenn COMMAND with the given ARGUMENTS."
  (json-read-from-string
   (shell-command-to-string
    (format "i3-msg \"%s\"" (apply #'format command arguments)))))

(defun i3wm-get-workspaces ()
  "I3wm-get-workspaces.

List all workspaces."
  (json-read-from-string
   (shell-command-to-string "i3-msg -t get_workspaces")))

(defun i3wm-get-outputs ()
  "I3wm-get-outputs.

List all outputs."
  (json-read-from-string
   (shell-command-to-string "i3-msg -t get_outputs")))

(defun i3wm-get-version ()
  "I3wm-get-version.

Retrieve i3 version."
  (json-read-from-string
   (shell-command-to-string "i3-msg -t get_version")))

;;; i3 commands

(defun i3wm-exec (program)
  "I3wm-exec PROGRAM.

Executes the given PROGRAM."
  (i3wm-command "exec %s" program))

(defun i3wm-exec-no-startup-id (program)
  "I3wm-exec-no-startup-id PROGRAM.

Execute the given PROGRAM with --no-startup-id."
  (i3wm-command "exec --no-startup-id %s" program))

(provide 'i3wm)

;;; i3wm.el ends here
