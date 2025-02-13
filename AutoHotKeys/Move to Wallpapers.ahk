#Requires AutoHotkey v2.0.11+

; Get all the files selected in Explorer and copy them
; to the remote folder, then move them to the local
; folder. This is ONLY active if the active window is
; a File Explorer window.
#HotIf WinActive('ahk_class CabinetWClass')

; C:\Users\Public\Documents\ is a folder available
; to and writable by all users on a windows computer.
; You will need to create AutoHotkey\Lib\ and put
; ExplorerGetSelectedItems.ahk into it.
#include "C:\Users\Public\Documents\AutoHotkey\Lib\ExplorerSelection.ahk"

; https://www.autohotkey.com/docs/v2/lib/FileCopy.htm
remoteFolder := "V:\WallPapers\."
localFolder := "C:\WallPapers\."

; Replace 'W' with whatever key you want to use,
; prepending '+' for shift, '^' for control, '!' for
; alt, and '#' for win. Thus '+#PgDn' will activate
; with shift-win-PgDn. The modifiers may be in
; any order. Use the following for the key names:
; https://www.autohotkey.com/docs/v2/KeyList.htm
^+W::
{
  global files := ExplorerGetSelectedItems()
  aFile := 0
  for aFile in files
  {
    try
      FileCopy aFile.Path, remoteFolder
    catch Error as Err
    {
      errMessage := OSError(A_LastError).Message
      MsgBox Format("FileCopy failed: {1}`nTried to copy {2}`nto {3}", errMessage, aFile.Path, remoteFolder)
      return
    }
    try
      FileMove aFile.Path, localFolder
    catch Error as Err
    {
      errMessage := OSError(A_LastError).Message
      MsgBox Format("FileMove failed: {1}`nTried to move {2}`nto {3}", errMessage, aFile.Path, remoteFolder)
      return
    }
  }
}
Return
#HotIf

