#Requires AutoHotkey 2.0+

; Written by Thomas R. Kimpton, ahk@gooberdude.com

; I don't normally use Chrome, as Firefox has essential
; features that Chrome doesn't. So I only use Chrome for
; web pages that are problematic in Firefox.

;#include "C:\Users\Public\AutoHotkey\Lib\BringProcessPIDToFront.ahk"

RunChrome(file)
{
  ; Don't use BringProcessPIDToFront() or
  ; RunProcessInFront() as the chrome process
  ; you start spawns children processes, and
  ; quits, leaving the children to do the work.
  run "chrome.exe " file
}

RunChromeWithFiles()
{
  ; Don't use BringProcessPIDToFront() or
  ; RunProcessInFront() as the chrome process
  ; you start spawns children processes, and
  ; quits, leaving the children to do the work.
  run "chrome.exe " ExplorerGetSelection()
}

RunChromeIncognito(file)
{
  ; Don't use BringProcessPIDToFront() or
  ; RunProcessInFront() as the chrome process
  ; you start spawns children processes, and
  ; quits, leaving the children to do the work.
  run "chrome.exe --incognito " file
}

RunChromeIncognitoWithFiles()
{
  ; Don't use BringProcessPIDToFront() or
  ; RunProcessInFront() as the chrome process
  ; you start spawns children processes, and
  ; quits, leaving the children to do the work.
  run "chrome.exe --incognito " ExplorerGetSelection()
}

