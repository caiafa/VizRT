sub onParameterChanged (parameterName as String)
	select case parameterName
		case "pageToTake"
			'updateContinueKeyframeTime()
	end select
end sub

Sub OnInitParameters()
	RegisterParameterInt("pageToTake", "Page to take", 0, 0, 20000)
	RegisterPushButton("takePage", "REMOTE TAKE", 1)
	RegisterPushButton("takeOutPage", "REMOTE TAKE OUT", 2)
End Sub

Sub OnInit()
End Sub

Sub OnExecAction(buttonId As Integer)
	If buttonId == 1 Then
		RemoteTake("in")
	Elseif buttonId == 2 Then
		RemoteTake("out")
	End If
End Sub

Function readConfig() As String
	Dim configContent As String
	Dim fileLoaded as Boolean = System.LoadTextFile("D:\\viz_settings\\trioIP.txt", configContent)
	
	configContent.Trim()
	readConfig = configContent
End Function

Sub RemoteTake(state As String)
	Dim remoteIP As String
	
	remoteIP = readConfig()
		
	'println "take(" & GetParameterInt("pageToTake") & ") \r\n\0"
	
	If state = "in" Then
		TcpSend(remoteIP, 6200, "page:take " & GetParameterInt("pageToTake") & " \r\n\0", 0)
	Elseif state = "out" Then
		TcpSend(remoteIP, 6200, "page:takeout \r\n\0", 0)
	End If
End Sub

