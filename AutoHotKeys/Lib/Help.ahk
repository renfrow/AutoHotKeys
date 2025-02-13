#Requires AutoHotkey 2.0+
#SingleInstance Force

#include "C:\Users\Public\Documents\AutoHotkey\Lib\_JXON.ahk"
#include "C:\Users\Public\Documents\AutoHotkey\Lib\CenterMyGUIOnActiveWindow.ahk"


; NOTE: if you edit this file you'll need to rerun it to
; get your changes made to the autokey window.
; Win-Alt-H
#!H::Help()

global listViewObj
global closeWindowCtrl

helpFile := "C:\Users\Public\Documents\AutoHotkey\Lib\Help.json"
Help()
{
  global listViewObj

  helpWndH := WinActive("A")
  ; Changes made to this file will show up the
  ; next time you open this hotkey.
  jsonText := FileRead(helpFile)
  helpObjs := jxon_load(&jsonText)
	global myGui := setupGui(helpObjs)
  myGui.Show()

  CenterMyGUIOnActiveWindow(myGui, helpWndH)
}

setupGui(helpObjsArray)
{
  aGui := Gui("+Resize")
  listViewObj := 0
  closeWindowCtrl := 0
	aGui.SetFont("s12 c660066", "Segoe UI")
	aGui.BackColor := 0xCCCCCC
	aGui.MarginX := 5, aGui.MarginY := 5
  aGui.Add("Text", "h20", "'+' = Shift, '^' = Control, '!' = Alt, '#' = Win")
  aGui.OnEvent('Escape', closeWindow)
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
  closeWindowCtrl.OnEvent('Click', closeWindow)
  aGui.OnEvent('Size', resizeGui)

  return aGui
}
closeWindow(*)
{
  myGui.Hide()
}

resizeGui(aGui, minMax, w, h)
{
  listViewObj.Move , , w-(2*aGui.MarginX), h-80
  closeWindowCtrl.Move , h-35
}

; Replace this with whatever editor you prefer to use.
editor := "C:\Program Files\Vim\vim91\gvim.exe"
; Replace this with wherever you put your help file.
helpFile := "C:\Users\Public\Documents\AutoHotkey\Lib\Help.json"

; Control-Win-Alt-H
^#!H::EditHelp()
EditHelp()
{
  ; This is just to ensure files with spaces in name/path are edited.
  fileVal := ' `"' . helpFile . '`"'
  Run editor fileVal
}

