#Requires AutoHotkey 2.0+
#SingleInstance Force

; Written by Thomas R. Kimpton, ahk@gooberdude.com

;#include "C:\Users\Public\AutoHotkey\Lib\ExplorerSelection.ahk"

; Only active in File Explorer.
#HotIf WinActive('ahk_class CabinetWClass')
CreateFileFromNameInClipboard()
{
  fileName := A_Clipboard
  if !IsFileNameLegal(fileName)
  {
    MsgBox fileName " is not a legal file name, it may not contain any of the following characters " illegalFileNameChars ,,0x10
    Return 0
  }
  filePath := Explorer() '\' fileName
  if FileExist(filePath)
  {
    MsgBox fileName " already exists, not changed!" ,, 0x10
    Return 0
  }

  fileObj := FileOpen(filePath, "w", "UTF-8")

  ; Check if the file was successfully opened
  if fileObj
  {
    ; Close the file to save changes and release the file handle
    fileObj.Close()
    MsgBox "File '" filePath "' successfully created.",,0x30
  }
  else
  {
    MsgBox "Failed to create " filePath,,0x10
  }
}
#HotIf

global illegalFileNameChars := '<>:"/\|?*'
global illegalFilePathChars := '<>"|?*'

IsFileNameLegal(fileName)
{
  Loop StrLen(fileName)
  {
    aChar := SubStr(fileName, A_Index, 1)
    switch aChar
    {
      case '<', '>', ':', '"', '/', '\', '|', '?', '*':
        MsgBox(fileName " contains the illegal character: '" aChar "'")
        return 0
    }
  }
  return 1
}

IsFilePathLegal(filePath)
{
  Loop StrLen(filePath)
  {
    aChar := SubStr(filePath, A_Index, 1)
    switch aChar
    {
      case '<', '>', '"', '|', '?', '*':
        MsgBox(filePath " contains the illegal character: '" aChar "'")
        return 0
    }
  }
  return 1
}

; Make a backup of the selected file(s) to the directory
; '@old' in the current directory. Name the backup file
; according to the last modify time(filename-yyyy-MM-dd-HHmm.ext) :
; filename.ext -> @old\filename-2026-03-23-1520.ext
BackUpToDatedFile(moveIt := 0)
{
  files := ExplorerGetSelectedItems()
  pathSep := "\"
  bkupDirName := "@old"
  SplitPath files[1].Path, , &root, &ext, &nameNoExt
  bkupDirPath := root pathSep bkupDirName
  if not DirExist(bkupDirPath)
  {
    DirCreate bkupDirPath
  }
  fileVal := ""
  for item in files
  {
    fileVal := item.Path

    ; Use the FileGetTime function to retrieve the timestamp string
    modTime := FileGetTime(fileVal, "M") ; "M" specifies the modification time
    timeStamp := FormatTime(modTime, "-yyyy-MM-dd-HHmm")
    root := ""
    ext := ""
    nameNoExt := ""
    SplitPath fileVal, , &root, &ext, &nameNoExt
    newFileName := bkupDirPath pathSep nameNoExt timeStamp '.' ext
    try {
      if moveIt = 1
        FileMove(fileVal, newFileName)
      else
        FileCopy(fileVal, newFileName)
    } catch as err {
        MsgBox Format("{1}: {2}.`n`nScript:`t{3}`nFile:`t{4}`nDest:`t{5}`nLine:`t{6}`nWhat:`t{7}`nStack:`n{8}"
          , type(err), OSError(A_LastError).Message, err.File, fileVal, newFileName, err.Line, err.What, err.Stack)
    }
  }
}

FileUtilsFixBackSlashes(filePath)
{
  return StrReplace(filePath, "\", "/")
}

; Convert
;    X:\full\directory\path to\file.txt
; to
;    /x/full/directory/path to/file.txt
FileUtilsFixBashPaths(filePath)
{
  fileVal := "/" . StrLower(SubStr(filePath, 1, 1)) . SubStr(filePath, 3)
  fileVal := FileUtilsFixBackSlashes(fileVal)
  return fileVal

}

