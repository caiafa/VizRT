Sub renameContainers()
	Dim subcontainers As Array[container]
	Dim names As Array[string]
	Dim string As String
	Dim i As Integer
	
	string = GetParameterString("text")
	string.Split("\n", names)
	
	i = 0
	
	Do While i<= names.Ubound
		If names[i] == "" Then
			names.Erase(i)
		Else
			i++
		End If
	Loop
	
	This.GetContainerAndSubContainers(subcontainers, False)
	subcontainers.Erase(0)
	
	i = 0
	
	For i = 0 To subcontainers.Ubound
		If i <= names.Ubound Then
			subcontainers[i].Name = names[i]
			subcontainers[i].Update()
		Else
			Exit For
		End If
	Next
End Sub

Sub OnExecAction(buttonId As Integer)
	If buttonId == 1 Then
		renameContainers()
	End If
End Sub

Sub OnInitParameters()
	RegisterParameterText("text", "", 300, 200)
	RegisterPushButton("update", "UPDATE", 1)
End Sub
