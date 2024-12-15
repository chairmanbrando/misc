#NoEnv
#SingleInstance force

SendMode Input
SetWorkingDir %A_ScriptDir%

Menu, Tray, Icon, C:\Windows\System32\imageres.dll, 188
Menu Tray, Tip, Windows Betterer

; ----- @todos --------------------------------------------------------------- ;

; This, with another library, allows for moving a window to a different desktop
; with a key combo. With some research, it should also work for switching focus
; to a specific desktop where you're currently required to scroll through each
; one to do so. See: https://superuser.com/a/1701856

; I need the same auto-clicking with CapsLock but with RMB. I can't do it by
; modifying it directly, but maybe I could do it by also holding an unrelated
; key? Maybe changing PgUp and PgDn to LMB and RMB respectively is the call --
; while leaving CapsLock for LMB too since it's well positioned.

; ----- @functions ----------------------------------------------------------- ;

Min(X, Y) {
    return X < Y ? X : Y
}

Max(X, Y) {
    return X > Y ? X : Y
}

; Sleep for a random amount of time between Min and Max.
SleepRand(Min, Max) {
    Random, Sleep, Min, Max
    Sleep, %Sleep%
}

; ----- @macros -------------------------------------------------------------- ;

; Adds Mac-style window switching: swap between windows of the same application.
; They have to be not-minimized, though, so keep that in mind if you habitually
; minimize anything you're not using at the moment.
!`::
    WinGet, ActiveExe, ProcessName, A
    WinGet, WinCount, Count, ahk_exe %ActiveExe%

    If (WinCount = 1) {
        Return
    }

    WinGet, WinList, List, % "ahk_exe " ActiveExe

    Loop, % WinList
    {
        index := WinList - A_Index + 1
        WinGet, WinState, MinMax, % "ahk_id " WinList%index%

        If (WinState <> -1) {
            WinID := WinList%index%
            Break
        }
    }

    WinActivate, % "ahk_id " WinID
Return

; Windows needs a Spotlight. This isn't great, but it works most of the time.
!Space::
    Send #s
Return

; Launch the calculator since you can't even do simple math in the start menu
; anymore without having everything you type therein sent off to Bing. Even if
; you didn't care about the privacy implications, it's just slower and returns
; bullshit search results first/alongside.
#c::Run calc.exe

; There are occasions, however rare, where you can't paste what's in your clip-
; board. But what you *can* do is replay those characters instead.
!v::
    SendInput, %Clipboard%
Return

; Windows key + Down *usually* minimizes windows but some skirt through. This
; makes every window listen.
#Down::
    WinMinimize, A
Return

; Alias CapsLock to LMB. Clicking is hard on the hands. This key less so. Note
; that if any other scripts are going to modify CapsLock's functionality, they
; need to be launched after this one.
CapsLock::LButton

; Make Insert do CapsLock instead. I have never used this key on purpose, and
; hitting it accidentally is annoying. Since we're using CapsLock for LMB, why
; not turn Insert into CapsLock?
Insert::
    SetCapsLockState % !GetKeyState("CapsLock", "T")
Return
