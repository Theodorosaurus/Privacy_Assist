TraySetIcon(A_ScriptDir "\Privacy_Assist.ico")

SetWorkingDir A_ScriptDir

try {
	star_ing_Scrpt	
}
catch {
	Exit
}

MyGui := Gui(,"Privacy Assistant")
MyGui.BackColor := "000000"
MyGui.Opt("AlwaysOnTop")
MyGui.SetFont("s12 bold" )
MyGui.SetFont("cWhite")
MyGui.Add("Text","X90 Y10", "Select Action:")
MyGui.SetFont("s12 w700")
MyGui.Add("Button", "x60 y35 w200 h35", "Camera On/Off").OnEvent("Click", Ca_mera_Status)
MyGui.Add("Button", "x60 y80 w200 h35", "Microphones On/Off").OnEvent("Click", Mi_cs_Off_On)
MyGui.Show("w300 h150")

star_ing_Scrpt(*) {

If !(A_IsAdmin) {	
	Run '*RunAs "Privacy Assist.ahk"'
}

}

Ca_mera_Status(*) {

GettinStatus := RegRead("HKLM\SYSTEM\CurrentControlSet\Services\usbvideo", "Start")

If (GettinStatus = 3) {

	MyGui.Destroy
	MyGui2 := Gui(,"Privacy Assistant")
	MyGui2.BackColor := "000000"
	MyGui2.Opt("AlwaysOnTop")
	MyGui2.SetFont("s12 bold" )
	MyGui2.SetFont("cWhite")
	MyGui2.Add("Text","X70 Y10", "Camera is Enabled")
	MyGui2.Add("Text","X40 Y30", "Would you like to Disable it?")
	MyGui2.Add("Button", "x60 y60 w95 h30", "Disable").OnEvent("Click", Ca_mera_Off)
	MyGui2.Add("Button", "x160 y60 w95 h30", "Exit").OnEvent("Click", Ex_itor)
	MyGui2.Show("w280 h110")

}
else if (GettinStatus = 4) {

	MyGui.Destroy
	MyGui3 := Gui(,"Privacy Assistant")
	MyGui3.BackColor := "000000"
	MyGui3.Opt("AlwaysOnTop")
	MyGui3.SetFont("s12 bold" )
	MyGui3.SetFont("cWhite")
	MyGui3.Add("Text","X70 Y10", "Camera is Disabled")
	MyGui3.Add("Text","X40 Y30", "Would you like to Enable it?")
	MyGui3.Add("Button", "x60 y60 w95 h30", "Enable").OnEvent("Click", Ca_mera_On)
	MyGui3.Add("Button", "x160 y60 w95 h30", "Exit").OnEvent("Click", Ex_itor)
	MyGui3.Show("w280 h110")

}
else {
	MsgBox "Expected Value could NOT be found.`nPlease must check Registry editor manually."
	Exit
}


Ca_mera_On(*) {

MyGui3.Destroy
RegWrite "3", "REG_DWORD", "HKLM\SYSTEM\CurrentControlSet\Services\usbvideo", "Start"
Shutdown 6

}

Ca_mera_Off(*) {

MyGui2.Destroy
RegWrite "4", "REG_DWORD", "HKLM\SYSTEM\CurrentControlSet\Services\usbvideo", "Start"
Shutdown 6

}

}

Mi_cs_Off_On(*) {

MyGui.Destroy

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

Ex_itor(*) {

	ExitApp

}

#SingleInstance