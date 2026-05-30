#Requires AutoHotkey v2.0.11+


; Written by Thomas R. Kimpton, ahk@gooberdude.com

;#include "C:\Users\Public\AutoHotkey\Lib\WinGetPosEx.ahk"
;#include "C:\Users\Public\AutoHotkey\Lib\WinMoveEx.ahk"
;#include "C:\Users\Public\AutoHotkey\Lib\WinGetActiveWindow.ahk"

global ResizeCurrentWindowWidth := 0
global ResizeCurrentWindowHeight := 0
global ResizeCurrentWindowX := 0
global ResizeCurrentWindowY := 0
global ResizeCurrentWindowhwnd

global ResizeCurrentWindowOnSideLeft := 0
global ResizeCurrentWindowOnSideRight := 1
global ResizeCurrentWindowOnSideTop := 2
global ResizeCurrentWindowOnSideBottom := 3

; Change the size of the window by ResizeCurrentWindowAmount
; on the side specified.
ResizeCurrentWindowOnSide(which := ResizeCurrentWindowOnSideLeft, ResizeCurrentWindowAmount := 100)
{
  global ResizeCurrentWindowhwnd := WinGetActiveWindow()
  WinGetPosEx(&ResizeCurrentWindowX, &ResizeCurrentWindowY, &ResizeCurrentWindowWidth, &ResizeCurrentWindowHeight, ResizeCurrentWindowhwnd)
  ; If this moves the window off screen you can use Alt-Space-M
  ; to move it back once you're done with whatever you needed
  ; to do.
  switch which
  {
    case ResizeCurrentWindowOnSideLeft:
      ResizeCurrentWindowWidth += ResizeCurrentWindowAmount
      ResizeCurrentWindowX -= ResizeCurrentWindowAmount
    case ResizeCurrentWindowOnSideRight:
      ResizeCurrentWindowWidth += ResizeCurrentWindowAmount
    case ResizeCurrentWindowOnSideTop:
      ResizeCurrentWindowHeight += ResizeCurrentWindowAmount
      ResizeCurrentWindowY -= ResizeCurrentWindowAmount
    case ResizeCurrentWindowOnSideBottom:
      ResizeCurrentWindowHeight += ResizeCurrentWindowAmount
  }
  WinMoveEx(ResizeCurrentWindowX, ResizeCurrentWindowY, ResizeCurrentWindowWidth, ResizeCurrentWindowHeight, ResizeCurrentWindowhwnd)
}

