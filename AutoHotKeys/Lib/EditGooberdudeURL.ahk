#Requires AutoHotkey v2.0.11+

; Written by Thomas R. Kimpton, ahk@gooberdude.com

;#include "C:\Users\Public\AutoHotkey\Lib\UIA.ahk"
;#include "C:\Users\Public\AutoHotkey\Lib\UIA_Browser.ahk"
;#include "C:\Users\Public\AutoHotkey\Lib\AHKEnv.ahk"

#HotIf WinActive('ahk_class MozillaWindowClass')

; Get URL from the active Firefox window. If it
; is from my website, edit the local copy of the
; file.
;
; NOTE: For some reason the working directory is
; not set when we use this to edit a file on the
; website, but, defaults to the user's home directory.
; If you try to do a 'gf' of a file name that would
; be in a relative path of the file's directory it
; would attempt to find it via the user's home
; directory. Thus most of the code is for setting
; the working directory correctly.
EditGooberdudeURL()
{
	global browserEditGooberdudeURL := UIA_Mozilla()
  global webSiteVolumeEditGooberdudeURL := "Z:/public_html"
  global currentURLEditGooberdudeURL := browserEditGooberdudeURL.GetCurrentURL() 
  global matchObjEditGooberdudeURL := 0
  global lastPosEditGooberdudeURL := 0
  if RegExMatch(currentURLEditGooberdudeURL, "https?://miniserver/~tkimpton|https?://www.gooberdude.com/~tkimpton", &matchObjEditGooberdudeURL) > 0
  {
    aFile := SubStr(currentURLEditGooberdudeURL, matchObjEditGooberdudeURL.Len+1)

    ; See if the string was url encoded.
    if InStr(aFile, "%") 
    {
      aFile := UrlUnescape(aFile)
    }
    ; Strip off any url params
    pos := InStr(aFile, "?")
    if pos > 0
    {
      aFile := SubStr(aFile, 1, pos - 1)
    }

    ; We need to set the current directory, for the
    ; editor, as it might start in some arbitrary
    ; directory, rather that the directory where
    ; the file actually exists.
    currentDir := webSiteVolumeEditGooberdudeURL
    lastPosEditGooberdudeURL := InStr(aFile, '/', false, -1)
    If (lastPosEditGooberdudeURL > 0) ; Ensure the character was found
    {
      currentDir .= SubStr(aFile, 1, lastPosEditGooberdudeURL - 1)
    }
    else
    {
      lastPosEditGooberdudeURL := InStr(aFile, '\', false, -1)
      If (lastPosEditGooberdudeURL > 0) ; Ensure the character was found
      {
        currentDir .= SubStr(aFile, 1, lastPosEditGooberdudeURL - 1)
      }
    }
    SetWorkingDir currentDir

    ; Strip off possible # anchors
    lastPosEditGooberdudeURL := InStr(aFile, '#', false, -1)
    If (lastPosEditGooberdudeURL > 0) ; Ensure the character was found
    {
      aFile := SubStr(aFile, 1, lastPosEditGooberdudeURL - 1)
    }
    ; Make sure the fileVal is surrounded by quotes, in case there
    ; are spaces in the file name.
    fileVal := ' `"' . webSiteVolumeEditGooberdudeURL . aFile . '`"'
    Run editor fileVal
  }
}

#HotIf

