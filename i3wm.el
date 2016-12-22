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

(defun i3wm-workspace (workspace)
  "I3wm-command WORKSPACE.

Switch to the given i3 workspace"
  (i3wm-command "workspace %s" workspace))

(defun i3wm-workspace-numbered (number)
  "I3wm-workspace-numbered NUMBER.

Switch to the workspace with the given number."
  (i3wm-command "workspace number %d" number))

(defun i3wm-workspace-next ()
  "I3wm-workspace-next.

Switch to the next workspace."
  (i3wm-command "workspace next"))

(defun i3wm-workspace-prev ()
  "I3wm-workspace-prev.

Switch to the previous workspace."
  (i3wm-command "workspace prev"))

(defun i3wm-split-horizontally ()
  "I3wm-split-horizontally.

Split the current container horizontally."
  (i3wm-command "split h"))

(defun i3wm-split-vertically ()
  "I3wm-split-vertically.

Split the current container vertically."
  (i3wm-command "split v"))

(defun i3wm-stacking ()
  "I3wm-stacking.

Switch to a stacking layout."
  (i3wm-command "layout stacking"))

(defun i3wm-tabbed ()
  "I3wm-tabbed.

Switch to a tabbed layout."
  (i3wm-command "layout tabbed"))

(defun i3wm-fullscreen ()
  "I3wm-fullscreen.

Switch to a fullscreen layout."
  (i3wm-command "fullscreen toggle"))

(defun i3wm-floating ()
  "I3wm-floating.

Toggle container floating."
  (i3wm-command  "floating toggle"))

;; Interactive commands

(defun i3wm-switch-to-workspace (workspace)
  "I3wm-switch-to-workspace WORKSPACE.

If called interactively, prompt for and provide completion for
workspace name and switch to it."
  (interactive (list (completing-read "Workspace Name: "
                                      (mapcar (lambda (workspace)
                                                (cdr (assoc 'name workspace)))
                                              (i3wm-get-workspaces)))))
  (i3wm-workspace workspace))

(defun i3wm-switch-to-workspace-number (number)
  "I3wm-switch-to-workspace-number NUMBER.

If called interactively, prompt for a workspace number and
switch."
  (interactive (list (read-number "Workspace Number: ")))
  (i3wm-workspace-numbered number))

(provide 'i3wm)

;;; i3wm.el ends here
