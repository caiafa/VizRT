dim MAX_FONTS as Integer = 2

sub onInitParameters()
	registerParameterInt ("fontSelector", "Font Selector", 0, 0, MAX_FONTS - 1)
	
	for i = 1 to MAX_FONTS
		registerParameterString ("fontPath" & i, "Font Path " & i, "", 60, 128, "")
	next

	registerInfoText ("Schimbă fontul tuturor subcontainerelor în funcţie de valoarea variabilei fontSelector")       
end sub

sub onParameterChanged (parameterName as String)
	select case parameterName
		case "fontSelector"
			setFont(getParameterString("fontPath" & (getParameterInt("fontSelector")) + 1))
	end select
end sub

sub setFont (fontName as String)
	dim containers as Array[Container]
	getContainerAndSubContainers (containers, True)
	
	for each container in containers
		if isFontContainer(container) then
			System.sendCommand("#" & container.geometry.vizId & "*FONT SET FONT*" & fontName & "-" & getFontWeight(container.geometry))
		end if
	next
end sub

function isFontContainer (c as Container) as Boolean
	if c.geometry == null then
		exit function
	end if
	if c.geometry.name == "TEXT" then
		isFontContainer = true
	end if
end function

function getFontWeight (g as Geometry) as String
	dim fontName    as String  = System.sendCommand ("#" & g.vizId & "*FONT*NAME GET")
	dim lastDashPos as Integer = fontName.findLastOf("-")
	if lastDashPos == -1 then
		exit function
	end if
	getFontWeight = fontName.getSubstring(lastDashPos + 1, fontName.length - lastDashPos - 1)
end function
