Function readLine(Byref text As String) As String
	Dim pos As Integer = text.Find("\n")
	
	readLine = ""
	
	If pos >= 0 Then	
		readLine = text.GetSubstring(0, pos )
		text.replace(0, pos + 1, "")
	End If
End Function
