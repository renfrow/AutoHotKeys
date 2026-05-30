#Requires AutoHotkey v2.0

; Written by Thomas R. Kimpton, ahk@gooberdude.com

; Written with the help of AI

; Array.ahk gives you the ability to sort arrays.
; Otherwise the gui would show the windows in
; current front to back order. I find it easier
; to find a window if they're sorted alphabetically.

;#include "C:\Users\Public\AutoHotkey\Lib\Array.ahk"

BringApplicationWindowToFront(whichApp, appTitle)
{
    ; Get a list of all active Application window IDs
    applicationWindows := WinGetList(whichApp)
    
    ; Create a mapping object for window titles to their unique IDs
    windowMap := Map()
    windowTitles := []
    
    for hwnd in applicationWindows {
        title := WinGetTitle("ahk_id " hwnd)
        if (title != "") {
            windowTitles.Push(title)
            windowMap[title] := hwnd
        }
    }
    
    ; If no application windows are open, show a brief message and return
    if (windowTitles.Length == 0) {
        MsgBox("No active Application windows found.", appTitle . " Window List", "IconI")
        return
    }

    ; Sort the titles alphabetically, case insensitive
    windowTitles.Sort("C0")
    
    ; Create the GUI ListBox
    global BringApplicationWindowToFrontGui := Gui("+OwnDialogs", "Active " . appTitle . " Windows")
    BringApplicationWindowToFrontGui.SetFont("s10", "Segoe UI")
    global BringApplicationWindowToFrontListBox := BringApplicationWindowToFrontGui.Add("ListBox", "w400 r15", windowTitles)
    
    ; Add a double-click event to the list box
    BringApplicationWindowToFrontListBox.OnEvent("DoubleClick", ActivateSelectedWindow)
    BringApplicationWindowToFrontGui.OnEvent('Escape', CloseWindow)

    ; Add a hidden button and set it as 'Default'
    ; It will trigger when Enter is pressed while the GUI is focused
    btn := BringApplicationWindowToFrontGui.Add("Button", "Default Hidden w0 h0", "OK")
    btn.OnEvent("Click", ActivateSelectedWindow)
    
    ; Show the GUI
    BringApplicationWindowToFrontGui.Show()
    
    ; Nested function to handle double-click
    ActivateSelectedWindow(*) {
        selectedTitle := BringApplicationWindowToFrontListBox.Text
        if (selectedTitle != "") {
            targetHwnd := windowMap[selectedTitle]
            if WinExist("ahk_id " targetHwnd) {
                WinActivate("ahk_id " targetHwnd)
                BringApplicationWindowToFrontGui.Destroy() ; Close the list once the window is activated
            } else {
                MsgBox("The selected window no longer exists.", "Error", "IconX")
                BringApplicationWindowToFrontGui.Destroy()
            }
        }
    }
    ; Nested function to close window
    CloseWindow(*) {
      BringApplicationWindowToFrontGui.Destroy() ; Close the list once the window is activated
    }

}
