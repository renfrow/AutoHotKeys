#Requires AutoHotkey v2.0.11+

; Written by Thomas R. Kimpton, ahk@gooberdude.com

; Example:
;    output := GetCmdStringOutput("dir")
;    MsgBox(output)
GetCmdStringOutput(command)
{
  ; Create a unique temp file path
  tempFile := A_Temp "\GetCmdStringOutput_" A_TickCount ".tmp"
  ; Piping to iconv converts from UTF-16LE to UTF-8.
  ; You MUST have iconv on your system, as Windows
  ; commands use UTF-16LE to output text!!! AutoHotKey
  ; does not play well with UTF-16LE (that I currently
  ; know of :).
  commandValue := A_ComSpec . " /c " . command . " | iconv -f UTF-16LE -t UTF-8 >" . tempFile
  ; "Hide" so the command doesn't popup a window.
  RunWait(commandValue,, "Hide")
  result := FileRead(tempFile)
  FileDelete(tempFile)
  return result
}

