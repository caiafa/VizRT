Sub OnInit()
	randomContainer()
End Sub

Sub randomContainer()
	Dim containersAvailable As Array[container]
	Dim showContainer As Integer
	
	This.GetContainerAndSubContainers(containersAvailable, False)
	containersAvailable.Erase(0)

	ShowOneChildContainer(Random(containersAvailable.Ubound + 1))
End Sub

Sub OnExecAction(buttonId As Integer)
	If buttonId == 1 Then
		randomContainer()
	End If
End Sub

Sub OnInitParameters()
	RegisterPushButton("update", "UPDATE", 1)
End Sub
