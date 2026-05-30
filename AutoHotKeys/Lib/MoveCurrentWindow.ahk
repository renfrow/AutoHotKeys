#Requires AutoHotkey v2.0.11+

; Written by Thomas R. Kimpton, ahk@gooberdude.com


;#include "C:\Users\Public\AutoHotkey\Lib\WinGetPosEx.ahk"
;#include "C:\Users\Public\AutoHotkey\Lib\WinMoveEx.ahk"
;#include "C:\Users\Public\AutoHotkey\Lib\WinGetActiveWindow.ahk"

global MoveCurrentWindowWidth := 0
global MoveCurrentWindowHeight := 0
global MoveCurrentWindowX := 0
global MoveCurrentWindowY := 0
global MoveCurrentWindowhwnd

; Move the front window by this(these) amount(s) in the
; appropriate direction, positive to the right/down,
; negative to the left/up.
MoveCurrentWindow(vertical := 0, horizontal := 0)
{
  global MoveCurrentWindowhwnd := WinGetActiveWindow()
  WinGetPosEx(&MoveCurrentWindowX, &MoveCurrentWindowY, &MoveCurrentWindowWidth, &MoveCurrentWindowHeight, MoveCurrentWindowhwnd)
  ; If this moves the window off screen you can use SetWindowSize()
  ; to move it back once you're done with whatever you needed
  ; to do.
  WinMoveEx(MoveCurrentWindowX+horizontal, MoveCurrentWindowY+vertical, MoveCurrentWindowWidth, MoveCurrentWindowHeight, MoveCurrentWindowhwnd)
}

global MoveCurrentWindowUpperLeftCorner := 1
global MoveCurrentWindowUpperRightCorner := 2
global MoveCurrentWindowLowerLeftCorner := 3
global MoveCurrentWindowLowerRightCorner := 4

MoveCurrentWindowToCorner(which := MoveCurrentWindowUpperLeftCorner)
{
  global MoveCurrentWindowToCornerHwnd := WinGetActiveWindow()
  WinGetPosEx(&MoveCurrentWindowX, &MoveCurrentWindowY, &MoveCurrentWindowWidth, &MoveCurrentWindowHeight, MoveCurrentWindowToCornerHwnd)
  WinGetDimsActiveWindowDisplay(&width, &height)
  switch which
  {
    case MoveCurrentWindowUpperLeftCorner:
      WinMoveEx(0, 0, MoveCurrentWindowWidth, MoveCurrentWindowHeight, MoveCurrentWindowToCornerHwnd)
    case MoveCurrentWindowUpperRightCorner:
      WinMoveEx(width-MoveCurrentWindowWidth, 0, MoveCurrentWindowWidth, MoveCurrentWindowHeight, MoveCurrentWindowToCornerHwnd)
    case MoveCurrentWindowLowerLeftCorner:
      WinMoveEx(0, height-MoveCurrentWindowHeight, MoveCurrentWindowWidth, MoveCurrentWindowHeight, MoveCurrentWindowToCornerHwnd)
    case MoveCurrentWindowLowerRightCorner:
      WinMoveEx(width-MoveCurrentWindowWidth, height-MoveCurrentWindowHeight, MoveCurrentWindowWidth, MoveCurrentWindowHeight, MoveCurrentWindowToCornerHwnd)
  }
}


