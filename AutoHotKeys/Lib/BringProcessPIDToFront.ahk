#Requires AutoHotkey v2.0.11+

; Use this routine if you need the PID.
; Example:
;   PID := 0
;   Run editor ExplorerGetSelection(), , , &PID
;   BringProcessPIDToFront(PID)

BringProcessPIDToFront(PID)
{
  if WinWaitActive("ahk_pid " PID)
    ;WinActivate
    return
}

; Use this routine if you don't need the PID.
; Example:
;   RunProcessInFront("notepad.exe C:\Temp\someFile")
RunProcessInFront(commandLine)
{
  PID := 0
  run commandLine, , , &PID
  if WinWaitActive("ahk_pid " PID)
    ;WinActivate
    return
}

