#Requires AutoHotkey v2.0.11+

; Get all the files selected in Explorer and copy them
; to the remote folder, then move them to the local
; folder. This is ONLY active if the active window is
; a File Explorer window.
#HotIf WinActive('ahk_class CabinetWClass')

; C:\Users\Public\ is a folder available
; to and writable by all users on a windows computer.
; You will need to create AutoHotkey\Lib\ and put
; ExplorerGetSelectedItems.ahk into it.
;#include "C:\Users\Public\AutoHotkey\Lib\ExplorerSelection.ahk"

; https://www.autohotkey.com/docs/v2/lib/FileCopy.htm
remoteMoveToWallpapersFolder := "V:\WallPapers\."
localMoveToWallpapersFolder := "C:\WallPapers\."

; Replace 'W' with whatever key you want to use,
; prepending '+' for shift, '^' for control, '!' for
; alt, and '#' for win. Thus '+#PgDn' will activate
; with shift-win-PgDn. The modifiers may be in
; any order. Use the following for the key names:
; https://www.autohotkey.com/docs/v2/KeyList.htm
MoveToWallpapers()
{
  files := ExplorerGetSelectedItems()
  aFile := 0
  for aFile in files
  {
    try
      FileCopy aFile.Path, remoteMoveToWallpapersFolder
    catch Error as Err
    {
      errMessage := OSError(A_LastError).Message
      MsgBox Format("FileCopy failed: {1}`nTried to copy {2}`nto {3}", errMessage, aFile.Path, remoteMoveToWallpapersFolder)
      return
    }
    try
      FileMove aFile.Path, localMoveToWallpapersFolder
    catch Error as Err
    {
      errMessage := OSError(A_LastError).Message
      MsgBox Format("FileMove failed: {1}`nTried to move {2}`nto {3}", errMessage, aFile.Path, remoteMoveToWallpapersFolder)
      return
    }
  }
}
#HotIf

