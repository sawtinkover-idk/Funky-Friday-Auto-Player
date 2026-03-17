#NoEnv
#MaxThreadsPerHotkey 2
SetBatchLines, -1
SetKeyDelay, -1
SetWinDelay, -1
SetControlDelay, -1
SendMode, Input
CoordMode, Pixel, Screen

; -------- RGB COLORS PER LANE --------
aRed  := RGB(255,0,0)
aBlue := RGB(255,0,255)

sRed  := RGB(255,0,0)
sBlue := RGB(255,0,255)

dRed  := RGB(255,0,0)
dBlue := RGB(255,0,255)

fRed  := RGB(255,0,0)
fBlue := RGB(255,0,255)

toggle := false
blueReleaseDelay := 25
checkHeight := 636

aHold := false, aBlueGone := 0
sHold := false, sBlueGone := 0
dHold := false, dBlueGone := 0
fHold := false, fBlueGone := 0

Gui, +AlwaysOnTop -SysMenu
Gui, Add, Text, vStatusText w50 Center, Off
Gui, Show, x10 y10, Script Status

F1::
toggle := !toggle
GuiControl,, StatusText, % toggle ? "On" : "Off"

while (toggle)
{
    now := A_TickCount

    ; -------- A lane --------
    PixelGetColor, cA, 471, %checkHeight%, RGB Alt
    if (cA = aRed) {
        if (aHold)
            SendInput {a up}
        SendInput {a down}
        aHold := true
        aBlueGone := 0
    } else if (cA = aBlue) {
        aHold := true
        aBlueGone := 0
    } else if (aHold) {
        if (!aBlueGone)
            aBlueGone := now
        else if (now - aBlueGone >= blueReleaseDelay) {
            SendInput {a up}
            aHold := false
            aBlueGone := 0
        }
    }

    ; -------- S lane --------
    PixelGetColor, cS, 584, %checkHeight%, RGB Alt
    if (cS = sRed) {
        if (sHold)
            SendInput {s up}
        SendInput {s down}
        sHold := true
        sBlueGone := 0
    } else if (cS = sBlue) {
        sHold := true
        sBlueGone := 0
    } else if (sHold) {
        if (!sBlueGone)
            sBlueGone := now
        else if (now - sBlueGone >= blueReleaseDelay) {
            SendInput {s up}
            sHold := false
            sBlueGone := 0
        }
    }

    ; -------- D lane --------
    PixelGetColor, cD, 695, %checkHeight%, RGB Alt
    if (cD = dRed) {
        if (dHold)
            SendInput {d up}
        SendInput {d down}
        dHold := true
        dBlueGone := 0
    } else if (cD = dBlue) {
        dHold := true
        dBlueGone := 0
    } else if (dHold) {
        if (!dBlueGone)
            dBlueGone := now
        else if (now - dBlueGone >= blueReleaseDelay) {
            SendInput {d up}
            dHold := false
            dBlueGone := 0
        }
    }

    ; -------- F lane --------
    PixelGetColor, cF, 809, %checkHeight%, RGB Alt
    if (cF = fRed) {
        if (fHold)
            SendInput {f up}
        SendInput {f down}
        fHold := true
        fBlueGone := 0
    } else if (cF = fBlue) {
        fHold := true
        fBlueGone := 0
    } else if (fHold) {
        if (!fBlueGone)
            fBlueGone := now
        else if (now - fBlueGone >= blueReleaseDelay) {
            SendInput {f up}
            fHold := false
            fBlueGone := 0
        }
    }
}
return

RGB(r,g,b){
    return (r << 16) | (g << 8) | b
}

GuiClose:
ExitApp