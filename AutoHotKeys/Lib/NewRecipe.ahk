#Requires AutoHotkey v2.0

; This hotkey is ONLY active if the active
; window is a File Explorer window.
#HotIf WinActive('ahk_class CabinetWClass')
NewRecipeDirectory := "Z:\public_html\Hobbies\Cooking\"

NewRecipe()
{
  recipeName := ""
  recipeFileName := ""
  IB := InputBox("New Recipe Name", "Enter the name of the Recipe", "h100")
  if IB.Result != "Cancel"
  {
    recipeName := IB.Value
    recipeFileName := camelize(recipeName)
    createRecipeFile(NewRecipeDirectory recipeFileName ".html")
    fileVal := ' `"' . NewRecipeDirectory . recipeFileName . ".html" . '`"'
    Run editor fileVal
  }
}

createRecipeFile(fileName)
{
  if !FileExist(fileName)
    FileCopy("Z:\public_html\Hobbies\Cooking\@recipeTemplate.html", fileName)
  else
    MsgBox fileName " already exists!"
}

; Turn to 'MyFirstPersonalBicycle'
;  'My First Personal Bicycle'
makeNewRecipeTitle(inputString)
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
#HotIf
