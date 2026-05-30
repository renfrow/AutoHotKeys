#Requires AutoHotkey v2.0.11+

; Written by Thomas R. Kimpton, ahk@gooberdude.com

;#include "C:\Users\Public\AutoHotkey\Lib\ExplorerSelection.ahk"
;#include "C:\Users\Public\AutoHotkey\Lib\AHKEnv.ahk"
;#include "C:\Users\Public\AutoHotkey\Lib\BringProcessPIDToFront.ahk"

; The first function will edit all the files selected
; in Explorer with a single editor. The second will
; edit all the files selected in their own editor. They
; are ONLY active if the active window is a File
; Explorer window.
#HotIf WinActive('ahk_class CabinetWClass')

; This function passes all the selected files to
; a single editor.
OpenInEditor()
{
  RunProcessInFront(editor ExplorerGetSelection())
}
; This function passes all the selected files to
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
OpenEditor()
{
  Run editor
}

; Edit the parameter file.
EditAFile(inputFile)
{
  ; Enclose the file name with quotes to protect
  ; against file names with whitespace in them.
  fileVal := ' `"' . inputFile . '`"'
  RunProcessInFront(editor fileVal)
}

; Pass an array of files, edit them with one editor.
EditSeveralFiles(files)
{
  fileVal := ""
  for item in files
  {
    fileVal .= '`"' . item.Path . '`"'
  }
  RunProcessInFront(editor fileVal)
}
