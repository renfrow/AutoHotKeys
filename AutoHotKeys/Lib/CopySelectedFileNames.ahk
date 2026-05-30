#Requires AutoHotkey v2.0.11+

; Written by Thomas R. Kimpton, ahk@gooberdude.com

; Only run if it is run in File Explorer.
#HotIf WinActive('ahk_class CabinetWClass')

;#include "C:\Users\Public\AutoHotkey\Lib\ExplorerSelection.ahk"

;  This hotkey copies the names of all the selected
;  files to the clipboard. If the parameter is
;  not 0 it surrounds the names with double quotes.
CopySelectedFileNames(surroundWithQuotes := 0)
{
  files := []
  files := ExplorerGetSelectedItems()
  aFile := 0
  A_Clipboard := ""
  for aFile in files
  {
    if surroundWithQuotes == 0
    {
      fileVal := aFile.Path
    }
    else
    {
      fileVal := ' `"' . aFile.Path . '`"'
    }
    A_Clipboard .= fileVal
    A_Clipboard .= '`n'
  }
}
#HotIf

