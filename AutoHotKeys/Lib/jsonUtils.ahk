#Requires AutoHotkey v2.0

; Written by Thomas R. Kimpton, ahk@gooberdude.com

;#include "C:\Users\Public\AutoHotkey\Lib\jsongo.v2..ahk"

; Returns an array of json objects from a JSON file.
parseJsonArray(filePath)
{
  if !FileExist(filePath)
    throw Error("File not found: " filePath)

  result := []

  jsonText := FileRead(filePath)
  result := jsongo.Parse(jsonText)
  return result
}

; Return an Array containing all the json objects
; that contain myKey.
extractKeyObjs(jsonObjs, myKey, defaultObj := 0)
{
  returnArray := Array()
  For each, jsonObj in jsonObjs
  {
    if jsonObj.Has(myKey)
    {
      returnArray.Push(jsonObj)
      if defaultObj and jsonObj.Has("default")
      {
        defaultObj := jsonObj
      }
    }
  }
  return returnArray
}

