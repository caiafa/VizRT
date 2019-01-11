Structure signalEmiter
	emiter As Container
	proprieties As StringMap
End Structure

Dim children As Array[signalEmiter]

Dim targetContainer As Container
Dim containerScreenSize As Double
Dim updateValues As Integer

Sub remoteExecuteOnChange(emiter As container, arguments As StringMap)
	Dim isTracked As boolean = false
	Dim newChild As signalEmiter
	
	If children.Ubound < 0 Then
		newChild.emiter = emiter
		newChild.proprieties = arguments
		children.push(newChild)
	End If
	
	For i = 0 to children.Ubound
		isTracked = false
		
		If children[i].emiter == emiter Then
			isTracked = true
			children[i].proprieties = arguments
			Exit For
		End If
	Next
	
	If isTracked Then
	Else
		newChild.emiter = emiter
		newChild.proprieties = arguments
		children.push(newChild)
	End If
	
	println children.Ubound
	_updateArguments()
End Sub

Sub _updateArguments()
	Dim argumentNames As Array[string]
	Dim passedArgumentsToText As String = ""
	Dim currentEmiter As Container
	Dim currentProprieties As StringMap
	
	For i = 0 to children.Ubound
		currentEmiter = children[i].emiter
		currentProprieties = children[i].proprieties
		currentProprieties.GetKeys(argumentNames)
		
		passedArgumentsToText &= currentEmiter.Name & "-"
		
		For each key in argumentNames
			passedArgumentsToText &= key & ":" & currentProprieties[key] & "\n"
		Next
	Next
	
	This.ScriptPluginInstance.SetParameterString("passedArguments", passedArgumentsToText)
End Sub

sub onInitParameters ()
	RegisterParameterLabel("passedArguments", "", 500, 100)

	registerParameterDouble("valueScaling", "Value Scaling", 1, -1000, 1000)
	registerParameterDouble("valueOffset", "Value Offset", 0, -1000, 1000)
	registerParameterContainer ("textureContainer", "Texture container")
end sub	
