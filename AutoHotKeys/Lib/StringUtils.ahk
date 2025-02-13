#Requires AutoHotkey v2.0

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

