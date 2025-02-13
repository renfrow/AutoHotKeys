#Requires AutoHotkey 2.0+
#SingleInstance Force

#include "C:\Users\Public\AutoHotkey\Lib\_JXON.ahk"
#include "C:\Users\Public\AutoHotkey\Lib\CenterMyGUIOnActiveWindow.ahk"
#include "C:\Users\Public\AutoHotkey\Lib\ExplorerSelection.ahk"
#include "C:\Users\Public\AutoHotkey\Lib\AHKEnv.ahk"
#include "C:\Users\Public\AutoHotkey\Lib\UIA.ahk"
#include "C:\Users\Public\AutoHotkey\Lib\UIA_Browser.ahk"
#include "C:\Users\Public\AutoHotkey\Lib\BringProcessPIDToFront.ahk"
#include "C:\Users\Public\AutoHotkey\Lib\StringUtils.ahk"
#include "C:\Users\Public\AutoHotkey\Lib\ResizableMsgBox.ahk"
#include "C:\Users\Public\AutoHotkey\Lib\WinGetActiveWindow.ahk"
#include "C:\Users\Public\AutoHotkey\Lib\WinGetPosEx.ahk"
#include "C:\Users\Public\AutoHotkey\Lib\WinMoveEx.ahk"

#include "C:\Users\Public\AutoHotkey\Lib\Help.ahk"
#include "C:\Users\Public\AutoHotkey\Lib\CopyIntelliJProjectJarToJavaLib.ahk"
#include "C:\Users\Public\AutoHotkey\Lib\CopySelectedFileNames.ahk"
#include "C:\Users\Public\AutoHotkey\Lib\EditGooberdudeURL.ahk"
#include "C:\Users\Public\AutoHotkey\Lib\LoadPuttySession.ahk"
#include "C:\Users\Public\AutoHotkey\Lib\MoveToWallpapers.ahk"
#include "C:\Users\Public\AutoHotkey\Lib\NewRecipe.ahk"
#include "C:\Users\Public\AutoHotkey\Lib\OpenInEditor.ahk"
#include "C:\Users\Public\AutoHotkey\Lib\SetWindowSize.ahk"

editor := getAHKEnvValue("editor", "notepad.exe")

; Use the following for the key names:
; https://www.autohotkey.com/docs/v2/KeyList.htm

; Routines from Help.ahk
; Win-Alt-H
#!H::Help()

; Control-Win-Alt-H
^#!H::EditHelp()

; Routines from CopyIntelliJProjectJarToJavaLib.ahk
; Only active inside IntelliJ
#HotIf WinActive('ahk_exe idea64.exe')
; This hotkey reads the libFile and displays a
; list of libraries. Double clicking on a library
; will copy it to targetDirectory
^#!C::CopyIntelliJProjectJarToLib()
#HotIf

; Routines from CopySelectedFileNames.ahk
; Only active in File Explorer.
#HotIf WinActive('ahk_class CabinetWClass')
; When in File Explorer, Ctrl-Shift-C copies the
; name(s) of the selected file(s).
^+C::CopySelectedFileNames()
#HotIf

; Routines from EditGooberdudeURL.ahk
; Only active in Firefox
#HotIf WinActive('ahk_class MozillaWindowClass')
; Get URL from the active Firefox window. If it
; is from my website, edit the local copy of the
; file.
!^+F::EditGooberdudeURL()
#HotIf

; Routines from LoadPuttySession.ahk
; Popup a window with a menu of Putty sessions.
; Run the selected session.
; Ctrl-Shit-Alt-7
^+!7::LoadPuttySession()
; Run the default session.
; Ctrl-Shit-7
^+7::RunLoadDefaultPuttySession()
; Edit the file with putty sessions that is used
; to build the menu.
; Control-Win-Alt-7
^#!7::EditLoadPuttySession()

; Routines from MoveToWallpapers.ahk
; Only active in File Explorer.
#HotIf WinActive('ahk_class CabinetWClass')
; Get all the files selected in Explorer and copy them
; to the remote folder, then move them to the local
; folder. This is ONLY active if the active window is
; a File Explorer window.
^+W::MoveToWallpapers()
#HotIf

; Routines from NewRecipe.ahk
; Only active in File Explorer.
#HotIf WinActive('ahk_class CabinetWClass')
^!+N::NewRecipe()

; Routines from OpenInEditor.ahk
; Only active in File Explorer.
#HotIf WinActive('ahk_class CabinetWClass')
F1::OpenInEditor()
; Shift-F1
+F1::OpenInMultipleEditor()
; Ctrl-Shift-4
^+4::OpenEditor()
; Ctrl-Shift-E
^+E::EditAHKEnvFile()
#HotIf

; Routines from SetWindowSize.ahk
; Popup a dialog with the current location and
; size of the front window, modify any or all
; of the values and click OK to modify the window.
; Ctrl-Alt-Shift-M
^!+M::SetWindowSizeGUI()

; Set the size of the front window to 1200 wide
; by 900 tall.
; Ctrl-Win-M
^#M::SetWindowSize1200x900()
; Set the size of the front window to 1800 wide
; by 1200 tall.
; Ctrl-Shift-M
^+M::SetWindowSize1800x1200()
; Set the size of the front window to 2400 wide
; by 1800 tall.
; Alt-Win-M
!#M::SetWindowSize2400x1800()

global moveSetWindowSizeWindowAmount := 100
; Alt-Win-UpArrow
#!Up::moveSetWindowSizeWindow(-SetWindowSizeMovementAmount)
; Alt-Win-DownArrow
#!Down::moveSetWindowSizeWindow(SetWindowSizeMovementAmount)
; Alt-Win-LeftArrow
#!Left::moveSetWindowSizeWindow(, -SetWindowSizeMovementAmount)
; Alt-Win-RightArrow
#!Right::moveSetWindowSizeWindow(, SetWindowSizeMovementAmount)
