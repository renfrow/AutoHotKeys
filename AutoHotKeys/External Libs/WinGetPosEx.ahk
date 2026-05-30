#Requires autohotkey v2.0

; Get window position without the invisible border.
WinGetPosEx(&X?, &Y?, &W?, &H?, hwnd?) {
    static DWMWA_EXTENDED_FRAME_BOUNDS := 9
    if !IsSet(hwnd)
        hwnd := WinExist() ; last found window
    if !(hwnd is integer)
        hwnd := WinExist(hwnd)
    DllCall("dwmapi\DwmGetWindowAttribute"
            , "ptr" , hwnd
            , "uint", DWMWA_EXTENDED_FRAME_BOUNDS
            , "ptr" , RECT := Buffer(16, 0)
            , "uint", RECT.size
            , "uint")
    ; X coord top left
    X := NumGet(RECT, 0, "int")
    ; Y coord top left
    Y := NumGet(RECT, 4, "int")
    ; X coord bottom right, so minus X returns width
    W := NumGet(RECT, 8, "int") - X
    ; Y coord bottom right, so minus Y returns height
    H := NumGet(RECT, 12, "int") - Y
}
