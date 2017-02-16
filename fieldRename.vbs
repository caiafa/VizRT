Structure scriptParameters
	containerName As String
	exactMatch As Boolean
	pluginName As String
	parameterName As String
	variablePrefix As String
End Structure

Sub OnInitParameters()
	RegisterParameterString("cName","Container name", "", 60, 60, "")
    RegisterParameterBool("exMatch", "Use exact match", FALSE)
	
	RegisterParameterString("plName","Plugin name", "", 60, 60, "")
	RegisterParameterString("paName","Parameter name", "", 60, 60, "")
	RegisterParameterString("prefix","Variable prefix", "", 60, 60, "")
	RegisterPushButton("execute", "EXECUTE", 1)
End Sub

Sub OnExecAction(buttonId As Integer)
	If buttonId == 1 Then
		executeAction(readParameters())
	End If
End Sub

Sub	executeAction(sParam As scriptParameters)
	For i = 0 To ChildContainerCount - 1 
		updateFields(i, sParam)
	Next	
End Sub

Sub updateFields(index As Integer, sParam As scriptParameters)
	Dim containers As array[container]
	
	GetChildContainerByIndex(index).GetContainerAndSubContainers(containers, true)
	
	For j = 0 To containers.Ubound
		If nameValid (sParam.exactMatch, containers[j].Name, sParam.containerName) Then
			writeValues(containers[j], sParam.pluginName, sParam.parameterName, sParam.variablePrefix, index)
		End If
	Next
End Sub

Sub	writeValues(target As container, plugin As String, parameter As String, prefix As String, index As Integer)
	Dim pInstance As PluginInstance = target.GetFunctionPluginInstance(plugin)

	If pInstance == NULL Then
		Exit Sub
	End If
	
	pInstance.SetParameterString(parameter, prefix & CStr(index + 1))
End Sub

Function nameValid(exactMatch As Boolean, containerName As String, searchName As String) As Boolean
	nameValid = FALSE
	
	If exactMatch Then
		If containerName = searchName Then 
			nameValid = TRUE
		End If
	Else
		If containerName.StartsWith(searchName) Then
			nameValid = TRUE
		End If
	End If
End Function

Function readParameters() As scriptParameters
	Dim parameters As scriptParameters
	
	parameters.containerName = GetParameterString("cName")
	parameters.exactMatch = GetParameterBool("exMatch")
	parameters.pluginName = GetParameterString("plName")
	parameters.parameterName = GetParameterString("paName")
	parameters.variablePrefix = GetParameterString("prefix")
	
	readParameters = parameters
End Function
