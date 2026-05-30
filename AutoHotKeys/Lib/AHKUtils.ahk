#Requires AutoHotkey v2.0

; Written by Thomas R. Kimpton, ahk@gooberdude.com
PopupWindowSpy()
{
  ; If WindowSpy is running it SHOULD be in front of
  ; everything else, but, just in case...
  if WinExist("ahk_class WindowSpy")
  {
    WinActivate
  }
  else
  {
    Run("C:\Program Files\AutoHotkey\WindowSpy.ahk")
  }
}
