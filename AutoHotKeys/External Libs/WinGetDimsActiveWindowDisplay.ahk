#Requires autohotkey v2.0

; Get the dimensions of the display of the
; active window.
WinGetDimsActiveWindowDisplay(&width, &height)
{
  activeHwnd := WinExist("A")
  
  ; Find which monitor index contains the active window
  ; In AHK v2, there isn't a direct "MonitorFromWindow" function, 
  ; so we loop through monitors to see which one contains the window's center.
  WinGetPos(&winX, &winY, &winWidth, &winHeight, activeHwnd)
  centerX := winX + (winWidth / 2)
  centerY := winY + (winHeight / 2)
  
  monitorCount := MonitorGetCount()
  monitorIndex := 1 ; Default to primary
  
  Left := 0
  Top := 0
  Right := 0
  Bottom := 0
  
  Loop monitorCount
  {
    MonitorGet(A_Index, &Left, &Top, &Right, &Bottom)
    if (centerX >= Left && centerX <= Right && centerY >= Top && centerY <= Bottom)
    {
      monitorIndex := A_Index
      break
    }
  }
  
  width := Right - Left
  height := Bottom - Top
}
