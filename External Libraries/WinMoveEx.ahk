#Requires autohotkey v2.0

; Move window and fix offset from invisible border.
WinMoveEx(X?, Y?, W?, H?, hwnd?) {
    if !(hwnd is integer)
        hwnd := WinExist(hwnd)
    if !IsSet(hwnd)
        hwnd := WinExist()
    ; compare pos and get offset
    WinGetPosEx(&fX, &fY, &fW, &fH, hwnd)
    WinGetPos(&wX, &wY, &wW, &wH, hwnd)
    xDiff := fX - wX
    hDiff := wH - fH
    pixel := 1
    ; new X, Y, W, H with offset corrected.
    IsSet(X) && nX := X - xDiff - pixel
    IsSet(Y) && nY := Y - pixel
    IsSet(W) && nW := W + (xDiff + pixel) * 2
    IsSet(H) && nH := H + hDiff + (pixel * 2)
    WinMove(nX?, nY?, nW?, nH?, hwnd?)
}
