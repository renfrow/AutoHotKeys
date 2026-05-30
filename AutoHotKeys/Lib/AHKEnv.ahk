#Requires AutoHotkey v2.0

; Written by Thomas R. Kimpton, ahk@gooberdude.com

; C:\Users\Public\ is a folder available
; to and writable by all users on a windows computer.
; You will need to create AutoHotkey\Lib\ and put
;#include "C:\Users\Public\AutoHotkey\Lib\Misc.ahk"

envFile := "C:\Users\Public\AutoHotkey\Lib\AHKEnv.json"

global AHKEnv := Map()
reloadAHKEnv()


; When you make changes to the envFile be sure
; to run this.
reloadAHKEnv()
{
  local jsonText := FileRead(envFile)
  local envObjs := jsongo.Parse(jsonText)
  For each, envObj in envObjs
  {
    if envObj.Has("key")
    {
      AHKEnv[envObj["key"]] := envObj["value"]
    }
  }
  return AHKEnv
}

getAHKEnvValue(key, defaultValue := "")
{
  if AHKEnv.Count > 0
    if AHKEnv.has(key)
      return AHKEnv[key]
  return defaultValue
}

