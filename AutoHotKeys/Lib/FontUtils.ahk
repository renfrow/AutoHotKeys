#Requires AutoHotkey v2.0

; Written by Thomas R. Kimpton, ahk@gooberdude.com

; Written with the help of AI.

;#include "C:\Users\Public\AutoHotkey\Lib\Misc.ahk"

; Example usage:
;   CharacterWidth := GetCharacterWidth("Courier New", 12)
;   MsgBox("Character width: " . CharacterWidth . " pixels")

GetCharacterWidth(fontName, fontSize, character)
{
  GetCharacterWidthGui := Gui()
  GetCharacterWidthGui.SetFont("s" fontSize, fontName)
  ; Add a text control with the character, 'r1' for 1 row
  txtCtrl := GetCharacterWidthGui.Add("Text", "r1", character)
  
  txtCtrl.GetPos(,, &charWidth)
  GetCharacterWidthGui.Destroy()
  return charWidth
}

