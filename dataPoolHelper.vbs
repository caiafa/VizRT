'Resets the Shared Memory keys found on subcontainers.

Dim PLUGIN_NAME As String = "DataSHMTracker"
Dim FIELD_NAME As String = "FieldName"


Sub OnInit()
	resetSharedDataPoolKeys()
End Sub
	
Sub resetSharedDataPoolKeys()
	Dim currentContainer As Container = FirstChildContainer
	Dim currentFieldName As String
	
	currentContainer = FirstChildContainer
	
	Do While currentContainer <> NULL
		Scene.Map[currentContainer.GetFunctionPluginInstance(PLUGIN_NAME).GetParameterString(FIELD_NAME)] = " "
		currentContainer = currentContainer.NextContainer
	Loop
End Sub

'Fills the DataSHM and DataSHMTrackers DP fields with the name of their host container. If the plugins aren't present, creates them.
Sub shareDataPoolKeys()
	Dim currentContainer As Container = FirstChildContainer
	Dim currentFieldName As String
	
	currentContainer = FirstChildContainer
	
	Do While currentContainer <> NULL
		If currentContainer.GetFunctionPluginInstance("DataSHM") == NULL Then
			currentContainer.CreateFunction("BUILT_IN*FUNCTION*DataSHM")
		End If
		
		If currentContainer.GetFunctionPluginInstance("DataSHMTracker") == NULL Then
			currentContainer.CreateFunction("BUILT_IN*FUNCTION*DataSHMTracker")		
		End If 
		
		currentContainer.GetFunctionPluginInstance("DataSHM").SetParameterString("FieldName", currentContainer.Name)
		currentContainer.GetFunctionPluginInstance("DataSHMTracker").SetParameterString("FieldName", currentContainer.Name)
		currentContainer.GetFunctionPluginInstance("DataSHM").SetParameterString("ShmName", currentContainer.Name) 
		currentContainer.GetFunctionPluginInstance("DataSHMTracker").SetParameterString("ShmName", currentContainer.Name) 

		currentContainer = currentContainer.NextContainer
	Loop
End Sub


Sub OnInitParameters()
	RegisterInfoText("resetSharedDataPoolKeys() - Resetează valorile \n                            de Scene.Map sharuite de subcontainere.\nshareDataPoolKeys() - Fills the DataSHM and DataSHMTrackers DP fields\n                      with the name of their host container.")
	RegisterPushButton("resetSharedDataPoolKeys", "Reset Shared DataPool Keys", 1)
	RegisterPushButton("initDataPoolSharing", "Init DataPool Sharing", 2)
End Sub

Sub OnExecAction(buttonId As Integer)
	If buttonId == 1 Then
		resetSharedDataPoolKeys()
	Elseif buttonId == 2 Then
		shareDataPoolKeys()
	End If
End Sub

