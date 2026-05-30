#Requires AutoHotkey 2.0+
#SingleInstance Force

; Written by Thomas R. Kimpton, ahk@gooberdude.com

; This pops up a window of brief help for applications.
; Basically it tells you what key combos to use in which
; apps to perform actions. There's a json file that
; contains all of the help. If the description is too
; wide for the window double-clicking on that line will
; popup a small dialog with the help text. You can also
; search the help text with ^F or clicking on the 'Find'
; button.

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
  helpObjs := jsongo.Parse(jsonText)
	global myHelpGui := setupHelpGui(helpObjs)
  myHelpGui.Show()

  CenterMyGUIOnActiveWindow(myHelpGui, helpWndH)
}

setupHelpGui(helpObjsArray)
{
  aGui := Gui("+Resize +Minsize300x200", "Miscellaneous Help")
  listViewObj := 0
  closeWindowCtrl := 0
	aGui.SetFont("s12 c660066", "Segoe UI")
	aGui.BackColor := 0xCCCCCC
	aGui.MarginX := 5, aGui.MarginY := 5
  aGui.OnEvent('Escape', closeHelpWindow)
  ; Make a listview object that sorts on column header click, row length of the number of helps,
  ; show grid lines, give it a background color, with these column headers.
  global listViewObj := aGui.Add("ListView", "r" . helpObjsArray.length . " w700 Grid BackgroundCCCCCC", ["Key Combo","App", "Description"])
  listViewObj.OnEvent("DoubleClick", ExtendedHelpWindow)
  For each, helpObj in helpObjsArray
  {
    if helpObj.Has("key")
    {
      listViewObj.Add(, helpObj["key"], helpObj["app"], helpObj["help"])
    }
  }
  listViewObj.ModifyCol(1,150)
  listViewObj.ModifyCol(2,100)

  ; +default is so Return selects this button.
  global closeWindowCtrl := aGui.Add("Button", "h30 center BackgroundD8D8D8 +default", "OK")
  closeWindowCtrl.OnEvent('Click', closeHelpWindow)

  global findWindowCtrl := aGui.Add("Button", "x+10 h30 center BackgroundD8D8D8", "Find")
  findWindowCtrl.OnEvent('Click', findHelpWindow)

  aGui.OnEvent('Size', resizeHelpGui)

  return aGui
}

ExtendedHelpWindow(LV, RowNumber)
{
  if (RowNumber == 0) ; User double-clicked on empty space, not a row
    return

  ; Get text from the 3rd column (index starts at 1)
  CenteredMsgBox(LV.GetText(RowNumber, 3))
}

; Easiest way to use Ctrl-F to do a Find.
#HotIf WinActive("Miscellaneous Help")
^F::findHelpWindow()
#HotIf

findHelpWindow(*)
{
  SearchTerm := InputBox("Search Help", "Search For:", "h100")

  if SearchTerm.Result != "Cancel"
  {
    SearchTermValue := SearchTerm.Value
    global listViewObj
    listViewObj.Modify(0, "-Select") ; Deselect all
    Loop listViewObj.GetCount()
    {
      ; Get text from row index (A_Index), column 3
      CurrentCellText := listViewObj.GetText(A_Index, 3)
      
      if InStr(CurrentCellText, SearchTermValue)
      {
        listViewObj.Modify(A_Index, "+Select +Vis")
      }
    }
  }
  WinActivate("Miscellaneous Help")
}

closeHelpWindow(*)
{
  myHelpGui.Hide()
}

resizeHelpGui(aGui, minMax, w, h)
{
  listViewObj.Move , , w-(2*aGui.MarginX), h-80
  closeWindowCtrl.Move , h-35
  findWindowCtrl.Move , h-35
}

editor := getAHKEnvValue("editor", "notepad.exe")

EditHelp()
{
  ; This is just to ensure files with spaces in name/path are edited.
  fileVal := ' `"' . helpFile . '`"'
  Run editor fileVal
}

