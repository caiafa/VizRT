sub onInit ()
	geometry.registerTextChangedCallback ()
end sub

sub OnGeometryChanged(geom As Geometry)
	Dim voyoString, protvString,pro_tvString, proarenaString, pro_arenaString As String
	Dim currentText, originalText As String
	
	currentText = Geom.Text
	originalText = Geom.Text
	
	voyoString = "VOYO"
	protvString = "PROTV"
	pro_tvString = "PRO TV"
	proarenaString = "PROARENA"
	pro_arenaString = "PRO ARENA"
	
	currentText.MakeUpper()
	
	Do While currentText.Find(voyoString) > -1
		originalText.Replace(currentText.Find(voyoString), voyoString.Length, "②  ")
		currentText = originalText
		currentText.MakeUpper()
	Loop
	
	Do While currentText.Find(protvString) > -1
		originalText.Replace(currentText.Find(protvString), protvString.Length, "① ")
		currentText = originalText
		currentText.MakeUpper()
	Loop

	Do While currentText.Find(pro_tvString) > -1
		originalText.Replace(currentText.Find(pro_tvString), pro_tvString.Length, "① ")
		currentText = originalText
		currentText.MakeUpper()
	Loop	
	
	Do While currentText.Find(proarenaString) > -1
		originalText.Replace(currentText.Find(proarenaString), proarenaString.Length, "③")
		currentText = originalText
		currentText.MakeUpper()
	Loop	
	
	Do While currentText.Find(pro_arenaString) > -1
		originalText.Replace(currentText.Find(pro_arenaString), pro_arenaString.Length, "③")
		currentText = originalText
		currentText.MakeUpper()
	Loop	
	
	This.Geometry.Text = originalText
end sub
