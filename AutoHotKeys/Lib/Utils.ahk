#Requires AutoHotkey v2.0

; Written by Thomas R. Kimpton, ahk@gooberdude.com

; Put utility routines in here.

; When you want to over-ride a key to do nothing.
Donothing()
{
}

EditMasterKeyFile()
{
  RunProcessInFront(editor (getAHKEnvValue("AHKENV_MasterKeyFile", defaultValue := "C:\Users\Public\AutoHotkey\HotKeyMaster.ahk")))
}

; These are all File Explorer specific.
#HotIf WinActive('ahk_class CabinetWClass')
;typedef enum FOLDERVIEWMODE {
;  FVM_AUTO = -1,
;  FVM_FIRST = 1,
;  FVM_ICON = 1,
;  FVM_SMALLICON = 2,
;  FVM_LIST = 3,
;  FVM_DETAILS = 4,
;  FVM_THUMBNAIL = 5,
;  FVM_TILE = 6,
;  FVM_THUMBSTRIP = 7,
;  FVM_CONTENT = 8,
;  FVM_LAST = 8
;} ;

; Toggle between Detail view and Large Icon view.
toggleDetailLargeIconsView()
{
 Static ICONS    := 1
      , DETAILS := 4
 hWnd := WinActive()
 For oWin in ComObject('Shell.Application').Windows
  If oWin.Hwnd = hWnd
    if oWin.Document.CurrentViewMode = DETAILS 
    {
      oWin.Document.CurrentViewMode := ICONS
      oWin.Document.IconSize := 255
    }
    else
    {
      oWin.Document.CurrentViewMode := DETAILS
    }
}

SafeRename()
{
  RunProcessInFront("safeRename.bat" ExplorerGetSelection())
}

CopyFileNames(surroundWithQuotes := 0)
{
  files := []
  files := ExplorerGetSelectedItems()
  aFile := 0
  i := 0
  A_Clipboard := ""
  for aFile in files
  {
    if i > 0
    {
      A_Clipboard .= '`n'
    }
    if surroundWithQuotes == 0
    {
      fileVal := aFile.Path
    }
    else
    {
      fileVal := ' `"' . aFile.Path . '`"'
    }
    A_Clipboard .= fileVal
    i++
  }
}

#HotIf

; Minimize the frontmost window.
MinimizeFrontWindow()
{
  ;WinMinimize "A"  
  ; Use the following to make sure the window's
  ; application does what it normally does when
  ; the minimize button is pressed! For example,
  ; when an app is 'minimized' to the task bar.
  PostMessage 0x0112, 0xF020,,, "A" ; 0x0112 = WM_SYSCOMMAND, 0xF020 = SC_MINIMIZE
}

; Sometimes you want a new explorer process. Win-E
; simply opens a new Explorer window in the current
; process.
LaunchNewExplorer()
{
  run "explorer.exe"
}

