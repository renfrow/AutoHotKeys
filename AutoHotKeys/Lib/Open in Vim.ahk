#Requires AutoHotkey v2.0.11+

; Replace this with whatever editor you prefer to use.
editor := "C:\Program Files\Vim\vim91\gvim.exe"

; The first hotkey will edit all the files selected
; in Explorer with a single vim. The second will
; edit all the files selected in their own vim. They
; are ONLY ; active if the active window is a File
; Explorer window.
#HotIf WinActive('ahk_class CabinetWClass')

; C:\Users\Public\Documents\ is a folder available
; to and writable by all users on a windows computer.
; You will need to create AutoHotkey\Lib\ and put
; ExplorerSelection.ahk into it.
#include "C:\Users\Public\Documents\AutoHotkey\Lib\ExplorerSelection.ahk"

; Replace 'F1' with whatever key you want to use,
; prepending '+' for shift, '^' for control, '!' for
; alt, and '#' for win. Thus '+#PgDn' will activate
; with shift-win-PgDn. The modifiers may be in
; any order. Use the following for the key names:
; https://www.autohotkey.com/docs/v2/KeyList.htm
; This hotkey passes all the selected files to
; a single editor.
F1::
{
  Run editor ExplorerGetSelection()
}
; This hotkey passes all the selected files to
; an editor for each one.
+F1::
{
  files := []
  files := ExplorerGetSelectedItems()
  aFile := 0
  for aFile in files
  {
    fileVal := ' `"' . aFile.Path . '`"'
    Run editor fileVal
  }
}
#HotIf

; Open a new editor, with no file, from any app.
^+4::
{
  Run editor
}
Return
