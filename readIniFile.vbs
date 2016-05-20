Sub OnExecAction(buttonId As Integer)
	Dim section, key As String
	
	section = ">" & GetParameterString("section")
	key = ">" & GetParameterString("key")	
	
	If buttonId == 1 Then
		println section & key
		This.Geometry.Text = CStr(readIni(GetParameterString("textPath"))[section & key])
	End If
End Sub

Sub OnInitParameters()
	RegisterFileSelector ("textPath", "Path", "", "", ".ini")	
	RegisterParameterString("section", "Section", "", 50, 50, "")
	RegisterParameterString("key", "Key", "", 50, 50, "")
	RegisterPushButton("update", "UPDATE", 1)
End Sub

Function readIni(configFile As String) As StringMap
	Dim configContent As String
	Dim fileLoaded as Boolean = System.LoadTextFile(configFile, configContent)
	Dim currentLine As String
	Dim regex As String = GetParameterString("text")
	Dim stringMap As StringMap
	Dim keyValues As Array[String]
	Dim keyValue As String = ""
	Dim currentSection As String = ""

	If System.LoadTextFile(getParameterString("textPath"), configContent) Then
		readIni[">error>fileNotFound"] = "0"
		readIni[">error>badLineFormating"] = "0"
		
		configContent.AnsiToUtf8()
		This.Geometry.Text = ""
		
		Do While configContent <> ""
			currentLine = readLine(configContent)
			currentLine.Trim()

			If Not currentLine.StartsWith(";") Or currentLine.Length == 0 Then 
				'could be replaced with Match("^\\;.*")
				
				If currentLine.Match("\\[\\w+\\]") Then
					currentSection = currentLine.GetSubstring(1, currentLine.Length - 2)
					currentSection.Trim()
				Else
					keyValue = ""
					currentLine.Split("=", keyValues)
					
					If keyValues.Ubound > 0 Then
						For i=1 To keyValues.Ubound
							keyValue &= keyValues[i]
						Next
						
						keyValues[0].Trim()
						keyValue.Trim()
						
						readIni[">" & currentSection & ">" & keyValues[0]] = keyValue
					Else
						readIni[">error>badLineFormating"] = "1"
					End If
				End If
			End If
		Loop
	Else
		readIni[">error>fileNotFound"] = "1"
	End If
End Function

Function readLine(Byref text As String) As String
	Dim pos As Integer = text.Find("\n")
	
	readLine = ""
	
	If pos >= 0 Then	
		readLine = text.GetSubstring(0, pos )
		text.replace(0, pos + 1, "")
	End If
End Function
