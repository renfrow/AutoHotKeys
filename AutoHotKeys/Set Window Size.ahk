#Requires AutoHotkey v2.0.11+


#include "C:\Users\Public\Documents\AutoHotkey\Lib\WinGetPosEx.ahk"
#include "C:\Users\Public\Documents\AutoHotkey\Lib\WinMoveEx.ahk"
#include "C:\Users\Public\Documents\AutoHotkey\Lib\WinGetActiveWindow.ahk"
;#include "C:\Users\Public\Documents\AutoHotkey\Lib\ColorButton.ahk"

; Replace 'M' with whatever key you want to use,
; prepending '+' for shift, '^' for control, '!' for
; alt, and '#' for win. Thus '+#PgDn' will activate
; with shift-win-PgDn. The modifiers may be in
; any order. Use the following for the key names:
; https://www.autohotkey.com/docs/v2/KeyList.htm
^!+M::
{
  global Width := 0
  global Height := 0
  global X := 0
  global Y := 0
  global hwnd := WinGetActiveWindow()

  WinGetPosEx(&X, &Y, &Width, &Height, hwnd)
  global myGui := Gui()

  myGui.Add("Text", "x25 y9 w75 h20", "Window X")
  global leftCtrl := myGui.Add("Edit", "x100 y9 w45 h20 R1", X)
  myGui.Add("Text", "x25 y34 w75 h20", "Window Y")
  global topCtrl := myGui.Add("Edit", "x100 y34 w45 h20 R1", Y)

  myGui.Add("Text", "x25 y74 w75 h20", "Window Width")
  global widthCtrl := myGui.Add("Edit", "x100 y74 w45 h20 R1", Width)
  myGui.Add("Text", "x25 y99 w75 h20", "Window Height")
  global heightCtrl := myGui.Add("Edit", "x100 y99 w45 h20 R1", Height)

  global moveWindowCtrl := myGui.Add("Button", "x25 y135 w95 h30 center +default", "Move/Resize Window")
  moveWindowCtrl.OnEvent('Click', moveWindow)

  global cancelCtrl := myGui.Add("Button", "x130 y135 w45 h30 center", "Cancel")
  cancelCtrl.OnEvent('Click', cancelWindow)
  myGui.OnEvent('Escape', (*) => cancelWindow())
  myGui.Title := "Move"
  myGui.Show("w320 ")
}
cancelWindow(*)
{
  myGui.Hide()
}

moveWindow(*)
{
  Width := widthCtrl.Value
  Height := heightCtrl.Value
  X := leftCtrl.Value
  Y := topCtrl.Value
  WinMoveEx(X, Y, Width, Height, hwnd)
  myGui.Hide()
}

!#N::
{
  global hwnd := WinGetActiveWindow()
  global Width := 2400
  global Height := 1800
  global X := 60
  global Y := 60
  WinMoveEx(X, Y, Width, Height, hwnd)
}
Return

