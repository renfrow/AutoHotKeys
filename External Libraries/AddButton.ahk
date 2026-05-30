#Requires AutoHotkey v2.0
; Add buttons function
AddButton(aGui, x, y, w, text, callback)
{
  btn := aGui.AddButton(x " " y " " w, text)
  btn.OnEvent("Click", callback)
  btn.SetFont("s10")
  return btn
}

