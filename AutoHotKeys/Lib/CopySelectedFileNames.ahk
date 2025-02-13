#Requires AutoHotkey v2.0.11+

; Uncomment this if you want the hotkey to only
; run if it is run in:
;   File Explorer.
#HotIf WinActive('ahk_class CabinetWClass')

; C:\Users\Public\ is a folder available
; to and writable by all users on a windows computer.
; You will need to create AutoHotkey\Lib\ and put
; any libraries you use into it. Use an include
; for every library you use.
;#include "C:\Users\Public\AutoHotkey\Lib\ExplorerSelection.ahk"

; Replace 'F1' with whatever key you want to use,
; prepending '+' for shift, '^' for control, '!' for
; alt, and '#' for win. Thus '+#PgDn' will activate
; with shift-win-PgDn. The modifiers may be in
; any order. Use the following for the key names:
; https://www.autohotkey.com/docs/v2/KeyList.htm
;    This hotkey passes all the selected files to
;    a single editor.
CopySelectedFileNames()
{
   A_Clipboard := ExplorerGetSelection()
}
#HotIf

