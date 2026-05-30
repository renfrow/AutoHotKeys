#Requires AutoHotkey v2.0.11+

; Uncomment this if you want the hotkey to only
; run if it is run in:
;   File Explorer.
;#HotIf WinActive('ahk_class CabinetWClass')
;   IntelliJ.
;#HotIf WinActive('ahk_exe idea64.exe')
;   Vim.
;#HotIf WinActive('ahk_class Vim')
;   Firefox.
;#HotIf WinActive('ahk_exe firefox.exe')
; Remember to uncomment the #HotIf at the end
; of the file!

; C:\Users\Public\Documents\ is a folder available
; to and writable by all users on a windows computer.
; You will need to create AutoHotkey\Lib\ and put
; any libraries you use into it. Use an include
; for every library you use.
;#include "C:\Users\Public\Documents\AutoHotkey\Lib\REPLACE_ME.ahk"

; Add a variable for every external program you use.
; Replace this with whatever editor you prefer to use.
;editor := "C:\Program Files\Vim\vim91\gvim.exe"

; Replace 'F1' with whatever key you want to use,
; prepending '+' for shift, '^' for control, '!' for
; alt, and '#' for win. Thus '+#PgDn' will activate
; with shift-win-PgDn. The modifiers may be in
; any order. Use the following for the key names:
; https://www.autohotkey.com/docs/v2/KeyList.htm
;    This hotkey passes all the selected files to
;    a single editor.
;    F1::
;    {
;      Run editor ExplorerGetSelection()
;    }
;    This hotkey passes all the selected files to
;    an editor for each one.
;    +F1::
;    {
;      files := []
;      files := ExplorerGetSelectedItems()
;      aFile := 0
;      for aFile in files
;      {
;        fileVal := ' `"' . aFile.Path . '`"'
;        Run editor fileVal
;      }
Return
;#HotIf

