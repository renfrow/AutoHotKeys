#Requires AutoHotkey 2.0+
#SingleInstance Force

;#include "C:\Users\Public\AutoHotkey\Lib\_JXON.ahk"
;#include "C:\Users\Public\AutoHotkey\Lib\CenterMyGUIOnActiveWindow.ahk"

; NOTE: if you edit this file you'll need to rerun it to
; get your changes made to the autokey window.
helpFile := "C:\Users\Public\AutoHotkey\Lib\Help.json"

global listViewObj
global closeWindowCtrl

Help()
{
  global listViewObj

  helpWndH := WinActive("A")
  ; Changes made to this file will show up the
  ; next time you open this hotkey.
  jsonText := FileRead(helpFile)
  helpObjs := jxon_load(&jsonText)
	global myHelpGui := setupHelpGui(helpObjs)
  myHelpGui.Show()

  CenterMyGUIOnActiveWindow(myHelpGui, helpWndH)
}

setupHelpGui(helpObjsArray)
{
  aGui := Gui("+Resize")
  listViewObj := 0
  closeWindowCtrl := 0
	aGui.SetFont("s12 c660066", "Segoe UI")
	aGui.BackColor := 0xCCCCCC
	aGui.MarginX := 5, aGui.MarginY := 5
  aGui.Add("Text", "h20", "'+' = Shift, '^' = Control, '!' = Alt, '#' = Win")
  aGui.OnEvent('Escape', closeHelpWindow)
  global listViewObj := aGui.Add("ListView", "r10 w700 Grid BackgroundCCCCCC", ["Key Combo","App", "Description"])
  For each, helpObj in helpObjsArray
  {
    if helpObj.Has("key")
    {
      listViewObj.Add(, helpObj["key"], helpObj["app"], helpObj["help"])
    }
  }
  listViewObj.ModifyCol(1,100)
  listViewObj.ModifyCol(2,100)

  ; +default is so Return selects this button.
  global closeWindowCtrl := aGui.Add("Button", "h30 center BackgroundD8D8D8 +default", "OK")
  closeWindowCtrl.OnEvent('Click', closeHelpWindow)
  aGui.OnEvent('Size', resizeHelpGui)

  return aGui
}
closeHelpWindow(*)
{
  myHelpGui.Hide()
}

resizeHelpGui(aGui, minMax, w, h)
{
  listViewObj.Move , , w-(2*aGui.MarginX), h-80
  closeWindowCtrl.Move , h-35
}

editor := getAHKEnvValue("editor", "notepad.exe")

EditHelp()
{
  ; This is just to ensure files with spaces in name/path are edited.
  fileVal := ' `"' . helpFile . '`"'
  Run editor fileVal
}

