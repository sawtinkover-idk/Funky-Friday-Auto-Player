#NoEnv
#MaxThreadsPerHotkey 2
SetBatchLines, -1
SetKeyDelay, -1
SetWinDelay, -1
SetControlDelay, -1
SendMode, Input
CoordMode, Pixel, Screen

; =========================================================
; =================== CONFIG SECTION =======================
; =========================================================

; ---- KEYS (what gets pressed for each lane) ----
left     := "a"   ; left lane key
midleft  := "s"   ; mid-left lane key
midright := "d"   ; mid-right lane key
right    := "f"   ; right lane key

; ---- COLORS (RGB format) ----
; Block = tap note color
; Line  = hold note color
Block1 := RGB(255,0,0)
Line1  := RGB(255,0,255)

Block2 := RGB(255,0,0)
Line2  := RGB(255,0,255)

Block3 := RGB(255,0,0)
Line3  := RGB(255,0,255)

Block4 := RGB(255,0,0)
Line4  := RGB(255,0,255)

; ---- SCREEN POSITIONS ----
; X positions for each lane (left → right)
x1 := 471
x2 := 584
x3 := 695
x4 := 809

; Y position where notes are detected
checkHeight := 636

; ---- TIMING ----
; Delay (ms) after line disappears before releasing key
lineReleaseDelay := 25

; =========================================================
; ================= END CONFIG =============================
; =========================================================

toggle := false

leftHold := false, leftLineGone := 0
midleftHold := false, midleftLineGone := 0
midrightHold := false, midrightLineGone := 0
rightHold := false, rightLineGone := 0

Gui, +AlwaysOnTop -SysMenu
Gui, Add, Text, vStatusText w50 Center, Off
Gui, Show, x10 y10, Script Status

F1::
toggle := !toggle
GuiControl,, StatusText, % toggle ? "On" : "Off"

while (toggle)
{
    now := A_TickCount

    ; -------- LEFT lane --------
    PixelGetColor, c1, %x1%, %checkHeight%, RGB Alt
    if (c1 = Block1) {
        if (leftHold)
            SendInput {%left% up}
        SendInput {%left% down}
        leftHold := true
        leftLineGone := 0
    } else if (c1 = Line1) {
        leftHold := true
        leftLineGone := 0
    } else if (leftHold) {
        if (!leftLineGone)
            leftLineGone := now
        else if (now - leftLineGone >= lineReleaseDelay) {
            SendInput {%left% up}
            leftHold := false
            leftLineGone := 0
        }
    }

    ; -------- MIDLEFT lane --------
    PixelGetColor, c2, %x2%, %checkHeight%, RGB Alt
    if (c2 = Block2) {
        if (midleftHold)
            SendInput {%midleft% up}
        SendInput {%midleft% down}
        midleftHold := true
        midleftLineGone := 0
    } else if (c2 = Line2) {
        midleftHold := true
        midleftLineGone := 0
    } else if (midleftHold) {
        if (!midleftLineGone)
            midleftLineGone := now
        else if (now - midleftLineGone >= lineReleaseDelay) {
            SendInput {%midleft% up}
            midleftHold := false
            midleftLineGone := 0
        }
    }

    ; -------- MIDRIGHT lane --------
    PixelGetColor, c3, %x3%, %checkHeight%, RGB Alt
    if (c3 = Block3) {
        if (midrightHold)
            SendInput {%midright% up}
        SendInput {%midright% down}
        midrightHold := true
        midrightLineGone := 0
    } else if (c3 = Line3) {
        midrightHold := true
        midrightLineGone := 0
    } else if (midrightHold) {
        if (!midrightLineGone)
            midrightLineGone := now
        else if (now - midrightLineGone >= lineReleaseDelay) {
            SendInput {%midright% up}
            midrightHold := false
            midrightLineGone := 0
        }
    }

    ; -------- RIGHT lane --------
    PixelGetColor, c4, %x4%, %checkHeight%, RGB Alt
    if (c4 = Block4) {
        if (rightHold)
            SendInput {%right% up}
        SendInput {%right% down}
        rightHold := true
        rightLineGone := 0
    } else if (c4 = Line4) {
        rightHold := true
        rightLineGone := 0
    } else if (rightHold) {
        if (!rightLineGone)
            rightLineGone := now
        else if (now - rightLineGone >= lineReleaseDelay) {
            SendInput {%right% up}
            rightHold := false
            rightLineGone := 0
        }
    }
}
return

RGB(r,g,b){
    return (r << 16) | (g << 8) | b
}

GuiClose:
ExitApp
