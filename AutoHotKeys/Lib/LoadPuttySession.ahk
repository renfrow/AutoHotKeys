#Requires AutoHotkey 2.0+

; Written by Thomas R. Kimpton, ahk@gooberdude.com

;#include "C:\Users\Public\AutoHotkey\Lib\BringProcessPIDToFront.ahk"

; NOTE: if you edit this file you'll need to rerun it to
; get your changes made to the autokey window.
LoadPuttySessionFile := "C:\Users\Public\AutoHotkey\Lib\Putty.json"

; Changes made to this file will show up the
; next time you open this hotkey.
jsonText := FileRead(LoadPuttySessionFile)
defaultLoadPuttySessionSession := -1
puttyLoadPuttySessionObjs := jsongo.Parse(jsonText)
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

  global myLoadPuttySessionGui := Gui("+Resize +Minsize300x201")
  closeLoadPuttySessionWindowCtrl := 0
	myLoadPuttySessionGui.SetFont("s12 c660066", "Segoe UI")
	myLoadPuttySessionGui.BackColor := 0xCCCCCC
	myLoadPuttySessionGui.MarginX := 5, myLoadPuttySessionGui.MarginY := 5

  myLoadPuttySessionGui.OnEvent('Escape', closeLoadPuttySessionWindow)
  For each, puttyLoadPuttySessionObj in puttyLoadPuttySessionObjsArray
  {
    local aLoadPuttySessionWindowCtrl := myLoadPuttySessionGui.Add("Button", "h30 center BackgroundD8D8D8 ", puttyLoadPuttySessionObj["sessionName"])
    aLoadPuttySessionWindowCtrl.OnEvent('Click', loadPuttyButtonHandler)
  }

  ; +default is so Return selects this button.
  global closeLoadPuttySessionWindowCtrl := myLoadPuttySessionGui.Add("Button", "h30 BackgroundD8D8D8 +default", "OK")
  closeLoadPuttySessionWindowCtrl.OnEvent('Click', closeLoadPuttySessionWindow)

  myLoadPuttySessionGui.Show()
}
closeLoadPuttySessionWindow(*)
{
  myLoadPuttySessionGui.Hide()
}
loadPuttyButtonHandler(buttonObj, info)
{
  RunProcessInFront("putty.exe -load " buttonObj.Text)
  closeLoadPuttySessionWindow()
}

;menuHandler(menuItemName, itemNum, thisMenu)
;{
;  RunProcessInFront("putty.exe -load " puttyLoadPuttySessionObjsArray[itemNum]["sessionName"])
;  closeLoadPuttySessionWindow()
;}



RunPutty()
{
  RunProcessInFront("putty.exe")
}

RunLoadDefaultPuttySession()
{
  RunProcessInFront("putty.exe -load " defaultLoadPuttySessionSession["sessionName"])
}

; Edit the file with putty sessions that is used
; to build the menu.
EditLoadPuttySession()
{
  EditAFile(LoadPuttySessionFile)
}

PuttyPaste()
{
  Send "+{Insert}"
}

PuttyCommand(host := "miniserver", command := "")
{
  PWB := InputBox("Password", "Password:", "password h100")
  if PWB.Result != "Cancel"
  {
    RunProcessInFront("putty.exe -load " host)
    Sleep 500
    Send PWB.Value
    Send "{Enter}"
    Sleep 1000
    
    Send command
    Send "{Enter}"
    Sleep 500
  }
}
