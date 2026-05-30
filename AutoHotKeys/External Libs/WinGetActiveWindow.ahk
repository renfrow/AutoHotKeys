#Requires autohotkey v2.0

; Get window position without the invisible border.
WinGetActiveWindow() {
    hwnd := "A"
    if !IsSet(hwnd)
        hwnd := WinExist() ; last found window
    if !(hwnd is integer)
        hwnd := WinExist(hwnd)
    return hwnd
}
