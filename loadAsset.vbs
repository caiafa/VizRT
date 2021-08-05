sub loadAsset()
	CreateGeometry(GetParameterString("prefix") & GetParameterString("asset" & (Random(4) + 1)))
End Sub

sub OnInit()
	loadAsset()
end sub

sub OnExecAction(buttonId As Integer)
	Select Case buttonId
		Case 0
			loadAsset()
	End Select
end sub

sub OnInitParameters()
	RegisterPushButton("load", "Load asset", 0)
	RegisterParameterString("prefix", "Path prefix", "", 100, 100, "")
	
	For i = 1 To 4
		RegisterParameterString("asset" & i, "Asset name " & i, "", 100, 100, "")
	Next
end sub

