sub onInitParameters ()
	registerParameterBool ("linkPosition", "Link Position", false)
	registerParameterBool ("linkScaling" , "Link Scaling" , false)
	
	for i = 1 to 3
		registerParameterContainer ("container" & i, "Linked Container " & i)
	next
end sub

sub onInit ()
	geometry.registerTextChangedCallback ()
	updateVis ()
end sub

sub onExecPerField ()
	for i = 1 to 3
		if getParameterContainer ("container" & i) <> null then
			
			if getParameterBool("linkScaling") then
				getParameterContainer ("container" & i).scaling = this.scaling
			end if
			
			if getParameterBool("linkPosition") then
				getParameterContainer ("container" & i).position = this.position
			end if
			
		end if
	next
end sub

sub onGeometryChanged (geom as Geometry)
	updateVis ()
end sub

sub updateVis ()
'	dim text as String = geometry.text
'	text.trim()
'	parentContainer.active = text <> ""
end sub
