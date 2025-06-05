sub onInitParameters ()
	registerParameterString ("parameterName", "Parameter name", "", 100, 100, "")
	registerParameterBool ("linkParameter", "Link parameter", false)
	
	for i = 1 to 3
		registerParameterContainer ("container" & i, "Linked Container " & i)
	next
end sub

sub onInit ()
	geometry.registerTextChangedCallback ()
end sub

sub onExecPerField ()
	for i = 1 to 3
		if getParameterContainer ("container" & i) <> null then
			
			if getParameterBool("linkParameter") then
				dim pgInstance As PluginInstance
			
				'println this.GetGeometryPluginInstance().GetParameterDouble(GetParameterString("parameterName"))
				
				getParameterContainer ("container" & i).GetGeometryPluginInstance().SetParameterDouble(GetParameterString("parameterName"), this.GetGeometryPluginInstance().GetParameterDouble(GetParameterString("parameterName"))) 
			end if			
		end if
	next
end sub
