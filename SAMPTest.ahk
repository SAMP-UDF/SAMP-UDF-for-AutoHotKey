if not A_IsAdmin
{
Run *RunAs "%A_ScriptFullPath%"
ExitApp
}
#Warn
#UseHook
#NoEnv
#SingleInstance force
#include %A_ScriptDir%\SAMP.ahk
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
;SetTimer, Overlay, 1000000

IniRead, Nickname, Daten.ini, Ingame Daten:, Nickname
Gui, Add, Text, x10 y5, -: /lock
Gui, Add, Edit, x100 y70 w140 h20 vnamen, %Nickname%
Gui, Add, Button, x40 y30 w140 h20 grefresh, reloaden
Gui, Add, Button, x100 y100 w140 h20 gSavetest, Speichern
Gui, Add, Button, x40 y100 w140 h20 gconnect, samp starten
AntiCrash()
Gui, Show, , blabla
return
Savetest:
GuiControlGet,Nickname ,,Namen
IniWrite, %Nickname%, Daten.ini, Ingame Daten: , Nickname
return
connect:
RegRead GTA_SA_EXE, HKEY_CURRENT_USER, Software\SAMP, gta_sa_exe
SplitPath, GTA_SA_EXE,, PFAD
Run %Pfad%\samp.exe server.nemesus-roleplay.net:7777, %PFAD%
Return

refresh:
Reload
Return

GuiClose:
ExitApp
return

Hotkey, Enter, Off
Hotkey, Escape, Off
return

+T::
~t::
Suspend On
Hotkey, Enter, On
Hotkey, Escape, On
Hotkey, t, Off
return

~NumpadEnter::
~Enter::
Suspend Permit
Suspend Off
Hotkey, t, On
Hotkey, Enter, Off
Hotkey, Escape, Off
return

~Escape::
Suspend Permit
Suspend Off
Hotkey, t, On
Hotkey, Enter, Off
Hotkey, Escape, Off
return


;#########################################################################################################


;Gebt einen Spielernamen ein, um weitere Infos über diesen Spieler zu bekommen
Numpad1::
SendInput tName:{Space}
Suspend On
Hotkey, Enter, On
Hotkey, Escape, On
Input varName, V I M,{enter}
SendInput {end}+{home}{Del}{esc}
varID := GetPlayerIdByName(varName)
ShowGameText(GetPlayerNameById(varID) "~n~Score: " GetPlayerScoreById(varID) "~n~Ping: " GetPlayerPingById(varID), 2000, 5)
return

;Gebt eine ID ein, um weitere Infos über diesen Spieler zu bekommen
Numpad2::
SendInput tID:{Space}
Suspend On
Hotkey, Enter, On
Hotkey, Escape, On
Input varID, V I M,{enter}
SendInput {end}+{home}{Del}{esc}
;updateScoreboardData() ;wird nun implizit aufgerufen
ShowGameText(GetPlayerNameById(varID) "~n~Score: " GetPlayerScoreById(varID) "~n~Ping: " GetPlayerPingById(varID) "~n~IsNPC: " IsNPCById(varID), 2000, 5)
return

;Spielt einen "Audio Stream" ab
Numpad3::
PlayAudioStream("http://breakz.us/radio/listen.pls")
return

;Stoppt einen "Audio Stream"
Numpad4::
StopAudioStream()
return

;Zeigt diverse Infos über die eigene Spielerfigur an
Numpad5::
if ( IsInChat() )
return
AddChatMessage("{FFFFFF}IP: {FF0000}" GetServerIp() "{FFFFFF}, Hostname: {FF0000}" GetServerName())
AddChatMessage("{FFFFFF}Name: {FF0000}" GetPlayerName()"{FFFFFF}, Port: {FF0000}" GetServerPort())
AddChatMessage("{FFFFFF}HP: {FF0000}" GetPlayerHealth() "{FFFFFF}, ARMOR: {FF0000}" GetPlayerArmor())
pos := GetPlayerCoordinates()
AddChatMessage("{FFFFFF}Zone: {FF0000}" CalculateZone(pos[1],pos[2],pos[3]) "{FFFFFF}, Stadt: {FF0000}" CalculateCity(pos[1],pos[2],pos[3]))
SendChat("blub")
SendChat("/asd")
ShowGameText("Test", 2000, 5)
return

;Zeigt eine Dialog-Box an
#If !IsInChat()
1::
	ShowDialog(DIALOG_STYLE_LIST, "Keybinder Menü", "Funktion1`nFunktion2`nFunktion3", "Weiter", "Schließen")
return
#If IsDialogOpen() && WinActive("GTA:SA:MP")
Enter::
	OnDialogResponse(true)
return
ESC::
	OnDialogResponse(false)
return
#If
OnDialogResponse(response) {
	caption := GetDialogCaption()
	if (response) {
		if (caption == "Keybinder Menü") {
			line := GetDialogLine__(GetDialogIndex())
			if (line == "Funktion1") {
				ShowDialog(DIALOG_STYLE_LIST, "Keybinder - Funktion1", "Test1`nTest2`nTest3", "Weiter", "Schließen")
			}
			else if (line == "Funktion2") {
				ShowDialog(DIALOG_STYLE_INPUT, "Keybinder - Funktion2", "Gebe einen Text ein: ", "Ok", "Schließen")
			}
		}
		else if (caption == "Keybinder - Funktion1") {
			line := GetDialogLine__(GetDialogIndex())
			AddChatMessage(line)
			Send, {Enter}
		}
		else if (caption == "Keybinder - Funktion2") {
			clipboardBuffer := ClipboardAll
			clipboard := ""
			Send, ^{A}
			Send, ^{X}
			sleep, 100
			dialogInput := clipboard
			clipboard := clipboardBuffer
			if (dialogInput != -1 && dialogInput != "") {
				AddChatMessage("Dialog Input: " dialogInput)
			}
			Send, {Enter}
		}
		else
			Send, {Enter}
	}
	else {
		if (caption == "Keybinder - Funktion1") {
			ShowDialog(DIALOG_STYLE_LIST, "Keybinder Menü", "Funktion1`nFunktion2`nFunktion3", "Weiter", "Schließen")
		}
		else
			Send, {ESC}
	}
	return
}


;show some info about the current vehicle
Numpad7::
AddChatMessage("{FFFFFF}Vehicle Type:" GetVehicleType())
AddChatMessage("{FFFFFF}Model:" GetVehicleModelId())
AddChatMessage("{FFFFFF}Model Name:" GetVehicleModelName())
AddChatMessage("{FFFFFF}Is Driver:" IsPlayerDriver() " | 0 nein, 1ja")
AddChatMessage("{FFFFFF}Light State:" GetVehicleLightState())
AddChatMessage("{FFFFFF}Engine State:" GetVehicleEngineState())
AddChatMessage("{FFFFFF}Door State:" GetVehicleLockState())
AddChatMessage("Nummernschild:" GetVehicleNumberPlate())
return

Numpad8::
Count := CountOnlinePlayers()
AddChatMessage("Es sind " Count " Spieler Online.")
return
