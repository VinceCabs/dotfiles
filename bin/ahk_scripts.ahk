﻿#Requires AutoHotkey v1.1
#SingleInstance Force
; #InstallKeybdHook

; This AutoHotkey script is to Open, Restore or Minimize the desires Apps using the configured shortcuts key (hotkeys) you want.
; There are three functions you can use for this: 
;
;
; a) OpenOrShowAppBasedOnExeName(AppAddress) //Useful for regular Window Apps

; b) OpenOrShowAppBasedOnWindowTitle(WindowTitleWord, AppAddress)  //Specially useful for Chrome Apps and Chrome Shortcuts 

; c) OpenOrShowAppBasedOnAppModelUserID(AppTitle, AppModelUserID) //Useful for Windows Store Apps (contained in the "shell:AppsFolder\")

; Additionally, pressing Alt + ` (key above Tab key) you can switch between open Windows of the same "type" and same App (.exe)
; The "type" checking is based on the App's Title convention that stipulates that the App name should be at the end of the Window title (Eg: New Document - Word )

/* ;
*****************************
***** UTILITY FUNCTIONS *****
*****************************
*/

#WinActivateForce ; Prevent task bar buttons from flashing when different windows are activated quickly one after the other.

; AppAddress: The address to the .exe (Eg: "C:\Windows\System32\SnippingTool.exe")

OpenOrShowAppBasedOnExeName(AppAddress)
{

    AppExeName := SubStr(AppAddress, InStr(AppAddress, "\", false, -1) + 1)

    IfWinExist ahk_exe %AppExeName%
    {

        IfWinActive
        {
            WinMinimize
            Return
        }
        else
        {
            WinActivate
            Return
        }

    }
    else
    {	

        Run, %AppAddress%, UseErrorLevel
        If ErrorLevel
        {
            Msgbox, File %AppAddress% Not Found
            Return
        }
        else
        {
            WinWait, ahk_exe %AppExeName%
            WinActivate ahk_exe %AppExeName%			
            Return
        }			

    }
}

; WindowTitleWord: Usually the word at the end of the app window title (Eg: in: "New Document - Word" will be "Word")
; AppAddress: The address to the .exe (Eg: "C:\Windows\System32\SnippingTool.exe")

OpenOrShowAppBasedOnWindowTitle(WindowTitleWord, AppAddress)
{

    SetTitleMatchMode, 2

    IfWinExist, %WindowTitleWord%
    { 

        IfWinActive
        {
            WinMinimize
            Return
        }
        else
        {
            WinActivate
            Return
        }

    }
    else
    {
        Run, %AppAddress%, UseErrorLevel
        If ErrorLevel
        {
            Msgbox, File %AppAddress% Not Found
            Return
        }
        else
        {
            WinActivate
            Return
        }
    }
}

; AppTitle: Usually the word at the end of the app window title(Eg: in: "New Document - Word" will be "Word")
; AppModelUserID: A comprehensive guide on how to find the AppModelUserID of a windows store app can be found here: https://jcutrer.com/windows/find-aumid

OpenOrShowAppBasedOnAppModelUserID(AppTitle, AppModelUserID)
{

    SetTitleMatchMode, 2

    IfWinExist, %AppTitle%
    { 

        IfWinActive
        {
            WinMinimize
            Return
        }
        else
        {
            WinActivateBottom %AppTitle%
        }

    }
    else
    {

        Run, shell:AppsFolder\%AppModelUserID%, UseErrorLevel
        If ErrorLevel
        {
            Msgbox, File %AppModelUserID% Not Found
            Return
        }

    }
}

ExtractAppTitle(FullTitle)
{
    AppTitle := SubStr(FullTitle, InStr(FullTitle, " ", false, -1) + 1)
    Return AppTitle
}

/* ;
***********************************
***** SHORTCUTS CONFIGURATION *****
***********************************
*/

Capslock & e:: OpenOrShowAppBasedOnWindowTitle("Boîte de réception", "Outlook")
Capslock & r:: OpenOrShowAppBasedOnWindowTitle("Calendrier", "Outlook:calendar")
Capslock & c:: 
Capslock & t::
    OpenOrShowAppBasedOnWindowTitle("Chrome", "Chrome")
    return
; TODO variabilize AppData folder

Capslock & d:: OpenOrShowAppBasedOnAppModelUserID("Horloge","Microsoft.WindowsAlarms_8wekyb3d8bbwe!App" )
Capslock & f:: OpenOrShowAppBasedOnWindowTitle("Spotify", "C:\Users\MD1116\AppData\Roaming\Spotify\Spotify.exe")
Capslock & g:: OpenOrShowAppBasedOnWindowTitle("Microsoft Teams", "C:\Users\MD1116\AppData\Local\Microsoft\Teams\Update.exe --processStart 'Teams.exe' --process-start-args '--profile=AAD'")
Capslock & x:: OpenOrShowAppBasedOnWindowTitle("Explorateur", "C:\Windows\explorer.exe")
Capslock & v:: OpenOrShowAppBasedOnWindowTitle("Visual Studio Code", "C:\Users\MD1116\AppData\Local\Programs\Microsoft VS Code\Code.exe")

CapsLock & h:: MsgBox, 
    ( Join LTrim C
        <E> Boîte de réception `t <R> Calendrier `t <T> Chrome`n
        <D> Timer `t`t <F> Spotify `t <G> Microsoft Teams`n
        <X> Explorer `t`t <C> Chrome `t <V> VS Code`n
        <H> Help`n
    )

; Not working:
; SC163 & r:: OpenOrShowAppBasedOnWindowTitle("Calendrier", "Outlook:calendar")
; Capslock & t:: OpenOrShowAppBasedOnWindowTitle("Trello", "C:\Program Files (x86)\Google\Chrome\Application\chrome_proxy.exe  --profile-directory=Default --app-id=clpmljpjfechfakfehipmcophoepgjnj")
; Capslock & t:: OpenOrShowAppBasedOnWindowTitle("Trello", "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe --app=https://trello.com/b/VJY63DDa/todo-pro")
; Capslock & t:: OpenOrShowAppBasedOnWindowTitle("Trello", "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe https://trello.com/b/VJY63DDa/todo-pro")
; spotPath := %A_AppData% "\Spotify\Spotify.exe"
; Capslock & s::
; {
;     spotPath := %A_AppData% "\Spotify\Spotify.exe" ; KO
;     spotPath := %A_AppData%/Spotify/Spotify.exe ; KO
;     MsgBox, %spotPath%
;     OpenOrShowAppBasedOnWindowTitle("Spotify", %spotPath%) ; KO
;     run, %A_AppData%\Spotify\Spotify.exe ; OK
;     MsgBox, %A_AppData%\Spotify\Spotify.exe ; OK
; }

; Debug : 
; MsgBox, Pouet

; ; F7 - Open||Show "SnippingTool"
; F7:: OpenOrShowAppBasedOnExeName("C:\Windows\System32\SnippingTool.exe")

; ; F8 - Open||Show "Gmail as Chrome App"
; F8:: OpenOrShowAppBasedOnWindowTitle("Gmail", "C:\Program Files\Google\Chrome\Application\chrome.exe --app=https://mail.google.com/mail/")
; /*
;  Use this if you have your chrome in the "Program Files (x86)" folder
;  F8:: OpenOrShowAppBasedOnWindowTitle("Gmail", "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe --app=https://mail.google.com/mail/")
;  */

; ; F9 - Open||Show "Windows store Calculator app"
; F9:: OpenOrShowAppBasedOnAppModelUserID("Calculator", "Microsoft.WindowsCalculator_8wekyb3d8bbwe!App")

; Capslock & o::  ; Win+o
; {
;     if WinExist("Boîte de réception")
;         WinActivate
;     else
;         Run "Outlook"
; }

; Alt + ` -  Activate NEXT Window of same type (title checking) of the current APP
!`::
    WinGet, ActiveProcess, ProcessName, A
    WinGet, OpenWindowsAmount, Count, ahk_exe %ActiveProcess%

    If OpenWindowsAmount = 1 ; If only one Window exist, do nothing
        Return

    Else
    {
        WinGetTitle, FullTitle, A
        AppTitle := ExtractAppTitle(FullTitle)

        SetTitleMatchMode, 2
        WinGet, WindowsWithSameTitleList, List, %AppTitle%

        If WindowsWithSameTitleList > 1 ; If several Window of same type (title checking) exist
        {
            WinActivate, % "ahk_id " WindowsWithSameTitleList%WindowsWithSameTitleList%	; Activate next Window
        }
    }
Return

