#Requires AutoHotkey v2.0

; From https://www.autohotkey.com/boards/viewtopic.php?p=509080

ExplorerSelectedItem(activewindow := True)
{
 filepaths := ExplorerSelectedItems(activewindow)
 return filepaths.has(1) ? filepaths[1] : ""
}

ExplorerSelectedItems(activewindow := True)
{
  ; Based on mikeyww - https://www.autohotkey.com/boards/viewtopic.php?p=509165#p509165
  filepaths := []
  WinExistOrActive := (activewindow) ? WinActive : WinExist 
  if (hwnd := WinExistOrActive("ahk_class ExploreWClass"))
    or (hwnd := WinExistOrActive("ahk_class CabinetWClass"))
  {
    window := ExplorerTab(hwnd)
    for item in window.Document.SelectedItems
      filepaths.push(item.Path)
  }
  if WinActive("ahk_class WorkerW") || WinActive("ahk_class Progman")
  {
    try hwnd := ControlGetHwnd("SysListView321", "ahk_class Progman")
    hwnd := hwnd || ControlGetHwnd('SysListView321', "A")
    Loop Parse ListViewGetContent("Selected Col1", hwnd), "`n", "`r"
      filepaths.push(A_Desktop "\" A_LoopField)
  }
  return filepaths ; Returned array could be empty with zero length
}

; This returns the selection(s) from the front Explorer
; window as a string, each selection surrounded by double
; quotes, suitable for passing to a program on a command
; line.
ExplorerGetSelection()
{
  result := ""
  for item in ExplorerGetSelectedItems()
  {
    fileVal := '`"' . item.Path . '`"'
    result .= " " . fileVal
  }
  Return result
}

; This returns an array of full paths for each item
; selected in the Explorer window.
ExplorerGetSelectedItems(activewindow := True)
{
  result := []
  WinExistOrActive := (activewindow) ? WinActive : WinExist 
  if (hwnd := WinExistOrActive("ahk_class ExploreWClass"))
  or (hwnd := WinExistOrActive("ahk_class CabinetWClass")) {
    window := ExplorerTab(hwnd)
    for item in window.Document.SelectedItems
      result.push(item)
  }
  Return result
}

; This returns the directory of the front window in
; Explorer.
Explorer(activewindow := True) {
   WinExistOrActive := (activewindow) ? WinActive : WinExist 
   if (hwnd := WinExistOrActive("ahk_class ExploreWClass"))
   or (hwnd := WinExistOrActive("ahk_class CabinetWClass")) {
      window := ExplorerTab(hwnd)
      directory := Type(window.Document) == "ShellFolderView"
         ? window.Document.Folder.Self.Path
         : window.LocationURL             ; "HTMLDocument"
   }
   if WinActive("ahk_class WorkerW") || WinActive("ahk_class Progman")
      directory := A_Desktop
   return directory ?? "" ; Returns the empty string if the directory is not found
}

ExplorerTab(hwnd) {
   ; Thanks Lexikos - https://www.autohotkey.com/boards/viewtopic.php?f=83&t=109907
   try activeTab := ControlGetHwnd("ShellTabWindowClass1", hwnd) ; File Explorer (Windows 11)
   catch
   try activeTab := ControlGetHwnd("TabWindowClass1", hwnd) ; IE
   for window in ComObject("Shell.Application").Windows {
      if (window.hwnd != hwnd)
         continue
      if activeTab { ; The window has tabs, so make sure this is the right one.
         static IID_IShellBrowser := "{000214E2-0000-0000-C000-000000000046}"
         IShellBrowser := ComObjQuery(window, IID_IShellBrowser, IID_IShellBrowser)
         ComCall(GetWindow := 3, IShellBrowser, "uint*", &thisTab := 0)
         if (thisTab != activeTab)
            continue
      }
      return window ; Returns a ComObject with a .hwnd property
   }
   throw Error("Could not locate active tab in Explorer window.`n<em>NOTE</em>: if you get this for a remote volume try reopening the folder.")
}
