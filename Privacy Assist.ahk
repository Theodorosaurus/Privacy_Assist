TraySetIcon(A_ScriptDir "\Privacy_Assist.ico")

SetWorkingDir A_ScriptDir

MyGui := Gui(,"Privacy Assistant")
MyGui.BackColor := "000000"
MyGui.Opt("AlwaysOnTop")
MyGui.SetFont("s12 bold" )
MyGui.SetFont("cWhite")
MyGui.Add("Text","X100 Y10", "Select Action:")
MyGui.SetFont("s12 w700")
MyGui.Add("Button", "x60 y35 w200 h35", "Camera On/Off").OnEvent("Click", Ca_mera_Status)
MyGui.Add("Button", "x60 y80 w200 h35", "Microphones On/Off").OnEvent("Click", Mi_cs_Off_On)

MyGui2 := Gui(,"Privacy Assistant")
MyGui2.BackColor := "000000"
MyGui2.Opt("AlwaysOnTop")
MyGui2.SetFont("s12 bold" )
MyGui2.SetFont("cWhite")
MyGui2.Add("Text","X70 Y10", "Camera is Enabled")
MyGui2.Add("Text","X40 Y30", "Would you like to Disable it?")
MyGui2.Add("Button", "x60 y60 w95 h30", "Disable").OnEvent("Click", Ca_mera_Change)
MyGui2.Add("Button", "x160 y60 w95 h30", "Exit").OnEvent("Click", Ex_itor)

MyGui3 := Gui(,"Privacy Assistant")
MyGui3.BackColor := "000000"
MyGui3.Opt("AlwaysOnTop")
MyGui3.SetFont("s12 bold" )
MyGui3.SetFont("cWhite")
MyGui3.Add("Text","X70 Y10", "Camera is Disabled")
MyGui3.Add("Text","X40 Y30", "Would you like to Enable it?")
MyGui3.Add("Button", "x60 y60 w95 h30", "Enable").OnEvent("Click", Ca_mera_Change)
MyGui3.Add("Button", "x160 y60 w95 h30", "Exit").OnEvent("Click", Ex_itor)

MyGui4 := Gui(,"Privacy Assistant")
MyGui4.BackColor := "000000"
MyGui4.Opt("AlwaysOnTop")
MyGui4.SetFont("s12 bold" )
MyGui4.SetFont("cWhite")
MyGui4.Add("Text","X80 Y10", "System Restart")
MyGui4.Add("Text","X08 Y30", "required for changes to take effect")
MyGui4.Add("Button", "x25 y60 w110 h30", "Restart Now").OnEvent("Click", RR_Now)
MyGui4.Add("Button", "x145 y60 w110 h30", "Restart Later").OnEvent("Click", Ex_itor)

GettinStatus := RegRead("HKLM\SYSTEM\CurrentControlSet\Services\usbvideo", "Start")

If (A_IsAdmin) && (GettinStatus = 3) {
	MyGui.Destroy
	MyGui2.Destroy
	RegWrite "4", "REG_DWORD", "HKLM\SYSTEM\CurrentControlSet\Services\usbvideo", "Start"
	MyGui4.Show("w280 h110")	
}
else if (A_IsAdmin) && (GettinStatus = 4) {
	MyGui.Destroy
	MyGui2.Destroy
	RegWrite "3", "REG_DWORD", "HKLM\SYSTEM\CurrentControlSet\Services\usbvideo", "Start"
	MyGui4.Show("w280 h110")
}
else {
	MyGui.Show("w300 h150")
}

RR_Now(*) {

Shutdown 6
MyGui4.Destroy

}

Ex_itor(*) {

ExitApp

}

Ca_mera_Status(*) {

If (GettinStatus = 3) {

	MyGui.Destroy
	MyGui2.Show("w280 h110")

}
else if (GettinStatus = 4) {

	MyGui.Destroy
	MyGui3.Show("w280 h110")

}
else {
	MsgBox "Expected Value could NOT be found.`nPlease check Registry editor manually."
	ExitApp
}

}

Ca_mera_Change(*) {

try {
	Run '*RunAs "Privacy Assist.ahk"'	
}
catch {
	Exit
}

}


Mi_cs_Off_On(*) {

if (SoundGetMute( , "Microphone") = 1) || (SoundGetMute( , "Jack Mic") = 1) {

	SoundSetMute 0, , "Microphone"

	try {

	SoundSetMute 0, , "Jack Mic"
	}
	catch {
		return
	}
	TrayTip , "Microphones are recording", "1"

}
else {

	SoundSetMute 1, , "Microphone"

	try {

	SoundSetMute 1, , "Jack Mic"
	}
	catch {
		return
	}
	TrayTip , "Microphones are Muted", "1"

}	

}

#SingleInstance
