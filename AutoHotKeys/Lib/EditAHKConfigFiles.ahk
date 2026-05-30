#Requires AutoHotkey 2.0+

; Written by Thomas R. Kimpton, ahk@gooberdude.com

;#include "C:\Users\Public\AutoHotkey\Lib\_JXON.ahk"
;#include "C:\Users\Public\AutoHotkey\Lib\ExplorerSelection.ahk"
;#include "C:\Users\Public\AutoHotkey\Lib\AHKEnv.ahk"
;#include "C:\Users\Public\AutoHotkey\Lib\BringProcessPIDToFront.ahk"
;#include "C:\Users\Public\AutoHotkey\Lib\WinGetActiveWindow.ahk"
;#include "C:\Users\Public\AutoHotkey\Lib\OpenInEditor.ahk"
;#include "C:\Users\Public\AutoHotkey\Lib\WinGetPosEx.ahk"
;#include "C:\Users\Public\AutoHotkey\Lib\WinMoveEx.ahk"
;#include "C:\Users\Public\AutoHotkey\Lib\jsongo.v2.ahk"

editor := getAHKEnvValue("editor", "notepad.exe")

; NOTE: if you edit this file you'll need to rerun it to
; get your changes made to the autokey window.
EditAHKConfigFilesFile := "C:\Users\Public\AutoHotkey\Lib\ConfigFilesList.json"

; Changes made to this file will show up the
; next time you open this hotkey.
jsonText := FileRead(EditAHKConfigFilesFile)
configEditAHKConfigFileObjs := jsongo.Parse(jsonText)
defaultEditAHKConfigFile := -1
configEditAHKConfigFileObjsArray := Array()
For each, configEditAHKConfigFileObj in configEditAHKConfigFileObjs
{
  if configEditAHKConfigFileObj.Has("configFilePath")
  {
    configEditAHKConfigFileObjsArray.Push(configEditAHKConfigFileObj)
    if configEditAHKConfigFileObj.Has("default")
    {
      defaultEditAHKConfigFile := configEditAHKConfigFileObj
    }
  }
}



global closeEditAHKConfigFileWindowCtrl
; Popup a window with a menu of Putty sessions.
; Run the selected session.
EditAHKConfigFiles()
{

  global myEditAHKConfigFileGui := Gui("+Resize")
  closeEditAHKConfigFileWindowCtrl := 0
	myEditAHKConfigFileGui.SetFont("s12 c660066", "Segoe UI")
	myEditAHKConfigFileGui.BackColor := 0xCCCCCC
	myEditAHKConfigFileGui.MarginX := 5, myEditAHKConfigFileGui.MarginY := 5

  myEditAHKConfigFileGui.OnEvent('Escape', closeEditAHKConfigFileWindow)
  For each, configEditAHKConfigFileObj in configEditAHKConfigFileObjsArray
  {
    local aEditAHKConfigFileWindowCtrl := myEditAHKConfigFileGui.Add("Button", "h30 center BackgroundD8D8D8 ", configEditAHKConfigFileObj["configFileName"])
    aEditAHKConfigFileWindowCtrl.configFilePath := configEditAHKConfigFileObj["configFilePath"]
    aEditAHKConfigFileWindowCtrl.OnEvent('Click', configButtonHandler)
  }

  ; +default is so Return selects this button.
  global closeEditAHKConfigFileWindowCtrl := myEditAHKConfigFileGui.Add("Button", "h30 BackgroundD8D8D8 +default", "OK")
  closeEditAHKConfigFileWindowCtrl.OnEvent('Click', closeEditAHKConfigFileWindow)

  myEditAHKConfigFileGui.Show()
}
closeEditAHKConfigFileWindow(*)
{
  myEditAHKConfigFileGui.Hide()
}
configButtonHandler(buttonObj, info)
{
  closeEditAHKConfigFileWindow()
  EditAFile(buttonObj.configFilePath)
}

; Edit the AHKEnv file. When the editor closes/finishes
; reload the AHKEnv variables.
EditAHKEnvFile()
{
  envFile := getAHKEnvValue("envFile")
  EditAFile(envFile)
  ProcessWaitClose(editor)
  MsgBox "Editor Closed"
  reloadAHKEnv()
}

