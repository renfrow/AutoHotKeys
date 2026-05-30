#Requires AutoHotkey v2.0

; Written by Thomas R. Kimpton, ahk@gooberdude.com

; From https://www.autohotkey.com/boards/viewtopic.php?p=509080


; Active only within Oblivion Remastered
#HotIf WinActive('ahk_exe OblivionRemastered-Win64-Shipping.exe')
MouseMoveGame(X, Y)
{
  MouseMove X, Y
}
MouseClickGame()
{
  MouseClick
}
#HotIf

