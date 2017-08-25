sub onInitParameters ()
	registerParameterBool   ("active"   , "Active"         , true)
	registerParameterString ("separator", "Split separator", ",", 9, 128, "")
	registerParameterDouble ("width"    , "Width"          , 500, 0, 99999)
	registerParameterDouble ("height"   , "Height"         , 200, 0, 99999)
end sub

sub onInit ()
	geometry.registerTextChangedCallback()
	updateText ()
end sub


function isValidWidht () as Boolean
	isValidWidht = getBoundingBoxDimensions().x <= getParameterDouble ("width") 
	'println ("<" & geometry.text & ">")
	'println ("width: " & getBoundingBoxDimensions().x & " -> " & isValidWidht)
end function

function isValidHeight () as Boolean
	isValidHeight = getBoundingBoxDimensions().y <= getParameterDouble ("height") 
	'println ("height: " & getBoundingBoxDimensions().y & " -> " & isValidHeight)
end function

sub updateText ()
	active = geometry.text <> ""
	previousContainer.active = active
	
	if not getParameterBool("active") then
		exit sub
	end if
	
	if isValidWidht() and isValidHeight() then
		exit sub
	end if
	
	dim text         as String  = geometry.text
	dim separator    as String  = getParameterString("separator")
	'println ("\n\ntext: " & text)
	'println ("separator: " & separator)
	dim separatorPos as Integer = text.find(separator)
	if separatorPos == -1 then
		exit sub
	end if
	
	dim validText   as String  = ""
	dim textChunck  as String  = ""
	do while text.length > 0
		'println ("separatorPos: " & separatorPos)
		if separatorPos >= 0 then
			textChunck   = text.left(separatorPos)
			text.erase(0, separatorPos + separator.length)
			separatorPos = text.find(separator)
		else
			textChunck = text
			text = ""
		end if
		
		'println ("textChunck: " & textChunck)
		'println ("validText:\n" & validText & "\n---") 
		if validText <> "" then
			geometry.text = validText & separator & textChunck
		else
			geometry.text = textChunck
		end if
		'TODO check if recompute matrix is needed
		if not isValidWidht() then
			validText.trim ()
			textChunck.trim ()
			geometry.text = validText & "\n" & textChunck
		end if
		
		'TODO check if recompute matrix is needed
		if isValidWidht() then
			if isValidHeight () then
				validText = geometry.text
			else
				geometry.text = validText
				'exit sub
			end if
		else
			geometry.text = validText
			'exti sub
		end if
	loop
end sub

sub onGeometryChanged(geom As Geometry)
	updateText()
end sub

sub onParameterChanged(parameterName As String)
	updateText()
end sub




