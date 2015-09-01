Dim SCENE_ID 			As String
Dim CAMERA 				As Camera
Dim CROP_MASK As Container
Dim EXPORT_PATH As String = "//vizrt/work/dataSources/PROTV/popups/snaps/"
Dim SNAP_LOCATION As String = "ON_AIR/MCR/PROTV/popups/snaps/"

Sub exec()
	Dim currentCx As Double
	Dim currentCMPosX As Double
	
	CROP_MASK = Scene.FindContainer("cropMask")
	currentCMPosX = CROP_MASK.Position.x
	CROP_MASK.Position.x += 500
	
	SCENE_ID = Scene.Name 
	CAMERA = Scene.CurrentCamera
	
	currentCx = CAMERA.Cx
	CAMERA.Cx = 0
	
	takeSnap("RGBA", SNAP_LOCATION, SCENE_ID)
	exportSnap(EXPORT_PATH, SNAP_LOCATION, SCENE_ID)
	
	CAMERA.Cx = currentCx
	CROP_MASK.Position.x = currentCMPosX
End Sub

Sub OnInitParameters()
	RegisterPushButton("SCREENSHOT", "SCREENSHOT", 1)
End Sub

Sub takeSnap(mode As String, location As String, name As String)
	If mode == "RGBA" Or mode == "RGB" Then
		SendCommand("IMAGE SNAPSHOT " & location & name & " " & mode & " 1920 1080")
	End If
End Sub

Sub exportSnap(exportPath As String, path As String, name As String)
	SendCommand("IMAGE EXPORT " & path & name & " " & Chr(34) & exportPath & name & Chr(34) & " png")
End Sub

Sub OnExecAction(buttonId As Integer)
	If buttonId == 1 Then
		exec()
	End If
End Sub
