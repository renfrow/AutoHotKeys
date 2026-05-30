#Requires AutoHotkey v2.0.11+

; Written by Thomas R. Kimpton, ahk@gooberdude.com

; Get all the files selected in Explorer and copy them
; to the remote folder, then move them to the local
; folder. This is ONLY active if the active window is
; a File Explorer window.

#HotIf WinActive('ahk_class CabinetWClass')

;#include "C:\Users\Public\AutoHotkey\Lib\ExplorerSelection.ahk"

remoteMoveToWallpapersFolder := "V:\WallPapers\."
localMoveToWallpapersFolder := "C:\WallPapers\."

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
      MsgBox Format("FileMove failed: {1}`nTried to move {2}`nto {3}", errMessage, aFile.Path, localMoveToWallpapersFolder)
      return
    }
  }
}
#HotIf

