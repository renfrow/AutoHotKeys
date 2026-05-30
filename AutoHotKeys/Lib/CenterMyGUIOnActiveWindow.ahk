#Requires AutoHotkey v2.0

; Written by Thomas R. Kimpton, ahk@gooberdude.com

; Center the clientGui on the active window(hwnd).
; MUST be called IMMEDIATELY after clientGui.Show()
; is called! Can't be called before, as the gui
; isn't built, yet, and can't be called later as
; there may be a flash of it in the location where
; it was built.
CenterMyGUIOnActiveWindow(clientGui, hwnd)
{
  activeWindowX := 0
  activeWindowY := 0
  activeWindowWidth := 0
  activeWindowHeight := 0
  ; Get the location/dimensions of the window that was
  ; active when this gui was called.
  WinExist(hwnd)
  WinGetPos &activeWindowX, &activeWindowY, &activeWindowWidth, &activeWindowHeight
  middleXOfActiveWindow := activeWindowX + activeWindowWidth/2
  middleYOfActiveWindow := activeWindowY + activeWindowHeight/2
  clientGuiWidth := 0
  clientGuiHeight := 0
  ; Get the width/height of clientGui, which is NOW
  ; the active window.
  WinExist("A")
  WinGetPos , , &clientGuiWidth, &clientGuiHeight
  newClientGuiX := middleXOfActiveWindow - clientGuiWidth/2
  newClientGuiY := middleYOfActiveWindow - clientGuiHeight/2
  ; Make sure it's not off screen
  if newClientGuiX < 0
  {
    newClientGuiX := 0
  }
  if newClientGuiY < 0
  {
    newClientGuiY := 0
  }
  WinMove(newClientGuiX, newClientGuiY)
}

