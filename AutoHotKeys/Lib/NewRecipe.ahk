#Requires AutoHotkey v2.0

; Written by Thomas R. Kimpton, ahk@gooberdude.com

NewRecipeDirectory := "Z:\public_html\Hobbies\Cooking\"

; I do it this way because I have a macro(cpr), on my Linux
; server, that creates a new recipe from a recipe template
; file, and rebuilds a web page that contains links to all
; the recipes. I COULD do it all Windows side, but, I don't
; want to spend the time to rewrite the web page rebuild code.
NewRecipe()
{
  recipeName := ""
  recipeFileName := ""
  IB := InputBox("New Recipe Name", "Enter the name of the Recipe", "h100")
  if IB.Result != "Cancel"
  {
    PWB := InputBox("Password", "Password:", "password h100")
    if PWB.Result != "Cancel"
    {
      recipeName := IB.Value
      recipeFileName := camelize(recipeName)
      RunLoadDefaultPuttySession()
      Sleep 500
      Send PWB.Value
      Send "{Enter}"
      Sleep 1000
      ; cdc is an alias to change directories to the Cooking directory.
      Send "cdc{Enter}"
      Sleep 100
      fileVal := ' `"' . recipeFileName . '`"'
      ; cpr is an alias to copy the recipe template file to the new file.
      Send "cpr " fileVal "{Enter}"
      Sleep 100
      ; x is an alias for logout
      Send "x{Enter}"
      Sleep 1000
      fileVal := ' `"' . NewRecipeDirectory . recipeFileName . ".html" . '`"'
      Run editor fileVal
    }
  }
}

