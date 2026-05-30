#Requires AutoHotkey v2.0.11+

#HotIf WinActive('ahk_exe idea64.exe')

; Written by Thomas R. Kimpton, ahk@gooberdude.com

; This hotkey reads the libFile and displays a
; list of libraries. Double clicking on a library
; will copy it to targetCopyIntelliJProjectJarToLibDirectory
global listViewCopyIntelliJProjectJarToLibObj
global closeCopyIntelliJProjectJarToLibWindowCtrl
global editCopyIntelliJProjectJarToLibLibsCtrl 

; Put full pathnames of libraries you want to periodically
; copy to C:\Java\Lib
targetCopyIntelliJProjectJarToLibDirectory := "C:\Java\Lib"

libsCopyIntelliJProjectJarToLibFile := "C:\Users\Public\JavaApps\Tools\AutoHotkey\Lib\libs.json"

CopyIntelliJProjectJarToLib()
{
  ; Changes made to libsCopyIntelliJProjectJarToLibFile will show up the
  ; next time you open this hotkey.
  jsonText := FileRead(libsCopyIntelliJProjectJarToLibFile)
  libObjs := []
  libObjs := jsongo.Parse(jsonText)
	global myCopyIntelliJProjectJarToLibGui := setupCopyIntelliJProjectJarToLibGui(libObjs)
  myCopyIntelliJProjectJarToLibGui.Show()
}

libraryCopyIntelliJProjectJarToLibArray := []

setupCopyIntelliJProjectJarToLibGui(libObjsArray)
{
  global listViewCopyIntelliJProjectJarToLibObj
  global closeCopyIntelliJProjectJarToLibWindowCtrl
  global editCopyIntelliJProjectJarToLibLibsCtrl 
  aGui := Gui("+Resize")
  ; color is a darkish purple
	aGui.SetFont("s12 c660066", "Segoe UI")
  ; color is a light grey
	aGui.BackColor := 0xCCCCCC
	aGui.MarginX := 5, aGui.MarginY := 5
  aGui.Add("Text", "h20", "Double click on a jar to copy it to C:\Java\Lib")
  ; Escape key closes the window
  aGui.OnEvent('Escape', closeCopyIntelliJProjectJarToLibWindow)
  ; Don't allow the list to be sorted. Because there doesn't
  ; seem to be a way to get row data I can't put in a hidden
  ; id to be able to copy the proper library.
  ; Background color is a light grey.
  listViewCopyIntelliJProjectJarToLibObj := aGui.Add("ListView", "r10 w700 Grid NoSort BackgroundCCCCCC", ["Library Name", "Full Path"])
  ; Copy the library to targetCopyIntelliJProjectJarToLibDirectory when it is double clicked
  listViewCopyIntelliJProjectJarToLibObj.OnEvent("DoubleClick", LVCopyIntelliJProjectJarToLib_DoubleClick)
  For each, libObj in libObjsArray
  {
    ; Only add rows that have libs in them, as the file may
    ; contain comments.
    if libObj.Has("lib")
    {
      ; Insert into the libraryCopyIntelliJProjectJarToLibArray for later use when
      ; we double click on a library. Have to do this
      ; as the listview object doesn't have a method
      ; to return the columns of that row.
      libraryCopyIntelliJProjectJarToLibArray.Push(libObj)
      listViewCopyIntelliJProjectJarToLibObj.Add(, libObj["lib"], libObj["path"])
    }
  }
  listViewCopyIntelliJProjectJarToLibObj.ModifyCol(1,140)

  ; +default is so Return selects this button.
  closeCopyIntelliJProjectJarToLibWindowCtrl := aGui.Add("Button", "Section xP h30 center BackgroundD8D8D8 +default", "Done")
  closeCopyIntelliJProjectJarToLibWindowCtrl.OnEvent('Click', closeCopyIntelliJProjectJarToLibWindow)

  editCopyIntelliJProjectJarToLibLibsCtrl := aGui.Add("Button", "h30 x+10 center BackgroundD8D8D8 ", "Edit libs.json")
  editCopyIntelliJProjectJarToLibLibsCtrl.OnEvent('Click', editCopyIntelliJProjectJarToLibLibs)
  aGui.OnEvent('Size', resizeCopyIntelliJProjectJarToLibGui)
  return aGui
}

LVCopyIntelliJProjectJarToLib_DoubleClick(LV, RowNumber)
{
  jsonObj := []
  jsonObj := libraryCopyIntelliJProjectJarToLibArray[RowNumber]
  ExitCode := RunWait("cmd.exe /c copy /Y " jsonObj["path"] ' `"' . targetCopyIntelliJProjectJarToLibDirectory . '`"')

  if ExitCode = 0
  {
    ResizableMsgBox jsonObj["path"] " has been copied to " targetCopyIntelliJProjectJarToLibDirectory 
  }
  else
  {
    ResizableMsgBox "Unable to copy`n" "    " jsonObj["path"] "`nto`n    " targetCopyIntelliJProjectJarToLibDirectory "`nMake sure both exist and are readable/writable.", , "800"
  }
}

closeCopyIntelliJProjectJarToLibWindow(*)
{
  myCopyIntelliJProjectJarToLibGui.Hide()
}

resizeCopyIntelliJProjectJarToLibGui(aGui, minMax, w, h)
{
  global listViewCopyIntelliJProjectJarToLibObj
  global closeCopyIntelliJProjectJarToLibWindowCtrl
  global editCopyIntelliJProjectJarToLibLibsCtrl 
  listViewCopyIntelliJProjectJarToLibObj.Move , , w-(2*aGui.MarginX), h-80
  closeCopyIntelliJProjectJarToLibWindowCtrl.Move , h-35
  editCopyIntelliJProjectJarToLibLibsCtrl.Move , h-35
}

editCopyIntelliJProjectJarToLibLibs(*)
{
  ; This is just to ensure files with spaces in name/path are edited.
  fileVal := ' `"' . libsCopyIntelliJProjectJarToLibFile . '`"'
  Run editor fileVal
}

#HotIf

