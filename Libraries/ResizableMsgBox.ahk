#Requires AutoHotkey v2.0

global rmbGui


ResizableMsgBox(text, title := A_ScriptName, width := "1000")
{
global rmbGui
  rmbGui := Gui("+Resize", title)
  ;rmbGui := Gui(, title)
	rmbGui.SetFont("s16 c660066", "Segoe UI")
  rmbGui.OnEvent('Escape', destroyWindow)
  textControl := rmbGui.Add("Text", "w" width, text)
  okControl := rmbGui.Add("Button", 'h30 w80 Default', 'OK')
  okControl.OnEvent('Click', (*) => destroyWindow())

  WinExist("A")
  X := 0
  Y := 0
  width := 0
  height := 0
  WinGetPos &X, &Y, &width, &height
  ; Center the message box on the active window
  rmbGui.Move(width/2 - X/2, height/2-Y/2)
  rmbGui.Show('AutoSize')
}

destroyWindow(*)
{
  global rmbGui
  rmbGui.Destroy()
}

