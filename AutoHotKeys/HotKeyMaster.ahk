#Requires AutoHotkey 2.0+
#SingleInstance Force

; Libs
#include "C:\Users\Public\AutoHotkey\Lib\AHKEnv.ahk"
#include "C:\Users\Public\AutoHotkey\Lib\AHKUtils.ahk"
#include "C:\Users\Public\AutoHotkey\Lib\Array.ahk"
#include "C:\Users\Public\AutoHotkey\Lib\BringProcessPIDToFront.ahk"
#include "C:\Users\Public\AutoHotkey\Lib\CenterMyGUIOnActiveWindow.ahk"
#include "C:\Users\Public\AutoHotkey\Lib\CenteredMsgBox.ahk"
#include "C:\Users\Public\AutoHotkey\Lib\DesktopWallPaperLib.ahk"
#include "C:\Users\Public\AutoHotkey\Lib\ExplorerSelection.ahk"
#include "C:\Users\Public\AutoHotkey\Lib\ExplorerUtils.ahk"
#include "C:\Users\Public\AutoHotkey\Lib\FileUtils.ahk"
#include "C:\Users\Public\AutoHotkey\Lib\GameUtils.ahk"
#include "C:\Users\Public\AutoHotkey\Lib\GetCmdStringOutput.ahk"
#include "C:\Users\Public\AutoHotkey\Lib\jsongo.v2.ahk"
#include "C:\Users\Public\AutoHotkey\Lib\KeyboardUtils.ahk"
#include "C:\Users\Public\AutoHotkey\Lib\MouseUtils.ahk"
#include "C:\Users\Public\AutoHotkey\Lib\RadioModule.ahk"
#include "C:\Users\Public\AutoHotkey\Lib\ResizableMsgBox.ahk"
#include "C:\Users\Public\AutoHotkey\Lib\StringUtils.ahk"
#include "C:\Users\Public\AutoHotkey\Lib\UIA.ahk"
#include "C:\Users\Public\AutoHotkey\Lib\UIA_Browser.ahk"
#include "C:\Users\Public\AutoHotkey\Lib\Utils.ahk"
#include "C:\Users\Public\AutoHotkey\Lib\WindowUtils.ahk"
#include "C:\Users\Public\AutoHotkey\Lib\WinGetActiveWindow.ahk"
#include "C:\Users\Public\AutoHotkey\Lib\WinGetDimsActiveWindowDisplay.ahk"
#include "C:\Users\Public\AutoHotkey\Lib\WinGetPosEx.ahk"
#include "C:\Users\Public\AutoHotkey\Lib\WinMoveEx.ahk"
#include "C:\Users\Public\AutoHotkey\Lib\WsayUtils.ahk"

; HotKeys
#include "C:\Users\Public\AutoHotkey\Lib\CopyIntelliJProjectJarToJavaLib.ahk"
#include "C:\Users\Public\AutoHotkey\Lib\CopySelectedFileNames.ahk"
#include "C:\Users\Public\AutoHotkey\Lib\EditAHKConfigFiles.ahk"
#include "C:\Users\Public\AutoHotkey\Lib\EditGooberdudeURL.ahk"
#include "C:\Users\Public\AutoHotkey\Lib\FireFoxUtils.ahk"
#include "C:\Users\Public\AutoHotkey\Lib\Help.ahk"
#include "C:\Users\Public\AutoHotkey\Lib\LoadGame.ahk"
#include "C:\Users\Public\AutoHotkey\Lib\LoadPuttySession.ahk"
#include "C:\Users\Public\AutoHotkey\Lib\MoveCurrentWindow.ahk"
#include "C:\Users\Public\AutoHotkey\Lib\MoveToWallpapers.ahk"
#include "C:\Users\Public\AutoHotkey\Lib\NewRecipe.ahk"
#include "C:\Users\Public\AutoHotkey\Lib\OpenDirectory.ahk"
#include "C:\Users\Public\AutoHotkey\Lib\OpenInEditor.ahk"
#include "C:\Users\Public\AutoHotkey\Lib\OpenInFileExplorer.ahk"
#include "C:\Users\Public\AutoHotkey\Lib\ResizeCurrentWindowOnSide.ahk"
#include "C:\Users\Public\AutoHotkey\Lib\RunChrome.ahk"
#include "C:\Users\Public\AutoHotkey\Lib\SetWindowSize.ahk"
#include "C:\Users\Public\AutoHotkey\Lib\ToggleBluetooth.ahk"

; Put all your Hotkeys here. This has the benefit that all
; your key definitions are in one place, and, if you edit
; the AHKEnv file, all the Hotkeys share the current
; AHKEnv values.

;editor := getAHKEnvValue("editor", "notepad.exe")
global bashShell := getAHKEnvValue("bashShell", "bash.exe")
global AHKMasterKeyFile := getAHKEnvValue("AHKMasterKeyFile", "C:/Users/Public/AutoHotkey/HotKeyMaster.ahk")

; Use the following for the key names:
; https://www.autohotkey.com/docs/v2/KeyList.htm

; Use the following for key mods
; # = Win
; ^ = Ctrl
; ! = Alt
; + = Shift

; If modifiers-someKey is used by some program
; you use, or some window or whatever, surround
; your hotkey with the WinActive and set it up
; to exclude that app/window/whatever. Use 'and'
; for subsequent additions.
;
;#HotIf !WinActive('ahk_exe someApp.exe') and !WinActive("ahk_class someWindow")
; Your hotkey here.
;#HotIf


; Routines from Help.ahk
; Alt-Win-H
!#H::Help()

; Alt-Control-Win-H
!^#H::EditHelp()

; Routines from CopyIntelliJProjectJarToJavaLib.ahk
; Only active inside IntelliJ
#HotIf WinActive('ahk_exe idea64.exe')
; This hotkey reads the libFile and displays a
; list of libraries. Double clicking on a library
; will copy it to targetDirectory
!^#C::CopyIntelliJProjectJarToLib()
#HotIf

; Routines from CopySelectedFileNames.ahk
; Only active in File Explorer.
#HotIf WinActive('ahk_class CabinetWClass')
; When in File Explorer, Ctrl-Shift-C copies the
; name(s) of the selected file(s).
; Ctrl-Shift-C
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
; Ctrl-Shift-Win-7
^+#7::LoadPuttySession()
; Open Putty to select a session.
; Alt-Ctrl-Shift-7
^+!7::RunPutty()
; Run the default session.
; Ctrl-Shift-7
^+7::RunLoadDefaultPuttySession()

; Routines from LoadGame.ahk
; 
; Ctrl-Shift-Win-G
^+#G::LoadGame()

; Make the Ctrl-V paste in Putty
#HotIf WinActive('ahk_exe putty.exe')
; Ctrl-V
^V::PuttyPaste()
#HotIf

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
; Alt-Ctrl-Shift-N
^!+N::NewRecipe()

; Routines from OpenInEditor.ahk
; Only active in File Explorer.
#HotIf WinActive('ahk_class CabinetWClass')
F1::OpenInEditor()
; Shift-F1
+F1::OpenInMultipleEditor()
#HotIf
; Routines from OpenInEditor.ahk
; Active everywhere.
; Ctrl-Shift-4
^+4::OpenEditor()
; Ctrl-Shift-E
^+E::EditAHKEnvFile()

; Routines from EditAHKConfigFiles.ahk
; Active everywhere.
; Popup a list of AHK Config files to choose one
; to edit.
; Alt-Ctrl-Shift-E
!^+E::EditAHKConfigFiles()

; DON'T resize/move the File Explorer taskbar!
; Sometimes it can be active even if you think
; an ordinary window is active...
#HotIf !WinActive('ahk_class Shell_TrayWnd')
; Routines from SetWindowSize.ahk
; Popup a dialog with the current location and
; size of the front window, modify any or all
; of the values and click OK to modify the window.
; Alt-Ctrl-Shift-M
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

global MoveCurrentWindowAmount := 100
; Alt-Win-UpArrow
!#Up::MoveCurrentWindow(-MoveCurrentWindowAmount)
; Alt-Win-DownArrow
!#Down::MoveCurrentWindow(MoveCurrentWindowAmount)
; Alt-Win-LeftArrow
!#Left::MoveCurrentWindow(, -MoveCurrentWindowAmount)
; Alt-Win-RightArrow
!#Right::MoveCurrentWindow(, MoveCurrentWindowAmount)

global ResizeCurrentWindowOnSideAmount := 100
; Next 4 keys INCREASE the size
; Alt-Ctrl-Win-UpArrow
!^#Up::ResizeCurrentWindowOnSide(ResizeCurrentWindowOnSideTop,ResizeCurrentWindowOnSideAmount)
; Alt-Ctrl-Win-DownArrow
!^#Down::ResizeCurrentWindowOnSide(ResizeCurrentWindowOnSideBottom, ResizeCurrentWindowOnSideAmount)
; Alt-Ctrl-Win-LeftArrow
!^#Left::ResizeCurrentWindowOnSide(ResizeCurrentWindowOnSideLeft, ResizeCurrentWindowOnSideAmount)
; Alt-Ctrl-Win-RightArrow
!^#Right::ResizeCurrentWindowOnSide(ResizeCurrentWindowOnSideRight, ResizeCurrentWindowOnSideAmount)

; Next 4 keys DECREASE the size
; Alt-Ctrl-Shift-UpArrow
!^+Up::ResizeCurrentWindowOnSide(ResizeCurrentWindowOnSideTop, -ResizeCurrentWindowOnSideAmount)
; Alt-Ctrl-Shift-DownArrow
!^+Down::ResizeCurrentWindowOnSide(ResizeCurrentWindowOnSideBottom, -ResizeCurrentWindowOnSideAmount)
; Alt-Ctrl-Shift-LeftArrow
!^+Left::ResizeCurrentWindowOnSide(ResizeCurrentWindowOnSideLeft, -ResizeCurrentWindowOnSideAmount)
; Alt-Ctrl-Shift-RightArrow
!^+Right::ResizeCurrentWindowOnSide(ResizeCurrentWindowOnSideRight, -ResizeCurrentWindowOnSideAmount)

; Move the current window down to a corner of the current display
; Ctrl-Shift-Win-UpArrow
^+#Up::MoveCurrentWindowToCorner(MoveCurrentWindowUpperLeftCorner)
; Ctrl-Shift-Win-RightArrow
^+#Right::MoveCurrentWindowToCorner(MoveCurrentWindowUpperRightCorner)
; Ctrl-Shift-Win-LeftArrow
^+#Left::MoveCurrentWindowToCorner(MoveCurrentWindowLowerLeftCorner)
; Ctrl-Shift-Win-DownArrow
^+#Down::MoveCurrentWindowToCorner(MoveCurrentWindowLowerRightCorner)
#HotIf

; Run Chrome in incognito mode. For when you don't want
; Google adding to your shopping or whatever list.
; Alt-Control-Shift-0
^!+0::RunChromeIncognitoWithFiles()
; Control-Shift-0
^+0::RunChromeWithFiles()

; Only active inside Irfanview.
; Prevents Irfanview from making the current picture
; the desktop picture.
#HotIf WinActive('ahk_exe i_view64.exe')
^+T::Donothing()
^+#T::Donothing()
#HotIf


#HotIf WinActive('ahk_class CabinetWClass')
^F12::toggleDetailLargeIconsView()
#HotIf

#HotIf WinActive('ahk_class CabinetWClass')
; Control-Shift-Win-R
^+#R::safeRename()
#HotIf

#HotIf !WinActive('ahk_exe eso64.exe') and !WinActive("ahk_class UnrealWindow") and !WinActive("ahk_class Fallout4") and !WinActive("ahk_class Oblivion") and !WinActive("ahk_exe SkyrimSE.exe") and !WinActive("ahk_exe FalloutNV.exe")
; Use F5 to minimize the frontmost window.
F5::MinimizeFrontWindow()
#HotIf

#HotIf WinActive("ahk_class Fallout4")
; Do nothing instead of opening console
;`::Donothing()
;~::{
;Send('``')
;}
#HotIf

; Routines from SpeakSelectedFile.ahk
#HotIf WinActive('ahk_class CabinetWClass')
; Speak the contents of the currently selected
; file in File Explorer. This is ONLY active if
; the active window is a File Explorer window.
; Alt-Ctrl-Shift-S
!^+S::SpeakSelectedFile()
#HotIf

#HotIf WinActive('ahk_class CabinetWClass')
; Open the currently selected folder(s) in File
; Explorer. This is ONLY active if the active
; window is a File Explorer window.
; Alt-Ctrl-Shift-D
!^+D::OpenInFileExplorer()
#HotIf

; Sometimes you want a new explorer process,
; the normal Win-E simply opens a new Explorer
; window in the current process.
; Shift-Win-E
+#E::LaunchNewExplorer()

; Edit HotKeyMaster.ahk (this file)
; Alt-Ctrl-Shift-K
!^+K::EditAFile("C:\Users\Public\AutoHotkey\HotKeyMaster.ahk")

#HotIf WinActive('ahk_class CabinetWClass')
; Open a bash shell in the current folder in File
; Explorer. This is ONLY active if the active
; window is a File Explorer window.
; Alt-Ctrl-Shift-B
!^+B::{
  run bashShell " --cd=" Explorer()
}
#HotIf

; Alt-Ctrl-Shift-A
!^+A::{
  Run "C:/Program Files/AutoHotkey/v2/AutoHotkey64.exe " AHKMasterKeyFile
}

; Use these keys only within Oblivion Remastered
#HotIf WinActive('ahk_exe OblivionRemastered-Win64-Shipping.exe')
NumPad8::{
  MouseMoveGame(0, -10)
}
NumPad5::{
  MouseMoveGame(0, 10)
}
NumPad4::{
  MouseMoveGame(-10, 0)
}
NumPad6::{
  MouseMoveGame(10, 0)
}
NumPad7::{
  MouseClickGame()
}
#HotIf

; Only active in File Explorer.
#HotIf WinActive('ahk_class CabinetWClass')
; When in File Explorer, Alt-Ctrl-Shift-N
; creates a file, using the contents of the
; clipboard as the name, in the active folder.
; Ctrl-Shift-Win-N
^+#N::CreateFileFromNameInClipboard()
#HotIf

#HotIf WinActive('ahk_class MozillaWindowClass')
; Ctrl-Shift-Z
^+Z::ReopenLastTab()
; Alt-Ctrl-P
!^P::GiveTempPermissionOnWebPage()
#HotIf

; Alt-Ctrl-Shift-P
;!^+P::PromptAndBringPIDToFront()
!^+P::DisplayWinList()

; Open a GUI with buttons for directories to open
; with Explorer.
; Alt-Ctrl-Shift-O
!^+O::LoadOpenDirectory()

; Edit the JSON list of directories used for
; LoadOpenDirectory() with Explorer.
; Alt-Ctrl-Shift-Win-O
!^+#O::EditLoadOpenDirectory()

#HotIf WinActive('ahk_class CabinetWClass')
; Alt-Win-B
; Copy the file.ext as file-modDate.ext to @old in the file's directory.
; modDate formatted as YYYY-MM-DD-hhmm
!#B::BackUpToDatedFile()
; Alt-Ctrl-Win-B
; Move the file.ext as file-modDate.ext to @old in the file's directory.
; modDate formatted as YYYY-MM-DD-hhmm
!^#B::BackUpToDatedFile(1)
#HotIf

!#G::ViewCurrentWallpapers()

; Some apps do not use Ctrl-W to close windows.
;#HotIf WinActive('ahk_exe PowerToys.Settings.exe') or WinActive('ahk_exe 7zFM.exe') or WinActive('ahk_exe AutoHotkey64.exe') or WinActive('ahk_exe ApplicationFrameHost.exe')
#HotIf !WinActive('ahk_exe gvim.exe') and !WinActive('ahk_exe FalloutNV.exe') and !WinActive('ahk_exe firefox.exe')
^W::CloseWindow()
#HotIf

; Win-s
#S::PopupWindowSpy()

; Alt-Ctrl-Shift-W
^+!W::BringApplicationWindowToFront("ahk_class CabinetWClass", "File Explorer")

