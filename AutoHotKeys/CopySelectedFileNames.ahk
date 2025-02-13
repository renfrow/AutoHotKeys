#Requires AutoHotkey v2.0.11+

; Uncomment this if you want the hotkey to only
; run if it is run in:
;   File Explorer.
#HotIf WinActive('ahk_class CabinetWClass')

; C:\Users\Public\Documents\ is a folder available
; to and writable by all users on a windows computer.
; You will need to create AutoHotkey\Lib\ and put
; any libraries you use into it. Use an include
; for every library you use.
#include "C:\Users\Public\Documents\AutoHotkey\Lib\ExplorerSelection.ahk"

; Replace 'F1' with whatever key you want to use,
; prepending '+' for shift, '^' for control, '!' for
; alt, and '#' for win. Thus '+#PgDn' will activate
; with shift-win-PgDn. The modifiers may be in
; any order. Use the following for the key names:
; https://www.autohotkey.com/docs/v2/KeyList.htm
;    This hotkey copies all the paths to all selected
;    files to a the clipboard.
^!+C::
{
   A_Clipboard := ExplorerGetSelection()
}
;    This hotkey copies the name of the (first) selected
;    file to a the clipboard.
^+C::
{
  files := []
  files := ExplorerGetSelectedItems()
  filePath := files[1]
  fileName := ""
  A_Clipboard := SplitPath filePath, &fileName
}
Return
#HotIf

