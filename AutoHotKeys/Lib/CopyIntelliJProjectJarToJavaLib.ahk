#Requires AutoHotkey v2.0.11+

#HotIf WinActive('ahk_exe idea64.exe')

; C:\Users\Public\Documents\ is a folder available
; to and writable by all users on a windows computer.
; You will need to create AutoHotkey\Lib\ and put
; any libraries you use into it. Use an include
; for every library you use.
#include "C:\Users\Public\Documents\AutoHotkey\Lib\_JXON.ahk"
#include "C:\Users\Public\Documents\AutoHotkey\Lib\ResizableMsgBox.ahk"

; Replace '^#!C' with whatever key you want to use,
; prepending '+' for shift, '^' for control, '!' for
; alt, and '#' for win. Thus '+#PgDn' will activate
; with shift-win-PgDn. The modifiers may be in
; any order. Use the following for the key names:
; https://www.autohotkey.com/docs/v2/KeyList.htm

; This hotkey reads the libFile and displays a
; list of libraries. Double clicking on a library
; will copy it to targetDirectory
^#!C::CopyLib()
global listViewObj
global closeWindowCtrl
global editLibsCtrl 

; Put full pathnames of libraries you want to periodically
; copy to C:\Java\Lib
targetDirectory := "C:\Java\Lib"

libsFile := "C:\Users\Public\JavaApps\Tools\AutoHotkey\Lib\libs.json"

CopyLib()
{
  ; Changes made to libsFile will show up the
  ; next time you open this hotkey.
  jsonText := FileRead(libsFile)
  libObjs := []
  libObjs := jxon_load(&jsonText)
	global myGui := setupGui(libObjs)
  myGui.Show()
}

libraryArray := []

setupGui(libObjsArray)
{
  global listViewObj
  global closeWindowCtrl
  global editLibsCtrl 
  aGui := Gui("+Resize")
  ; color is a darkish purple
	aGui.SetFont("s12 c660066", "Segoe UI")
  ; color is a light grey
	aGui.BackColor := 0xCCCCCC
	aGui.MarginX := 5, aGui.MarginY := 5
  aGui.Add("Text", "h20", "Double click on a jar to copy it to C:\Java\Lib")
  ; Escape key closes the window
  aGui.OnEvent('Escape', closeWindow)
  ; Don't allow the list to be sorted. Because there doesn't
  ; seem to be a way to get row data I can't put in a hidden
  ; id to be able to copy the proper library.
  ; Background color is a light grey.
  listViewObj := aGui.Add("ListView", "r10 w700 Grid NoSort BackgroundCCCCCC", ["Library Name", "Full Path"])
  ; Copy the library to targetDirectory when it is double clicked
  listViewObj.OnEvent("DoubleClick", LV_DoubleClick)
  For each, libObj in libObjsArray
  {
    ; Only add rows that have libs in them, as the file may
    ; contain comments.
    if libObj.Has("lib")
    {
      ; Insert into the libraryArray for later use when
      ; we double click on a library. Have to do this
      ; as the listview object doesn't have a method
      ; to return the columns of that row.
      libraryArray.Push(libObj)
      listViewObj.Add(, libObj["lib"], libObj["path"])
    }
  }
  listViewObj.ModifyCol(1,140)

  ; +default is so Return selects this button.
  closeWindowCtrl := aGui.Add("Button", "Section xP h30 center BackgroundD8D8D8 +default", "Done")
  closeWindowCtrl.OnEvent('Click', closeWindow)

  editLibsCtrl := aGui.Add("Button", "h30 x+10 center BackgroundD8D8D8 ", "Edit libs.json")
  editLibsCtrl.OnEvent('Click', editLibs)
  aGui.OnEvent('Size', resizeGui)
  return aGui
}

LV_DoubleClick(LV, RowNumber)
{
  jsonObj := []
  jsonObj := libraryArray[RowNumber]
  ExitCode := RunWait("cmd.exe /c copy /Y " jsonObj["path"] ' `"' . targetDirectory . '`"')

  if ExitCode = 0
  {
    ResizableMsgBox jsonObj["path"] " has been copied to " targetDirectory 
  }
  else
  {
    ;ResizableMsgBox "Unable to copy" "`n`t" jsonObj["path"] "`nto`n`t" targetDirectory "`nMake sure both exist and are readable/writable."
    ResizableMsgBox "Unable to copy`n" "    " jsonObj["path"] "`nto`n    " targetDirectory "`nMake sure both exist and are readable/writable.", , "800"
    ;MsgBox "Unable to copy" "`n`t" jsonObj["path"] "`nto`n`t" targetDirectory "`nMake sure both exist and are readable/writable."
  }
}

closeWindow(*)
{
  myGui.Hide()
}

resizeGui(aGui, minMax, w, h)
{
  global listViewObj
  global closeWindowCtrl
  global editLibsCtrl 
  listViewObj.Move , , w-(2*aGui.MarginX), h-80
  closeWindowCtrl.Move , h-35
  editLibsCtrl.Move , h-35
}

; Replace this with whatever editor you prefer to use.
editor := "C:\Program Files\Vim\vim91\gvim.exe"
editLibs(*)
{
  ; This is just to ensure files with spaces in name/path are edited.
  fileVal := ' `"' . libsFile . '`"'
  Run editor fileVal
}

Return
#HotIf

