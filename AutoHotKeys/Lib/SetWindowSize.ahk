#Requires AutoHotkey v2.0.11+


;#include "C:\Users\Public\AutoHotkey\Lib\WinGetPosEx.ahk"
;#include "C:\Users\Public\AutoHotkey\Lib\WinMoveEx.ahk"
;#include "C:\Users\Public\AutoHotkey\Lib\WinGetActiveWindow.ahk"
;#include "C:\Users\Public\AutoHotkey\Lib\ColorButton.ahk"

; Replace 'M' with whatever key you want to use,
; prepending '+' for shift, '^' for control, '!' for
; alt, and '#' for win. Thus '+#PgDn' will activate
; with shift-win-PgDn. The modifiers may be in
; any order. Use the following for the key names:
; https://www.autohotkey.com/docs/v2/KeyList.htm
SetWindowSizeGUI()
{
  global SetWindowSizeWidth := 0
  global SetWindowSizeHeight := 0
  global SetWindowSizeX := 0
  global SetWindowSizeY := 0
  global SetWindowSizehwnd := WinGetActiveWindow()

  WinGetPosEx(&SetWindowSizeX, &SetWindowSizeY, &SetWindowSizeWidth, &SetWindowSizeHeight, SetWindowSizehwnd)
  global mySetWindowSizeGui := Gui()

  mySetWindowSizeGui.Add("Text", "x25 y9 w75 h20", "Window X")
  global leftSetWindowSizeCtrl := mySetWindowSizeGui.Add("Edit", "x100 y9 w45 h20 R1", SetWindowSizeX)
  mySetWindowSizeGui.Add("Text", "x25 y34 w75 h20", "Window Y")
  global topSetWindowSizeCtrl := mySetWindowSizeGui.Add("Edit", "x100 y34 w45 h20 R1", SetWindowSizeY)

  mySetWindowSizeGui.Add("Text", "x25 y74 w75 h20", "Window Width")
  global widthSetWindowSizeCtrl := mySetWindowSizeGui.Add("Edit", "x100 y74 w45 h20 R1", SetWindowSizeWidth)
  mySetWindowSizeGui.Add("Text", "x25 y99 w75 h20", "Window Height")
  global heightSetWindowSizeCtrl := mySetWindowSizeGui.Add("Edit", "x100 y99 w45 h20 R1", SetWindowSizeHeight)

  global moveSetWindowSizeWindowCtrl := mySetWindowSizeGui.Add("Button", "x25 y135 w95 h30 center +default", "Move/Resize Window")
  moveSetWindowSizeWindowCtrl.OnEvent('Click', moveSetWindowSizeWindowInternal)

  global cancelSetWindowSizeCtrl := mySetWindowSizeGui.Add("Button", "x130 y135 w45 h30 center", "Cancel")
  cancelSetWindowSizeCtrl.OnEvent('Click', cancelSetWindowSizeWindow)
  mySetWindowSizeGui.OnEvent('Escape', (*) => cancelSetWindowSizeWindow())
  mySetWindowSizeGui.Title := "Move"
  mySetWindowSizeGui.Show("w320 ")
}
cancelSetWindowSizeWindow(*)
{
  mySetWindowSizeGui.Hide()
}

global SetWindowSizeMovementAmount := 100

; Move the front window by this(these) amount(s) in the
; appropriate direction.
moveSetWindowSizeWindow(vertical := 0, horizontal := 0)
{
  global SetWindowSizehwnd := WinGetActiveWindow()
  WinGetPosEx(&SetWindowSizeX, &SetWindowSizeY, &SetWindowSizeWidth, &SetWindowSizeHeight, SetWindowSizehwnd)
  ; If this moves the window off screen you can use Alt-Space-M
  ; to move it back once you're done with whatever you needed
  ; to do.
  WinMoveEx(SetWindowSizeX+horizontal, SetWindowSizeY+vertical, SetWindowSizeWidth, SetWindowSizeHeight, SetWindowSizehwnd)
}

moveSetWindowSizeWindowInternal(*)
{
  SetWindowSizeWidth := widthSetWindowSizeCtrl.Value
  SetWindowSizeHeight := heightSetWindowSizeCtrl.Value
  SetWindowSizeX := leftSetWindowSizeCtrl.Value
  SetWindowSizeY := topSetWindowSizeCtrl.Value
  WinMoveEx(SetWindowSizeX, SetWindowSizeY, SetWindowSizeWidth, SetWindowSizeHeight, SetWindowSizehwnd)
  mySetWindowSizeGui.Hide()
}

SetWindowSize1200x900()
{
  global SetWindowSizehwnd := WinGetActiveWindow()
  global SetWindowSizeWidth := 1200
  global SetWindowSizeHeight := 900
  global SetWindowSizeX := 60
  global SetWindowSizeY := 60
  WinMoveEx(SetWindowSizeX, SetWindowSizeY, SetWindowSizeWidth, SetWindowSizeHeight, SetWindowSizehwnd)
}

SetWindowSize1800x1200()
{
  global SetWindowSizehwnd := WinGetActiveWindow()
  global SetWindowSizeWidth := 1800
  global SetWindowSizeHeight := 1200
  global SetWindowSizeX := 60
  global SetWindowSizeY := 60
  WinMoveEx(SetWindowSizeX, SetWindowSizeY, SetWindowSizeWidth, SetWindowSizeHeight, SetWindowSizehwnd)
}

SetWindowSize2400x1800()
{
  global SetWindowSizehwnd := WinGetActiveWindow()
  global SetWindowSizeWidth := 2400
  global SetWindowSizeHeight := 1800
  global SetWindowSizeX := 60
  global SetWindowSizeY := 60
  WinMoveEx(SetWindowSizeX, SetWindowSizeY, SetWindowSizeWidth, SetWindowSizeHeight, SetWindowSizehwnd)
}

