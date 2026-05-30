#Requires AutoHotkey v2.0.11+

; Use this routine if you need the PID.
; Example:
;   PID := 0
;   Run editor ExplorerGetSelection(), , , &PID
;   BringProcessPIDToFront(PID)

BringProcessPIDToFront(myPID)
{
  win_criteria := "ahk_pid " . myPID
  if (WinExist(win_criteria))
  {
    MsgBox("Win exists...")
    WinActivate(win_criteria) ; Brings to front
  }
}

; Use this routine if you don't need the PID.
; Example:
;   RunProcessInFront("notepad.exe C:\Temp\someFile")
; NOTE: If the command you run with this fails to
; run a second time, it means that the original command
; spawns a child (or children) process(es) that actually
; does(do) the work. Thus, you need to do a run commandLine
; in your Hotkey. Bummer.
RunProcessInFront(commandLine)
{
  PID := 0
  run commandLine, , , &PID
  BringProcessPIDToFront(PID)
}

PromptAndBringPIDToFront()
{
  ; Prompt the user to enter a PID
  myPID := InputBox("Enter the Process ID (PID) of the window you want to activate:", "Activate Window by PID", "w200 h125")

  ; If the user clicked "OK" bring the process with that PID to the front.
  if ( myPID.Result = "OK" )
  {
    BringProcessPIDToFront(myPID.Value)
  }
}


DisplayWinList()
{
  myPID := InputBox("Enter the Process ID (PID) to display the window list:", "Display Window List by PID", "w200 h125")
  if ( myPID.Result = "OK" )
  {
    DisplayWinListForPID(myPID.Value)
  }
}
; Written by Thomas R. Kimpton, ahk@gooberdude.com

DisplayWinListForPID(myPID)
{
  DetectHiddenWindows True  ; Set to True to detect hidden windows

  ; Get an array of window IDs (HWNDs) for the specified PID
  ; The criteria is "ahk_pid" followed by the variable content
  winIDs := WinGetList("ahk_pid " . myPID)

  ; Check if any windows were found
  if winIDs.Length > 0
  {
    msg := "Windows found for PID " myPID ":"
    ; Loop through the array of window IDs
    for index, hwnd in winIDs
    {
      winTitle := WinGetTitle("ahk_id " hwnd) ; Get the title of each window
      msg .= "`n" index ": " winTitle " (HWND: " hwnd ")"
    }
    MsgBox(msg)
  }
  else
  {
    MsgBox("No windows found for PID " myPID ", or the process does not exist.")
  }
}


DisplayWinListNew() {
 PID := InputBox('Enter Process ID (PID) to display the window list:', 'Display Window List by PID', 'w320 h100')
 If PID.Result = 'OK'
  If WinExist('ahk_pid' PID.Value)
   MsgBox winList(proc := WinGetProcessName()), proc, 'Iconi'
  Else MsgBox 'PID not found.`n`n' PID.Value, 'Error', 'Icon!'
}

winList(proc, hidden := True) {
 DetectHiddenWindows hidden
 For index, hWnd in WinGetList('ahk_exe' proc)
  list .= Format('`n{:02}: {} (HWND: {})', index, WinGetTitle(hWnd), hWnd)
 Return Trim(list ?? '', '`n')
}
