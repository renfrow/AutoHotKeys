#Requires AutoHotkey 2.0+

; Written by Thomas R. Kimpton, ahk@gooberdude.com

;#include "C:\Users\Public\AutoHotkey\Lib\jsongo.v2.ahk"
;#include "C:\Users\Public\AutoHotkey\Lib\BringProcessPIDToFront.ahk"
;#include "C:\Users\Public\AutoHotkey\Lib\Object2Str.ahk"

; NOTE: if you edit this file you'll need to rerun it to
; get your changes made to the autokey window.
LoadOpenDirectoryFile := "C:\Users\Public\AutoHotkey\Lib\OpenDirectoryList.json"
defaultLoadOpenDirectory := -1

setupOpenDirectoryFile()
{
  ; Changes made to this file will show up the
  ; next time you open this hotkey.
  jsonText := FileRead(LoadOpenDirectoryFile)
  loadOpenDirectoryObjs := jsongo.Parse(jsonText)
  loadOpenDirectoryObjsArray := Array()
  For each, loadOpenDirectoryObj in loadOpenDirectoryObjs
  {
    if loadOpenDirectoryObj.Has("directoryName")
    {
      loadOpenDirectoryObjsArray.Push(loadOpenDirectoryObj)
      if loadOpenDirectoryObj.Has("default")
      {
        defaultLoadOpenDirectory := loadOpenDirectoryObj
      }
    }
  }
  return loadOpenDirectoryObjsArray
}



global closeLoadOpenDirectoryWindowCtrl
; Popup a window with a menu of Directories.
; Open the selected directory.
LoadOpenDirectory()
{
  loadOpenDirectoryObjsArray := setupOpenDirectoryFile()
  ; Gui(options, title)
  global myLoadOpenDirectoryGui := Gui("+Resize +MinSize400x200", "Open Directory in an Explorer Window:")
  closeLoadOpenDirectoryWindowCtrl := 0
	myLoadOpenDirectoryGui.SetFont("s12 c660066", "Segoe UI")
	myLoadOpenDirectoryGui.BackColor := 0xCCCCCC
	myLoadOpenDirectoryGui.MarginX := 5, myLoadOpenDirectoryGui.MarginY := 5

  myLoadOpenDirectoryGui.OnEvent('Escape', closeLoadOpenDirectoryWindow)
  For each, loadOpenDirectoryObj in loadOpenDirectoryObjsArray
  {
    ; Some directories that I want to open are the top level of the
    ; remote volume. e.g. V: is misc.pics. I add a comment to indicate
    ; WHAT we are opening.
    comment := ""
    if loadOpenDirectoryObj.Has("_comment")
    {
      comment := loadOpenDirectoryObj["_comment"]
    }
    local aLoadOpenDirectoryWindowCtrl := myLoadOpenDirectoryGui.Add("Button", "h30 center BackgroundD8D8D8 ", loadOpenDirectoryObj["directoryName"] . comment)
    aLoadOpenDirectoryWindowCtrl.OnEvent('Click', loadDirectoryButtonHandler)
    aLoadOpenDirectoryWindowCtrl.directory := loadOpenDirectoryObj["directoryName"]
  }

  ; +default is so Return selects this button.
  global closeLoadOpenDirectoryWindowCtrl := myLoadOpenDirectoryGui.Add("Button", "h30 BackgroundD8D8D8 +default", "OK")
  closeLoadOpenDirectoryWindowCtrl.OnEvent('Click', closeLoadOpenDirectoryWindow)

  myLoadOpenDirectoryGui.Show()
}
closeLoadOpenDirectoryWindow(*)
{
  myLoadOpenDirectoryGui.Hide()
}
loadDirectoryButtonHandler(buttonObj, info)
{
  RunProcessInFront("explorer.exe /separate, " buttonObj.directory)
  closeLoadOpenDirectoryWindow()
}

RunLoadDefaultOpenDirectory()
{
  RunProcessInFront("explorer.exe /separate, " defaultLoadOpenDirectory["directoryName"])
}

; Edit the file with directories that is used
; to build the menu.
EditLoadOpenDirectory()
{
  EditAFile(LoadOpenDirectoryFile)
}

