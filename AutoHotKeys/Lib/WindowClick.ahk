#Requires AutoHotkey v2.0.11+


; Written by Thomas R. Kimpton, ahk@gooberdude.com

;#include "C:\Users\Public\AutoHotkey\Lib\WinGetPosEx.ahk"
;#include "C:\Users\Public\AutoHotkey\Lib\WinMoveEx.ahk"
;#include "C:\Users\Public\AutoHotkey\Lib\WinGetActiveWindow.ahk"
;#include "C:\Users\Public\AutoHotkey\Lib\ColorButton.ahk"

; This routine is useful for clicking in a window on a control, or
; point, using coordinates relative to the window. Further,
; negative coordinates click relative to the right and/or bottom.

WindowClick(winClickX := 0, winClickY := 0, winClickOptions := "")
{
  global GetWindowClickWidth := 0
  global GetWindowClickHeight := 0
  global GetWindowClickX := 0
  global GetWindowClickY := 0
  global GetWindowClickhwnd := WinGetActiveWindow()

  WinGetPosEx(&GetWindowClickX, &GetWindowClickY, &GetWindowClickWidth, &GetWindowClickHeight, GetWindowClickhwnd)

  global WindowClickX := 0
  global WindowClickY := 0

  ; If winClickX less than 0, set coord from the right
  if(winClickX < 0)
  {
    WindowClickX := GetWindowClickX+GetWindowClickWidth+winClickX
  }
  else
  {
    WindowClickX := GetWindowClickX+winClickX
  }

  ; If winClickY less than 0, set coord from the bottom
  if(winClickY < 0)
  {
    WindowClickY := GetWindowClickY+GetWindowClickHeight+winClickY
  }
  else
  {
    WindowClickY := GetWindowClickY+winClickY
  }
  Click WindowClickX, WindowClickY, winClickOptions
}


