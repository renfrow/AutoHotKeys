#Requires AutoHotkey v2.0

; Written by Thomas R. Kimpton, ahk@gooberdude.com

; This was written with the help of AI. It centers
; a MsgBox type dialog on the active window, rather
; than the center of the screen.

CenteredMsgBox(Text, Title := "Message", Options := "OK")
{
  frontWindowHwnd := WinActive("A")
  ; Create a GUI with dialog characteristics
  guiBox := Gui("+Owner +AlwaysOnTop -MaximizeBox -MinimizeBox", Title)
	guiBox.SetFont("s12 c660066", "Segoe UI")
  guiBox.OnEvent('Escape', (*) => guiBox.Destroy())
  guiBox.MarginX := 20
  guiBox.MarginY := 20
  
  ; Add text and buttons based on Options (expand as needed)
  guiBox.Add("Text", "w500", Text)
  
  switch Options
  {
    case "OK":
      btn1 := guiBox.Add("Button", "Default w80", "OK")
      btn1.OnEvent("Click", (*) => guiBox.Destroy())
    case "OKCancel":
      btn1 := guiBox.Add("Button", "Default w80", "OK")
      btn2 := guiBox.Add("Button", "x+10 w80", "Cancel")
      btn1.OnEvent("Click", (*) => guiBox.Destroy())
      btn2.OnEvent("Click", (*) => guiBox.Destroy())
    case "YesNo":
      btn1 := guiBox.Add("Button", "Default w80", "Yes")
      btn2 := guiBox.Add("Button", "x+10 w80", "No")
      btn1.OnEvent("Click", (*) => guiBox.Destroy())
      btn2.OnEvent("Click", (*) => guiBox.Destroy())
  }
  
  guiBox.Show()
  CenterMyGUIOnActiveWindow(guiBox, frontWindowHwnd)

  WinWaitClose(guiBox)
}

