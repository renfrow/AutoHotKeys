#Requires AutoHotkey v2.0.11+

;#include "C:\Users\Public\AutoHotkey\Lib\UIA.ahk"
;#include "C:\Users\Public\AutoHotkey\Lib\UIA_Browser.ahk"
;#include "C:\Users\Public\AutoHotkey\Lib\AHKEnv.ahk"

#HotIf WinActive('ahk_class MozillaWindowClass')

; Get URL from the active Firefox window. If it
; is from my website, edit the local copy of the
; file.
EditGooberdudeURL()
{
	global browserEditGooberdudeURL := UIA_Mozilla()
  global webSiteVolumeEditGooberdudeURL := "Z:/public_html"
  
  global currentURLEditGooberdudeURL := browserEditGooberdudeURL.GetCurrentURL() 
  global matchObjEditGooberdudeURL := 0
  if RegExMatch(currentURLEditGooberdudeURL, "https?://miniserver/~tkimpton|https?://www.gooberdude.com/~tkimpton", &matchObjEditGooberdudeURL) > 0
  {
    aFile := SubStr(currentURLEditGooberdudeURL, matchObjEditGooberdudeURL.Len+1)
    fileVal := ' `"' . webSiteVolumeEditGooberdudeURL . aFile . '`"'
    Run editor fileVal
  }
}

#HotIf

