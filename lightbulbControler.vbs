Dim counter As integer
Dim freq As integer
Dim bulbs As integer

Sub OnInit()
	counter = 0
End Sub

Sub OnExecPerField()
	If counter mod freq == 0 Then
		For i = 0 To bulbs
			GetChildContainerByIndex(Random(ChildContainerCount)).Script.switch(CBool(Random(2)))
		Next
	End If
	counter++
End Sub

Sub OnInitParameters()
	RegisterParameterInt("frequency", "SPEED", 5, 0, 1000)	
	RegisterParameterInt("bulbs", "BULBS", 3, 0, 50)	
End Sub

Sub OnParameterChanged(parameterName As String)
	freq = GetParameterInt("frequency")
	bulbs = GetParameterInt("bulbs")
End Sub
