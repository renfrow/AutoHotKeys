#Requires AutoHotkey v2.0
#SingleInstance Force

; Written by Thomas R. Kimpton, ahk@gooberdude.com

; Written with the help of AI.

; StudentComments.ahk - AutoHotkey v2
; Reads students.json and comments.json, builds a GUI with a menu
; built from students.json, and buttons built from comments.json.
; Selecting a button pastes the comment into the active window.
; Selecting a new name from the menu rebuilds the buttons.

#include "C:\Users\Public\AutoHotkey\Lib\jsongo.v2.ahk"
#include "C:\Users\Public\AutoHotkey\Lib\jsonUtils.ahk"
#include "C:\Users\Public\AutoHotkey\Lib\StringUtils.ahk"

; ─── Config ───────────────────────────────────────────────────────────────────
studentFile    := "C:\Users\Public\AutoHotkey\Lib\students.json"
commentFile    := "C:\Users\Public\AutoHotkey\Lib\comments.json"
prefFile       := "C:\Users\Public\AutoHotkey\Lib\last_student.txt"

placeHolder    := "-=#@STUDENTNAME@#=-"
studentNameKey := "name"
commentKey     := "comment"


; ─── Load data ────────────────────────────────────────────────────────────────
studentObjArray := parseJsonArray(studentFile)
; Only use objects with studentNameKeys
studentObjArray := extractKeyObjs(studentObjArray , studentNameKey)

commentObjArray := parseJsonArray(commentFile)
; Only use objects with commentKeys
commentObjArray := extractKeyObjs(commentObjArray , commentKey)

if studentObjArray.Length = 0
  MsgBox "No students found in " studentFile, "Warning", "Icon!"
if commentObjArray.Length = 0
  MsgBox "No comments found in " commentFile, "Warning", "Icon!"

; ─── Restore last selection ───────────────────────────────────────────────────
lastStudent := ""
if FileExist(prefFile)
  lastStudent := Trim(FileRead(prefFile, "UTF-8"))

; ─── GUI globals ──────────────────────────────────────────────────────────────
global myGui, menuStudents, commentButtons, studentObjArray, commentObjArray
global lastStudent, placeHolder, prefFile
commentButtons := []

; ─── Build GUI ────────────────────────────────────────────────────────────────

BuildGui()
{
  global myGui, menuStudents, commentButtons

  myGui := Gui("+AlwaysOnTop", "Student Comment Tool")
  myGui.SetFont("s10", "Segoe UI")
  myGui.BackColor := "F0F4FF"
  myGui.OnEvent("Close", CloseStudentCommentWindow)
  myGui.OnEvent("Escape", CloseStudentCommentWindow)

  ; ── Student dropdown ──────────────────────────────────────────────────────
  myGui.Add("Text", "x12 y12 w120", "Select Student:")

  ; Build the list for the DropDownList
  ; First item is the default placeHolder
  menuItems := ["No student selected"]
  for obj in studentObjArray
  {
    menuItems.Push(obj[studentNameKey])
  }

  ; Determine which item to pre-select
  chosenIndex := 1  ; default = placeHolder
  if lastStudent != ""
  {
    for i, obj in studentObjArray
    {
      if obj[studentNameKey] = lastStudent
      {
        chosenIndex := i + 1  ; +1 because placeHolder is index 1
        break
      }
    }
  }

  menuStudents := myGui.Add("DropDownList", "x140 y10 w220 Choose" chosenIndex, menuItems)
  menuStudents.OnEvent("Change", OnStudentChange)

  myGui.Add("Text", "Center x12 y45 w360", "─────────────────────────────────────────")

  BuildCommentButtons()

  myGui.Show("AutoSize")
}

; If rebuildGui = 1, reuse the current buttons. AutoHotKey has
; no facility for destroying buttons, only hiding them, so, in
; the interest of not leaking button memory we reuse what we've
; already got.
BuildCommentButtons(rebuildGui := 0)
{
  global myGui, menuStudents, commentButtons, commentObjArray, studentObjArray
  global placeHolder

  ; Determine selected student name
  selectedIndex := menuStudents.Value   ; 1-based; 1 = placeHolder
  if selectedIndex <= 1
    studentName := "No student selected"
  else
    studentName := studentObjArray[selectedIndex - 1][studentNameKey]

  ; Add comment buttons
  yPos := 65
  whichBtn := 1
  for i, obj in commentObjArray
  {
    commentText := StrReplace(obj[commentKey], placeHolder, studentName)
    ; Truncate the button title if very long, but store full comment in fullComment
    buttonTitle := ShortenString(commentText, 80)
    if(rebuildGui = 1)
    {
      btn := commentButtons[whichBtn]
      btn.Text := buttonTitle
    }
    else
    {
      btn := myGui.Add("Button", "x12 y" yPos " w360 h36", buttonTitle)
      commentButtons.InsertAt(whichBtn, btn) 
    }
    btn.fullComment := commentText
    btn.OnEvent("Click", PasteComment)
    whichBtn += 1
    yPos += 42
  }

  ; ── Cancel button ─────────────────────────────────────────────────────────
  cancelBtn := myGui.Add("Button", "x112 y" yPos " w160 h36", "Cancel")
  cancelBtn.OnEvent("Click", CloseStudentCommentWindow)
  commentButtons.Push(cancelBtn)

  ; Resize GUI to fit new buttons
  if myGui.Hwnd
      myGui.Show("AutoSize")
}

PasteComment(ctrlObj, *)
{
  global myGui

  myGui.Hide()

  ; Send text to previously active window
  A_Clipboard := ctrlObj.fullComment
  Sleep 100
  Send "^v"

  myGui.Destroy()
}

; ─── Student dropdown change handler ─────────────────────────────────────────
OnStudentChange(ctrlObj, *)
{
  global lastStudent, menuStudents, studentObjArray, prefFile
  selectedIndex := menuStudents.Value
  if selectedIndex > 1
  {
    lastStudent := studentObjArray[selectedIndex-1][studentNameKey]
    try FileDelete(prefFile)
    FileAppend(lastStudent, prefFile, "UTF-8")
  }
  else
  {
    lastStudent := 0
    try FileDelete(prefFile)
  }
  BuildCommentButtons(rebuildGui := 1)
}

CloseStudentCommentWindow(*)
{
  myGui.Destroy()
}

; Replace 'F1' with whatever key you want to use,
; prepending '+' for shift, '^' for control, '!' for
; alt, and '#' for win. Thus '+#PgDn' will activate
; with shift-win-PgDn. The modifiers may be in
; any order. Use the following for the key names:
; https://www.autohotkey.com/docs/v2/KeyList.htm
F1::BuildGui()
