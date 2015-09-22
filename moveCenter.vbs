Dim x,y As Double

Sub OnInitParameters()
	RegisterPushButton("SET_CENTER", "SET CENTER", 1)
	RegisterParameterContainer("pivot", "PIVOT")	
End Sub

Sub OnExecAction(buttonId As Integer)
	Dim container As container
	container = GetParameterContainer("pivot")
	container.LocalPosToScreenPos(container.center.xyz, x, y)
	This.SetCenterScreenPositionLocked(x, y)		
End Sub
