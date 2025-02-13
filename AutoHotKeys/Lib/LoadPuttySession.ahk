#Requires AutoHotkey 2.0+

;#include "C:\Users\Public\AutoHotkey\Lib\_JXON.ahk"
;#include "C:\Users\Public\AutoHotkey\Lib\BringProcessPIDToFront.ahk"

; NOTE: if you edit this file you'll need to rerun it to
; get your changes made to the autokey window.
LoadPuttySessionFile := "C:\Users\Public\AutoHotkey\Lib\Putty.json"

; Changes made to this file will show up the
; next time you open this hotkey.
jsonText := FileRead(LoadPuttySessionFile)
defaultLoadPuttySessionSession := -1
puttyLoadPuttySessionObjs := jxon_load(&jsonText)
puttyLoadPuttySessionObjsArray := Array()
For each, puttyLoadPuttySessionObj in puttyLoadPuttySessionObjs
{
  if puttyLoadPuttySessionObj.Has("sessionName")
  {
    puttyLoadPuttySessionObjsArray.Push(puttyLoadPuttySessionObj)
    if puttyLoadPuttySessionObj.Has("default")
    {
      defaultLoadPuttySessionSession := puttyLoadPuttySessionObj
    }
  }
}



global closeLoadPuttySessionWindowCtrl
; Popup a window with a menu of Putty sessions.
; Run the selected session.
LoadPuttySession()
{

  global myLoadPuttySessionGui := Gui("+Resize")
  closeLoadPuttySessionWindowCtrl := 0
	myLoadPuttySessionGui.SetFont("s12 c660066", "Segoe UI")
	myLoadPuttySessionGui.BackColor := 0xCCCCCC
	myLoadPuttySessionGui.MarginX := 5, myLoadPuttySessionGui.MarginY := 5
  myLoadPuttySessionMenu := Menu()

  myLoadPuttySessionMenuBar := MenuBar()
  myLoadPuttySessionMenuBar.Add("&Sessions", myLoadPuttySessionMenu)
  myLoadPuttySessionGui.MenuBar := myLoadPuttySessionMenuBar
  myLoadPuttySessionGui.OnEvent('Escape', closeLoadPuttySessionWindow)
  For each, puttyLoadPuttySessionObj in puttyLoadPuttySessionObjsArray
  {
    myLoadPuttySessionMenu.Add(puttyLoadPuttySessionObj["sessionName"], menuHandler)
  }

  ; +default is so Return selects this button.
  global closeLoadPuttySessionWindowCtrl := myLoadPuttySessionGui.Add("Button", "h30 center BackgroundD8D8D8 +default", "OK")
  closeLoadPuttySessionWindowCtrl.OnEvent('Click', closeLoadPuttySessionWindow)

  myLoadPuttySessionGui.Show()
}
closeLoadPuttySessionWindow(*)
{
  myLoadPuttySessionGui.Hide()
}
menuHandler(menuItemName, itemNum, thisMenu)
{
  RunProcessInFront("putty.exe -load " puttyLoadPuttySessionObjsArray[itemNum]["sessionName"])
  closeLoadPuttySessionWindow()
}



RunLoadDefaultPuttySession()
{
  RunProcessInFront("putty.exe -load " defaultLoadPuttySessionSession["sessionName"])
}

; Edit the file with putty sessions that is used
; to build the menu.
EditLoadPuttySession()
{
  ; This is just to ensure files with spaces in name/path are edited.
  fileVal := ' `"' . LoadPuttySessionFile . '`"'
  Run editor fileVal
}

