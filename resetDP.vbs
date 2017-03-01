Sub OnExecAction(buttonId As Integer)
	If buttonId == 1 Then
		exec()
	End If
End Sub

Sub exec()
	For i=1 to 4
		Scene.Map["name" & i] = "" 
		Scene.Map["score" & i] = ""
	Next
	
	Scene.Map["total"] = ""
	
	Stage.FindDirector("Director").Show(Stage.FindDirector("Director").FindKeyFrame("INIT").Time - 0.01)
End Sub

Sub OnInitParameters()
	RegisterPushButton("RESET", "RESET", 1)
End Sub
