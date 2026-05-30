#Requires AutoHotkey 2.0+
#SingleInstance Force

;#include "C:\Users\Public\AutoHotkey\Lib\ExplorerSelection.ahk"
;#include "C:\Users\Public\AutoHotkey\Lib\AHKEnv.ahk"
;#include "C:\Users\Public\AutoHotkey\Lib\BringProcessPIDToFront.ahk"
;#include "C:\Users\Public\AutoHotkey\Lib\jsongo.v2.ahk"

; Returns a list of wall paper files, one per monitor.

GetListOfWallPapers()
{
  GetListOfWallPapersList := []

  ; Create the IDesktopWallpaper COM object
  try {
    ; https://www.autohotkey.com/docs/v2/lib/ComObject.htm
    desktopWallpaperComObject := ComObject("{C2CF3110-460E-4fc1-B9D0-8A1C0C9CC4BD}", "{B92B56A9-8B55-4E14-9A89-0199BBB6F93B}")
  } catch {
    MsgBox "IDesktopWallpaper is not supported on this system."
    return
  }

  monitorCount := 0
  ; 1. Get the number of monitors
  ComCall(6, desktopWallpaperComObject, "uint*", &monitorCount) ; GetMonitorDevicePathCount

  loop monitorCount {
    index := A_Index - 1 ;ahk indices start at 1, C type languages start at 0
    
    ; 2. Get the Monitor Device Path
    ComCall(5, desktopWallpaperComObject, "uint", index, "ptr*", &monitorID := 0) ; GetMonitorDevicePathAt
    
    ; 3. Get the Wallpaper for this monitor
    retVal := ComCall(4, desktopWallpaperComObject, "ptr", monitorID, "ptr*", &wallpaperPtr := 0) ; GetWallpaper
    
    wallpaper := ""
    if (retVal == 0) { ; S_OK
      wallpaper := StrGet(wallpaperPtr, "UTF-16") ; Convert the string from utf16 to normal (utf8?) string
      DllCall("ole32\CoTaskMemFree", "ptr", wallpaperPtr) ; Free the string
    }
    GetListOfWallPapersList.push(wallpaper)
  }
  return GetListOfWallPapersList
}

; Open the current wallpaper(s) in your graphics viewer.
ViewCurrentWallpapers()
{
  wallPaperPath := ""
  viewer := getAHKEnvValue("graphicsViewer", defaultValue := "C:/Program Files/IrfanView/i_view64.exe")
  for , wallPaperPath in GetListOfWallPapers()
  {
    wallPaperPath := ' `"' . wallPaperPath . '`"'
    RunProcessInFront(viewer wallPaperPath)
  }
}

; Open the current wallpaper(s), for monitor n,  in your graphics viewer.
GetWallPaperForMonitor(n:=1)
{
  return GetListOfWallPapers()[n]
}

