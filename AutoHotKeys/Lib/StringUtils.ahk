#Requires AutoHotkey v2.0

; Written by Thomas R. Kimpton, ahk@gooberdude.com
; except as noted.

; Turn 'my first personal bicycle' to
; 'MyFirstPersonalBicycle'
camelize(inputString)
{
  outputString := ""
  ; Set hadSpace to true so we capitalize the
  ; first letter.
  hadSpace := true
  Loop parse inputString
  {
    if A_LoopField == " "
    {
      hadSpace := true
    }
    else
    {
      if hadSpace
        outputString .= StrUpper(A_LoopField)
      else
        outputString .= A_LoopField
      hadSpace := false
    }
  }
  return outputString
}

splitOnLastDelimiter(inputString, delimiter, &part1, &part2)
{
  ; Find the position of the last delimiter, searching from the right
  ; The -1 indicates the search should start from the end of the string.
  lastDelimeterPos := InStr(inputString, delimiter, false, 0, -1)

  if lastDelimeterPos
  {
    ; Extract the part before the last Delimeter
    part1 := SubStr(inputString, 1, lastDelimeterPos - 1)
    ; Extract the part after the last Delimeter
    part2 := SubStr(inputString, lastDelimeterPos + 1)

    return true
  }
  else
  {
    return false
  }
}


; Thanks to 'just me'
; https://www.autohotkey.com/boards/viewtopic.php?t=84825#p372262

; See https://en.wikipedia.org/wiki/Percent-encoding for
; what characters will be encoded.

; An URL encoded string will have all have special characters
; replaced by a '%' and the two hex char equivalent to the
; special character:
;    original: http://example.com/my file.txt
;    encoded: http://example.com/my%20file.txt

URIEncode(Url, Flags := 0x000C3000) {
	Local CC := 4096, Esc := "", Result := ""
	Loop
		VarSetStrCapacity(&Esc, CC), Result := DllCall("Shlwapi.dll\UrlEscapeW", "Str", Url, "Str", &Esc, "UIntP", &CC, "UInt", Flags, "UInt")
	Until Result != 0x80004003 ; E_POINTER
	Return Esc
}

; Change %xx triplets back to their original characters
;    encoded: http://example.com/my%2Dfirst%20file.txt
;    unescaped: http://example.com/my-first file.txt
UrlUnescape(Url, Flags := 0x00140000) {
   Return !DllCall("Shlwapi.dll\UrlUnescape", "Ptr", StrPtr(Url), "Ptr", 0, "UInt", 0, "UInt", Flags, "UInt") ? Url : ""
}


; Many string shorteners lop of from the end, replacing
; the deletion with '...'. I find that deleting from
; the middle of the string retains the maximum information.
ShortenString(text, maxLength := 80)
{
  if (StrLen(text) <= maxLength)
    return text
  
  tmpLength := maxLength - 3
  ; Total length must be maxLength including "..." (3 chars)
  leftSide := tmpLength/2
  rightSide := tmpLength/2
  ; if maxLength was odd, increment the leftSide
  if ((leftSide+rightSide) < maxLength)
    leftSide := leftSide + 1
  
  return SubStr(text, 1, leftSide) "..." SubStr(text, -rightSide)
}
