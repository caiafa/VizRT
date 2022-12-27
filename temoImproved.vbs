dim BTN_SET_PARAMS as Integer = 1
dim BTN_SET_TRANSF as Integer = 2

sub onInit ()
	updateTexture ()
end sub

sub onInitParameters ()
	registerParameterInt ("cols"   , "Columns"     , 1, 1, 100)
	registerParameterInt ("rows"   , "Rows"        , 1, 1, 100)
	
	registerParameterDouble ("scaleX", "Scale X %", 100, -1000, 10000)
	registerParameterDouble ("scaleY", "Scale Y %", 100, -1000, 10000)
	
	registerParameterDouble ("shiftX", "Shift X %", 0, -100, 100)
	registerParameterDouble ("shiftY", "Shift Y %", 0, -100, 100)
	
	registerParameterInt ("showFrame", "Show Frame", 1, 1, 1000)
	
	registerParameterBool ("active", "Texture Active", true)
	
	registerPushButton ("getParameters"    , " Set parameters from container name"    , BTN_SET_PARAMS)
	registerPushButton ("setTransformation", " Set transformation from container name", BTN_SET_TRANSF)
end sub

sub onExecPerFiled ()
	'updateTexture ()
end sub

sub updateTexture ()
	dim maxTiles as Integer = max (getParameterInt("cols"), getParameterInt ("rows"))
	texture.mapScaling.x = getParameterInt("cols") * getParameterDouble("scaleX") / 100
	texture.mapScaling.y = getParameterInt("rows") * getParameterDouble("scaleY") / 100
		
	dim col as Integer = (getParameterInt ("showFrame") - 1) mod getParameterInt ("cols")
	dim row as Integer = (getParameterInt ("showFrame") - 1)  /  getParameterInt ("cols")
	
	dim shiftX as Double = - 10 * (getParameterDouble("scaleX") / 100 - 1) / 2 * getParameterDouble("shiftX") / 100
	dim shiftY as Double = - 10 * (getParameterDouble("scaleY") / 100 - 1) / 2 * getParameterDouble("shiftY") / 100
	

	
	texture.mapPosition.x = (cDbl(getParameterInt("cols") - 1) / 2 - col) * 10  * getParameterDouble("scaleX") / 100 + shiftX 
	texture.mapPosition.y = (cDbl(getParameterInt("rows") - 1) / 2 - row) * -10 * getParameterDouble("scaleY") / 100 + shiftY
	
	
	
	
	'texture.mapPosition.y = row * 10 + 5 - (getParameterInt("rows") / 2) * 10
	
end sub

sub onParameterChanged (parameterName as String)
	select case parameterName
		case "active"
			texture.active = getParameterBool("active")
			exit sub
		case "cols", "rows"
			updateGuiParameterIntDefMinMax ("showFrame", 1, 1, getParameterInt("cols") * getParameterInt("rows"))
		case "scaleX"
			'sendGuiStatus("shiftX", cInt(getParameterDouble("scaleX") > 100))
		case "scaleY"
			'sendGuiStatus("shiftY", cInt(getParameterDouble("scaleY") > 100))
	end select
	updateTexture ()
end sub

sub OnExecAction(buttonId As Integer)
	select case buttonId
		case BTN_SET_PARAMS
			setParamsFromString (this.name)
		case BTN_SET_TRANSF
			setTransformationFromString (this.name)
	end select
end sub

sub setParamsFromString (str as String)
	dim tileSize as Vertex = getTileSizeFromString (str)
		println (12, tileSize)	
	this.scriptPluginInstance.setParameterInt("cols", cInt(tileSize.x))
	this.scriptPluginInstance.setParameterInt("rows", cInt(tileSize.y))
end sub

function getTileSizeFromString (byVal str as String) as Vertex
	dim metadata    as String = getMetadataFromName (str)
	println (12, metadata)	
	dim tilesTouple as String = getNextParenContent(metadata)
	getTileSizeFromString     = parseTouple(tilesTouple)
'	dim parenPos as Integer = metadata.findLastOf("(")
'	if parenPos < 0 then
'		exit function
'	end if
'	
'	dim frames   as Integer = cInt(str.getSubstring(0, parenPos))
'	println (12, frames)	
end function

function getMetadataFromName (byVal str as String) as String
	println (str)
	dim underscorePos as Integer = str.findLastOf("_")
	if underscorePos < 0 then
		println (12, "Error! Naming pattern does not match")
		exit function
	end if
	str.replace(underscorePos, 1, "x")
	underscorePos = str.findLastOf("_")
	if underscorePos < 0 then
		println (12, "Error! Naming pattern does not match")
		exit function
	end if
		
	str.erase (0, underscorePos + 1)
	getMetadataFromName = str
end function

function getNextParenContent (byRef str as String) as String
	dim openParenPos  as Integer = str.find("(")
	dim closeParenPos as Integer = str.find(")")
	if openParenPos < 0 or closeParenPos < 0 then
		exit function
	end if
	getNextParenContent = str.getSubstring(openParenPos + 1, closeParenPos - openParenPos - 1)
	str.erase(0, closeParenPos + 1)
end function

function parseTouple (str as String) as Vertex
	str.makeLower()
	dim xPos as Integer = str.find ("x")
	if xPos < 0 then
		xPos = str.find ("-")
		if xPos < 0 then
			exit function
		end if
	end if
	parseTouple.x = cDbl(str.getSubstring(0, xPos))
	parseTouple.y = cDbl(str.getSubstring(xPos + 1, str.length - xPos - 1))
end function

sub setTransformationFromString (str as String)
	dim metadata as String = getMetadataFromName (str)
	
	getNextParenContent(metadata)
	
	dim sizeTouple as String = getNextParenContent(metadata)
	dim posTouple  as String = getNextParenContent(metadata)
	dim size       as Vertex = parseTouple(sizeTouple)
	dim pos        as Vertex = parseTouple(posTouple)
	
	this.setScreenSizeOrtho(cInt(size.x), cInt(size.y))
	this.recomputeMatrix ()
	this.setScreenPositionOrtho (cInt(pos.x), cInt(pos.y))
end sub
