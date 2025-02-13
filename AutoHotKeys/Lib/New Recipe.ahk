#Requires AutoHotkey v2.0

; This hotkey is ONLY active if the active
; window is a File Explorer window.
#HotIf WinActive('ahk_class CabinetWClass')

^!+N::
{
  cookingDirectory := "Z:\public_html\Hobbies\Cooking\"
  recipeName := ""
  recipeFileName := ""
  IB := InputBox("New Recipe Name", "Enter the name of the Recipe", "h100")
  if IB.Result != "Cancel"
  {
    recipeName := IB.Value
    recipeFileName := camelize(recipeName)
    createRecipeFile(cookingDirectory recipeFileName ".html")
    fileVal := ' `"' . cookingDirectory . recipeFileName . ".html" . '`"'
    Run "C:\Program Files\Vim\vim91\gvim.exe" fileVal
  }
}
Return

createRecipeFile(fileName)
{
  if !FileExist(fileName)
    FileCopy("Z:\public_html\Hobbies\Cooking\@recipeTemplate.html", fileName)
  else
    MsgBox fileName " already exists!"
}

; Turn to 'MyFirstPersonalBicycle'
;  'My first personal bicycle'
makeTitle(inputString)
{
  outputString := ""
  firstChar := true
  Loop parse inputString
  {
    if !firstChar
    {
      if IsUpper(A_LoopField)
        outputString .= " "
    }
    outputString .= A_LoopField
    firstChar := false
  }
  return outputString
}

; Turn 'my first personal bicycle' to
; 'MyFirstPersonalBicycle'
camelize(inputString)
{
  outputString := ""
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

#HotIf
