Dim buttons As Array[string]
buttons.push("UserId")
buttons.push("UserName")

sub onInit ()
	geometry.registerTextChangedCallback ()
	parseText(GetParameterString("userIdToParse"), buttons[GetParameterInt("user")])
	update ()
end sub

Sub OnInitParameters()
	RegisterParameterString("userIdToParse","Author", "", 120, 120, "")
	RegisterRadioButton("user", "User Info", 0, buttons)
End Sub

sub OnParameterChanged(parameterName As String)
	parseText(GetParameterString("userIdToParse"), buttons[GetParameterInt("user")])
end sub

Sub parseText(text As String, infoType As String)
	Dim userName, userId As String
	
	text.trim()
	userId = text.GetSubstring(text.FindLastOf("@"), text.Length - text.FindLastOf("@"))
	userName = text.GetSubstring(0, text.Length - (text.Length - text.FindLastOf("@")))
	
	If infoType == "UserId" Then
		geometry.text = userId
	Else
		geometry.text = userName
	End If 
End Sub

sub OnGeometryChanged(geom As Geometry)
	update ()
end sub

sub update ()
	dim text as String = geometry.text
	text.trim()
	active = text <> ""
end sub
