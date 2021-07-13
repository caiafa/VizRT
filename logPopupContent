Sub logContent()
	Dim currentText, popupLogContent, popupLogDate As String

	popupLogContent = "|"
	popupLogDate = ""
	
	For i=1 To 5
		currentText = GetParameterString("text" & i)
		If currentText <> "" Then
			popupLogContent &= " " & currentText & " |"
		End If
	Next

	exportDateLog(popupLogContent, popupLogDate)
End Sub

Sub exportDateLog(content As string, date As string)
	System.Map["popupDate"] = ""
	System.Map["popupContent"] = content
End Sub

Sub OnInitParameters()	
	'string parameters
	RegisterParameterString("text1", "Text 1", "TEXT 1", 120, 120, "")
	RegisterParameterString("text2", "Text 2", "TEXT 2", 120, 120, "")
	RegisterParameterString("text3", "Text 3", "TEXT 3", 120, 120, "")
	RegisterParameterString("text4", "Text 4", "TEXT 4", 120, 120, "")
	RegisterParameterString("text5", "Text 5", "TEXT 5", 120, 120, "")
	
	'push button
	RegisterPushButton("init", "Init", 1)
End Sub

Sub OnExecAction(buttonId As Integer)
	If buttonId = 1 Then
		logContent()
	End If
End Sub
