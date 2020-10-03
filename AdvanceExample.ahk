if not A_IsAdmin{
    Run *RunAs "%A_ScriptFullPath%"
    ExitApp
}
#Warn
#UseHook
#NoEnv
#SingleInstance force
#include %A_ScriptDir%\SAMP.ahk
SendMode Input 
SetWorkingDir %A_ScriptDir%
Gui, Show , w190 h100, UnityRP Commands Helper
Gui, Add, Text, Center, UnityRP Commands Helper
Gui, Add, Text, Center, Check the script for macro info
Gui, Add, Button, default, EXIT
AntiCrash()
return

getLatestChatlog(){
    FileRead, fileChatlog, %A_MyDocuments%\GTA San Andreas User Files\SAMP\chatlog.txt
    StringReplace fileChatlog, fileChatlog, `n, `n, All UseErrorLevel
    latestLineChatlog := ErrorLevel

    loop, Parse, fileChatlog, `n, `r
    {
        if (A_Index == latestLineChatlog) {
            return A_LoopField
            break
        }
    }
}

getLatestElevenLineChatlog(){
    FileRead, fileChatlog, %A_MyDocuments%\GTA San Andreas User Files\SAMP\chatlog.txt
    StringReplace fileChatlog, fileChatlog, `n, `n, All UseErrorLevel
    latestLineChatlog := ErrorLevel

    collectedString := ""

    loop, Parse, fileChatlog, `n, `r
    {
        if (A_Index >= (latestLineChatlog - 10)) {
            collectedString := collectedString "`n" A_LoopField
            if (A_Index == latestLineChatlog) {
                return collectedString
            }
        }
    }
}

EnterNearestVehicle()
{
    if (WinActive("GTA:SA:MP")) {
        Sleep, 300
        Send {LAlt down}{R down}
        Sleep, 100
        Send {LAlt up}{R up}
        Sleep, 200
        Send {F down}
        Sleep, 100
        Send {F up}
    }
}

<!\::
    latest := getLatestElevenLineChatlog()
    isNotSuccesfullyBackedUp := true
    loop, Parse, latest, `n, `r
    {
        RegExMatch(A_LoopField, "__(.*)__", format)
        if (format != "BACKUP NAME" && format != "") {
            isNotSuccesfullyBackedUp := false
            StringTrimLeft, format, format, 2
            StringTrimRight, format, format, 2
            FileCopy, %A_MyDocuments%\GTA San Andreas User Files\SAMP\chatlog.txt, %A_MyDocuments%\GTA San Andreas User Files\SAMP\[BACKUP] %format%.txt
            AddChatMessage("{FFFFFF}[{fd746d}KEYBIND{ffffff}] Chatlog backup saved as {ff0000}[BACKUP] " format ".txt")
            return
        }
    }
    if (isNotSuccesfullyBackedUp) {
        AddChatMessage("FFFFFF}[{fd746d}KEYBIND{ffffff}] Failed to save backup, please define backup format.")
        AddChatMessage("FFFFFF}[{fd746d}KEYBIND{ffffff}] Example: type /b __BACKUP NAME__ to save file as 'BACKUP NAME.txt'.")
    }
return

<!-::
    ShowDialog(0, "Auto Takeout RP", "You'll automatically Takeout Weapons RP to "GetPlayerWeaponName(), "OK", "Cancel")
return

<!=::
    ShowDialog(0, "Auto Put RP", "You'll automatically Put Weapons RP to "GetPlayerWeaponName(), "OK", "Cancel")
return

<!M::
    ShowDialog(0, "Auto Mancing", "Auto mancing sampai pancingan habis!", "Enable", "Disable")
return

#If IsDialogOpen() && WinActive("GTA:SA:MP")
    Enter::
        OnDialogResponse(true)
    return
    ESC::
        OnDialogResponse(false)
    return

<!Q::
    if (isDialogOpen()) {
        Send, {enter}
    } else {
        SendChat("/v lock")
        isNotPressed := true
        while (isNotPressed) {
            if (isDialogOpen()) {
                Send, {up}
                Send, {up}
                Send, {up}
                Send, {up}
                isNotPressed := false
            }
        }
    }
return

<!1::
    SendChat("/v lock")
    if (!IsPlayerInAnyVehicle()) {
        isNotPressed := true
        while (isNotPressed) {
            if (isDialogOpen()) {
                Send, {up}
                Send, {up}
                Send, {up}
                Send, {up}
                Send, {enter}
                isNotPressed := false
                return
            }
        }
    }
Return

<!2::
    SendChat("/v lock")
    if (!IsPlayerInAnyVehicle()) {
        isNotPressed := true
        while (isNotPressed) {
            if (isDialogOpen()) {
                Send, {up}
                Send, {up}
                Send, {up}
                Send, {up}
                Send, {down}
                Send, {enter}
                isNotPressed := false
                return
            }
        }
    }
Return

<!3::
    SendChat("/v lock")
    if (!IsPlayerInAnyVehicle()) {
        isNotPressed := true
        while (isNotPressed) {
            if (isDialogOpen()) {
                Send, {up}
                Send, {up}
                Send, {up}
                Send, {up}
                Send, {down}
                Send, {down}
                Send, {enter}
                isNotPressed := false
                return
            }
        }
    }
Return

<!4::
    SendChat("/v lock")
    if (!IsPlayerInAnyVehicle()) {
        isNotPressed := true
        while (isNotPressed) {
            if (isDialogOpen()) {
                Send, {up}
                Send, {up}
                Send, {up}
                Send, {up}
                Send, {down}
                Send, {down}
                Send, {down}
                Send, {enter}
                isNotPressed := false
                return
            }
        }
    }
Return

<!5::
    SendChat("/v lock")
    if (!IsPlayerInAnyVehicle()) {
        isNotPressed := true
        while (isNotPressed) {
            if (isDialogOpen()) {
                Send, {up}
                Send, {up}
                Send, {up}
                Send, {up}
                Send, {down}
                Send, {down}
                Send, {down}
                Send, {down}
                Send, {enter}
                isNotPressed := false
                return
            }
        }
    }
Return

<!E::
    if (GetVehicleEngineState()) {
        SendChat("/v park")
    } else {
        SendChat("/v engine")
    }
Return

<!V::
    SendChat("/v trunk")
Return

<!B::
    SendChat("/v storage")
Return

<!J::
    SendChat("/jobdelay")
Return

<!F1::
    reload
return

ButtonEXIT:
ExitApp

GuiClose:
    ExitApp
return
