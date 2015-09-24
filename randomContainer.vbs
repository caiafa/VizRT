Sub OnInit()
	randomContainer()
End Sub

Sub randomContainer()
	Dim picturesAvailable As Array[container]
	Dim showPictures As Integer
	
	This.GetContainerAndSubContainers(picturesAvailable, False)
	picturesAvailable.Erase(0)

	showPictures = Random(picturesAvailable.Ubound)
	
	For i = 0 To picturesAvailable.Ubound
		If i == showPictures Then
			picturesAvailable[i].Active = True
		Else
			picturesAvailable[i].Active = False
		End If
	Next
End Sub

Sub OnExecAction(buttonId As Integer)
	If buttonId == 1 Then
		randomContainer()
	End If
End Sub

Sub OnInitParameters()
	RegisterPushButton("update", "UPDATE", 1)
End Sub

