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
Run %Pfad%\samp.exe 127.0.0.1:7777, %PFAD%
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
;updateScoreboardData() ;wird nun implizit aufgerufen
varID := getPlayerIdByName(varName)
showGameText(getPlayerNameById(varID) "~n~Score: " getPlayerScoreById(varID) "~n~Ping: " getPlayerPingById(varID), 2000, 5)
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
showGameText(getPlayerNameById(varID) "~n~Score: " getPlayerScoreById(varID) "~n~Ping: " getPlayerPingById(varID) "~n~IsNPC: " isNPCById(varID), 2000, 5)
return

;Spielt einen "Audio Stream" ab
Numpad3::
playAudioStream("http://breakz.us/radio/listen.pls")
return

;Stoppt einen "Audio Stream"
Numpad4::
stopAudioStream()
return

;Zeigt diverse Infos über die eigene Spielerfigur an
Numpad5::
if ( isInChat() )
return
addChatMessage("{FFFFFF}IP: {FF0000}" getServerIP() "{FFFFFF}, Hostname: {FF0000}" getServerName())
addChatMessage("{FFFFFF}Name: {FF0000}" getUsername())
addChatMessage("{FFFFFF}HP: {FF0000}" getPlayerHealth() "{FFFFFF}, ARMOR: {FF0000}" getPlayerArmor())
pos := getCoordinates()
addChatMessage("{FFFFFF}Zone: {FF0000}" calculateZone(pos[1],pos[2],pos[3]) "{FFFFFF}, Stadt: {FF0000}" calculateCity(pos[1],pos[2],pos[3]))
SendChat("blub")
SendChat("/asd")
showGameText("test", 2000, 5)
return

;Zeigt eine Dialog-Box an
Numpad6::
showDialog(0, "Titel", "some text...", "OK" )
return

;show some info about the current vehicle
Numpad7::
addChatMessage("{FFFFFF}Vehicle Type:" getVehicleType())
addChatMessage("{FFFFFF}Model:" getVehicleModelId())
addChatMessage("{FFFFFF}Model Name:" getVehicleModelName())
addChatMessage("{FFFFFF}Is Driver:" isPlayerDriver() " | 0 nein, 1ja")
addChatMessage("{FFFFFF}Light State:" getVehicleLightState())
addChatMessage("{FFFFFF}Engine State:" getVehicleEngineState())
addChatMessage("{FFFFFF}Door State:" getVehicleLockState())
return

Numpad8::
Count := CountOnlinePlayers()
AddChatMessage("Es sind " Count " Spieler Online.")
return
