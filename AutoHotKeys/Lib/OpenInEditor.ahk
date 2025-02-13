#Requires AutoHotkey v2.0.11+

; C:\Users\Public\ is a folder available
; to and writable by all users on a windows computer.
; You will need to create AutoHotkey\Lib\ and put
; ExplorerSelection.ahk into it.
;#include "C:\Users\Public\AutoHotkey\Lib\ExplorerSelection.ahk"
;#include "C:\Users\Public\AutoHotkey\Lib\AHKEnv.ahk"
;#include "C:\Users\Public\AutoHotkey\Lib\BringProcessPIDToFront.ahk"

; The first hotkey will edit all the files selected
; in Explorer with a single editor. The second will
; edit all the files selected in their own editor. They
; are ONLY active if the active window is a File
; Explorer window.
#HotIf WinActive('ahk_class CabinetWClass')

; Replace 'F1' with whatever key you want to use,
; prepending '+' for shift, '^' for control, '!' for
; alt, and '#' for win. Thus '+#PgDn' will activate
; with shift-win-PgDn. The modifiers may be in
; any order. Use the following for the key names:
; https://www.autohotkey.com/docs/v2/KeyList.htm
; This hotkey passes all the selected files to
; a single editor.
OpenInEditor()
{
  RunProcessInFront(editor ExplorerGetSelection())
}
; This hotkey passes all the selected files to
; an editor for each one.
OpenInMultipleEditor()
{
  files := []
  files := ExplorerGetSelectedItems()
  aFile := 0
  for aFile in files
  {
    fileVal := ' `"' . aFile.Path . '`"'
    RunProcessInFront(editor fileVal)
  }
}
#HotIf

; These editor commands may be issued from any app.

; Open a new editor, with no file, from any app.
; Replace the key with whatever key you want to use.
OpenEditor()
{
MsgBox "got here OpenEditor()!"
  Run editor
}

; Edit the AHKEnv file. You'll need to rerun any
; AutoHotKey that uses the changed/new environment
; variables.
; Replace the key with whatever key you want to use.
EditAHKEnvFile()
{
  envFile := getAHKEnvValue("envFile")
  fileVal := ' `"' . envFile . '`"'
  Runwait editor fileVal
  reloadAHKEnv()
}

