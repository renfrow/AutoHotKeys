#Requires AutoHotkey v2.0.11+

; Written by Thomas R. Kimpton, ahk@gooberdude.com

;#include "C:\Users\Public\AutoHotkey\Lib\ExplorerSelection.ahk"
;#include "C:\Users\Public\AutoHotkey\Lib\BringProcessPIDToFront.ahk"

; This hotkey will open all the directories selected
; in Explorer in their own window.  This is ONLY active
; if the active window is a File Explorer window.
#HotIf WinActive('ahk_class CabinetWClass')

OpenInFileExplorer()
{
  files := []
  files := ExplorerGetSelectedItems()
  aFile := 0
  for aFile in files
  {
    fileVal := ' `"' . aFile.Path . '`"'
    run "explorer.exe" fileVal
  }
}
#HotIf

