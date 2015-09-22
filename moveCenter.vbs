Dim x,y As Double

Sub OnInitParameters()
	RegisterParameterContainer("pivot", "PIVOT")	
End Sub

Sub OnParameterChanged(parameterName As String)
	Dim container As container
	container = GetParameterContainer("pivot")
	container.LocalPosToScreenPos(container.position.xyz, x, y)
	This.SetCenterScreenPositionLocked(x, y)
End Sub
