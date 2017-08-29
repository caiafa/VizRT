' Reseteaza cheile de Shared Memory de pe subcontainere.

Dim PLUGIN_NAME As String = "DataSHMTracker"
Dim FIELD_NAME As String = "FieldName"


Sub OnInit()
	reset()
End Sub
	
Sub reset()
	RegisterInfoText("Resetează valorile de Scene.Map sharuite de subcontainere.")
	
	Dim currentContainer As Container = FirstChildContainer
	Dim currentFieldName As String
	
	currentContainer = FirstChildContainer
	
	Do While currentContainer <> NULL
		Scene.Map[currentContainer.GetFunctionPluginInstance(PLUGIN_NAME).GetParameterString(FIELD_NAME)] = " "
		currentContainer = currentContainer.NextContainer
	Loop
End Sub


Sub OnInitParameters()
	RegisterPushButton("test", "TEST", 1)
End Sub

Sub OnExecAction(buttonId As Integer)
	If buttonId == 1 Then
		reset()
	End If
End Sub
