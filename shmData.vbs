dim VERSION as String = "2.3  |  Build:  2021.08.19 16:40"

dim SHM_TYPES               as Array[String]
	SHM_TYPES.push          ("Scene"        )
dim SHM_TYPE_SCENE          as Integer = SHM_TYPES.uBound
	SHM_TYPES.push          ("System/Global")
dim SHM_TYPE_SYSTEM         as Integer = SHM_TYPES.uBound
	SHM_TYPES.push          ("Distributed"  )
dim SHM_TYPE_DISTRIBUTED    as Integer = SHM_TYPES.uBound

dim OUTPUT_FORMATS          as Array[String]
	OUTPUT_FORMATS.push     ("String       ")
dim OUTPUT_FORMAT_STRING    as Integer = OUTPUT_FORMATS.uBound
	OUTPUT_FORMATS.push     ("Double"  )
dim OUTPUT_FORMAT_DOUBLE    as Integer = OUTPUT_FORMATS.uBound
	OUTPUT_FORMATS.push     ("Integer" )
dim OUTPUT_FORMAT_INTEGER   as Integer = OUTPUT_FORMATS.uBound
	OUTPUT_FORMATS.push     ("Bool"    )
dim OUTPUT_FORMAT_BOOL      as Integer = OUTPUT_FORMATS.uBound

	
dim PARAMETER_TYPES         as Array[String]
	PARAMETER_TYPES.push    ("Text         ")
dim PARAMETER_TYPE_TEXT     as Integer = PARAMETER_TYPES.uBound
	PARAMETER_TYPES.push    ("Geometry")
dim PARAMETER_TYPE_GEOMETRY as Integer = PARAMETER_TYPES.uBound
	PARAMETER_TYPES.push    ("Function")
dim PARAMETER_TYPE_FUNCTION as Integer = PARAMETER_TYPES.uBound
	PARAMETER_TYPES.push    ("Script")
dim PARAMETER_TYPE_SCRIPT   as Integer = PARAMETER_TYPES.uBound
	PARAMETER_TYPES.push    ("Scene"   )
dim PARAMETER_TYPE_SCENE    as Integer = PARAMETER_TYPES.uBound
	PARAMETER_TYPES.push    ("Scene Script"   )
dim PARAMETER_TYPE_SCENE_SCRIPT as Integer = PARAMETER_TYPES.uBound
	PARAMETER_TYPES.push    ("Active"  )
dim PARAMETER_TYPE_ACTIVE   as Integer = PARAMETER_TYPES.uBound
	PARAMETER_TYPES.push    ("Selector")
dim PARAMETER_TYPE_SELECTOR as Integer = PARAMETER_TYPES.uBound
	PARAMETER_TYPES.push    ("Material")
dim PARAMETER_TYPE_MATERIAL as Integer = PARAMETER_TYPES.uBound
	PARAMETER_TYPES.push    ("Object")
dim PARAMETER_TYPE_OBJECT   as Integer = PARAMETER_TYPES.uBound
	PARAMETER_TYPES.push    ("Image")
dim PARAMETER_TYPE_IMAGE    as Integer = PARAMETER_TYPES.uBound
	PARAMETER_TYPES.push    ("Property")
dim PARAMETER_TYPE_PROPERTY as Integer = PARAMETER_TYPES.uBound

dim TARGET_CONTAINERS       as Array[String]
	TARGET_CONTAINERS.push  ("Current"      )
dim CONTAINER_CURRENT       as Integer = TARGET_CONTAINERS.uBound
	TARGET_CONTAINERS.push  ("Parent"       )
dim CONTAINER_PARENT        as Integer = TARGET_CONTAINERS.uBound
	TARGET_CONTAINERS.push  ("GrParent"     )
dim CONTAINER_GR_PARENT     as Integer = TARGET_CONTAINERS.uBound
	TARGET_CONTAINERS.push  ("GrGrParent   ")
dim CONTAINER_GR_GR_PARENT  as Integer = TARGET_CONTAINERS.uBound
	TARGET_CONTAINERS.push  ("Previous"     )
dim CONTAINER_PREVIOUS      as Integer = TARGET_CONTAINERS.uBound
	TARGET_CONTAINERS.push  ("Next"         )
dim CONTAINER_NEXT          as Integer = TARGET_CONTAINERS.uBound
	TARGET_CONTAINERS.push  ("First"        )
dim CONTAINER_FIRST         as Integer = TARGET_CONTAINERS.uBound
	TARGET_CONTAINERS.push  ("Remote"       )
dim CONTAINER_REMOTE        as Integer = TARGET_CONTAINERS.uBound


dim STRING_CASES            as Array[String]
	STRING_CASES.push       ("None         ")
dim STRING_CASE_NONE        as Integer = STRING_CASES.uBound
	STRING_CASES.push       ("Lower"        )
dim STRING_CASE_LOWER       as Integer = STRING_CASES.uBound
	STRING_CASES.push       ("Upper"        )
dim STRING_CASE_UPPER       as Integer = STRING_CASES.uBound
	STRING_CASES.push       ("Proper"        )
dim STRING_CASE_PROPER      as Integer = STRING_CASES.uBound

	
'dim vertexFormat as Array[String]
'	vertexFormat.push(" X ")
'	vertexFormat.push(" Y ")
'	vertexFormat.push(" Z ")
'	vertexFormat.push(" X Y ")
'	vertexFormat.push(" X Z ")
'	vertexFormat.push(" Y Z ")
'	vertexFormat.push(" X Y Z ")

dim _rescaleParamA as Double
dim _rescaleParamB as Double

dim _shm           as SharedMemory = null
dim _shmKey        as String       = ""
	
 
dim _paramsReady   as Boolean      = false	






'--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
'                                                                                    ---   INIT, GUI & EVENTS  ---
'--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
sub onInitParameters ()
	registerInfoText ("Version: " & VERSION)
	
	registerRadioButton        ("shmType"        , "SHM Type"            , 0  , SHM_TYPES)
	registerParameterString    ("shmKey"         , "SHM Key"             , "" , 30, 64, "")
	
	registerRadioButton        ("targetContainer", "Target Container"    , 0, TARGET_CONTAINERS)
	registerParameterContainer ("remoteContainer", "    Remote Container")	
	
	registerRadioButton        ("parameterType"  , "Parameter Type"      , 0, PARAMETER_TYPES)
	
	registerParameterBool      ("hideOnEmpty"    , "Hide on empty"       , true)
	
	'registerRadioButton        ("vertexFormat"  , "Format"         , 0, vertexFormat)
	
	
	registerParameterString    ("propertyName"   , "Property Name"       , "" , 30, 64, "")
	registerParameterString    ("functionName"   , "Function Name"       , "" , 30, 64, "")
	registerParameterString    ("parameterName"  , "Parameter Name"      , "" , 30, 64, "")
	
	
	
	registerRadioButton        ("outputFormat"   , "Output Format"       , 0, OUTPUT_FORMATS)
	
	registerParameterInt       ("precision"      , "Precision"           , -1 , -1, 10)
	
	registerParameterBool      ("trim"           , "Trim"                , true)
	registerRadioButton        ("convertCase"    , "Convert Case"        , 0, STRING_CASES)
	
	
	registerParameterString    ("prefix"         , "Prefix"              , "" , 60, 128, "")
	registerParameterString    ("sufix"          , "Sufix"               , "" , 60, 128, "")
	
	
	
	
	registerParameterDouble ("dataMin" , "Data Min" , 0  , -100000, 100000)
	registerParameterDouble ("dataMax" , "Data Max" , 100, -100000, 100000)
	registerParameterDouble ("valueMin", "Value Min", 0  , -100000, 100000)
	registerParameterDouble ("valueMax", "Value Max", 100, -100000, 100000)
	registerParameterBool   ("clamp"   , "Clamp"    , true)
end sub

sub onInit ()
	
'	updateParameters ()
'	setSHM ()
'	updateValue ()
end sub


sub _updateGuiView ()
	sendGuiParameterShow ("remoteContainer", cInt(getParameterInt("targetContainer") == CONTAINER_REMOTE))
	
	select case getParameterInt("parameterType")
		case PARAMETER_TYPE_FUNCTION, PARAMETER_TYPE_SCENE
		
			sendGuiParameterShow ("functionName" , SHOW)
			sendGuiParameterShow ("parameterName", SHOW)
			sendGuiParameterShow ("propertyName" , HIDE)	
						
		case PARAMETER_TYPE_GEOMETRY, PARAMETER_TYPE_SCRIPT, PARAMETER_TYPE_SCENE_SCRIPT
		
			sendGuiParameterShow ("functionName" , HIDE)
			sendGuiParameterShow ("parameterName", SHOW)
			sendGuiParameterShow ("propertyName" , HIDE)
		
		case PARAMETER_TYPE_PROPERTY
	
			sendGuiParameterShow ("functionName" , HIDE)
			sendGuiParameterShow ("parameterName", SHOW)		
			sendGuiParameterShow ("propertyName" , SHOW)
			
		case else
			
			sendGuiParameterShow ("functionName" , HIDE)
			sendGuiParameterShow ("parameterName", HIDE)
			sendGuiParameterShow ("propertyName" , HIDE)		
		
	end select
	
	
	sendGuiParameterShow ("hideOnEmpty", cInt(getParameterInt("parameterType") == PARAMETER_TYPE_TEXT))
	sendGuiParameterShow ("trim"       , cInt(getParameterInt("outputFormat") == OUTPUT_FORMAT_STRING))
	
	sendGuiParameterShow ("precision"  , cInt(getParameterInt("outputFormat") == OUTPUT_FORMAT_DOUBLE))
	
	select case getParameterInt ("outputFormat")
		case OUTPUT_FORMAT_STRING
			sendGuiParameterShow ("dataMin" , HIDE)
			sendGuiParameterShow ("dataMax" , HIDE)
			sendGuiParameterShow ("valueMin", HIDE)
			sendGuiParameterShow ("valueMax", HIDE)
			sendGuiParameterShow ("clamp"   , HIDE)
			
			sendGuiParameterShow ("convertCase", SHOW)
			
		case else
			sendGuiParameterShow ("dataMin" , SHOW)
			sendGuiParameterShow ("dataMax" , SHOW)
			sendGuiParameterShow ("valueMin", SHOW)
			sendGuiParameterShow ("valueMax", SHOW)
			sendGuiParameterShow ("clamp"   , SHOW)
			
			sendGuiParameterShow ("convertCase", HIDE)
	end select	
	
	
	select case getParameterInt("parameterType")
		case PARAMETER_TYPE_TEXT, PARAMETER_TYPE_MATERIAL, PARAMETER_TYPE_OBJECT, PARAMETER_TYPE_IMAGE
		
			sendGuiParameterShow ("prefix", SHOW)
			sendGuiParameterShow ("sufix" , SHOW)		
			
		case else
		
			if getParameterInt("outputFormat") == OUTPUT_FORMAT_STRING then
				sendGuiParameterShow ("prefix", SHOW)
				sendGuiParameterShow ("sufix" , SHOW)		
			else
				sendGuiParameterShow ("prefix", HIDE)
				sendGuiParameterShow ("sufix" , HIDE)
			end if
					
	end select

end sub


sub onSharedMemoryVariableChanged (map as SharedMemory, mapKey as String)

	updateValue ()
	
end sub


sub onParameterChanged (parameterName as String)
	if not _paramsReady and parameterName <> "clamp" then
		exit sub
	else
		_paramsReady = true
		_registerChangedCallback ()
		_updateRescaleParams ()
	end if


	_updateGuiView ()
	
	select case parameterName
		case "shmKey", "shmType"
		
			_registerChangedCallback ()
			
		case "dataMin", "dataMax", "valueMin", "valueMax"
		
			_updateRescaleParams ()
			
		case else
			
	end select
	
	updateValue ()

end sub

sub _updateRescaleParams ()
	_rescaleParamA = (getParameterDouble("valueMax") - getParameterDouble("valueMin")) / (getParameterDouble("dataMax") - getParameterDouble("dataMin"))
	_rescaleParamB =  getParameterDouble("valueMax") - _rescaleParamA * getParameterDouble("dataMax")
end sub



'--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
'                                                                                    ^^^   INIT, GUI & EVENTS  ^^^
'--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------






'--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
'                                                                                   					 ---   SHARED MEMORY  ---
'--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
sub _unregisterChangedCallback ()
	if _shmKey <> "" and _shm <> null then
		_shm.unregisterChangedCallback(_shmKey)
		_shmKey = ""
		_shm    = null
	end if
end sub

sub _registerChangedCallback ()
	_unregisterChangedCallback ()
	
	_shm    = _getSHM ()
	_shmKey = getParameterString("shmKey")	
	
	if _shmKey <> "" then
		_shm.registerChangedCallback(_shmKey)
	end if
end sub

function _getSHM () as SharedMemory
	select case getParameterInt("shmType")
		case SHM_TYPE_SCENE
		
			_getSHM = Scene.Map
			
		case SHM_TYPE_SYSTEM
		
			_getSHM = System.Map
			
		case SHM_TYPE_DISTRIBUTED
		
			_getSHM = VizCommunication.Map
			
	end select
end function
'--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
'                                                                                   					 ^^^   SHARED MEMORY   ^^^
'--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------







'--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
'                                                                                   					 ---   VALUE GETTERS   ---
'--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function getValue () as Variant
	select case getParameterInt("outputFormat")
		case OUTPUT_FORMAT_STRING
		
			getValue = _getStringValue ()
			
		case OUTPUT_FORMAT_DOUBLE
		
			getValue = _getDoubleValue ()
			
		case OUTPUT_FORMAT_INTEGER
		
			getValue = _getIntValue ()
			
		case OUTPUT_FORMAT_BOOL
		
			getValue = _getBoolValue ()
			
	end select
end function


function _getStringValue() as String
	_getStringValue = cStr(_shm[_shmKey])
	
	if getParameterBool ("trim") then
		_getStringValue.trim()
	end if
	
	_getStringValue = _convertCase(_getStringValue, getParameterInt("convertCase"))
	
	'_getStringValue = getParameterString("prefix") & _getStringValue & getParameterString("sufix")
end function



function _getDoubleValue () as Double
	_getDoubleValue = _getDoubleValue(cDbl(_shm[_shmKey]))
end function

function _getDoubleValue (data as Double) as Double
'	if getParameterBool("clamp") then
'		data = max(getParameterDouble("dataMin"), min(getParameterDouble("dataMax"), data))
'	end if
	_getDoubleValue = _rescaleParamA * data + _rescaleParamB
	
	if getParameterBool("clamp") then
		_getDoubleValue = max(getParameterDouble("valueMin"), min(getParameterDouble("valueMax"), _getDoubleValue))
	end if
	
	if getParameterInt ("precision") >= 0 then
		_getDoubleValue = cDbl(doubleToString(_getDoubleValue, getParameterInt("precision")))
	end if
end function

function _getIntValue () as Integer
	_getIntValue = cInt(_getDoubleValue())
end function

function _getBoolValue () as Boolean
	_getBoolValue = cBool(_getIntValue())
end function




function _getTargetContainer () as Container
	select case getParameterInt ("targetContainer")
		case CONTAINER_CURRENT

			_getTargetContainer = this
			
		case CONTAINER_PARENT
		
			_getTargetContainer = this.parentContainer
			
		case CONTAINER_GR_PARENT
		
			if this.parentContainer <> null then
				_getTargetContainer = this.parentContainer.parentContainer
			end if
			
		case CONTAINER_GR_GR_PARENT

			if this.parentContainer <> null then
				if this.parentContainer.parentContainer <> null then
					_getTargetContainer = this.parentContainer.parentContainer.parentContainer
				end if
			end if
			
		case CONTAINER_PREVIOUS
		
			_getTargetContainer = this.previousContainer
			
		case CONTAINER_NEXT
		
			_getTargetContainer = this.nextContainer
			
		case CONTAINER_FIRST
			
			_getTargetContainer = this
			do while _getTargetContainer.previousContainer <> null
				_getTargetContainer = _getTargetContainer.previousContainer
			loop
			
		case CONTAINER_REMOTE

			_getTargetContainer = getParameterContainer ("remoteContainer")
			
	end select
end function
'--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
'                                                                                   					 ^^^   VALUE GETTERS   ^^^
'--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


function _convertCase (byVal text as String, targetCase as Integer) as String
	select case targetCase
		case STRING_CASE_UPPER
			text.makeUpper ()
			
		case STRING_CASE_LOWER
			text.makeLower ()
			
		case STRING_CASE_PROPER
			text = _toProperCase (text)
			
		case else
			'do nothing
	end select
	
	_convertCase = text
end function

'Proper case is any text that is written with each of the first letters of every word being capitalized.
'For example, "This Is An Example Of Proper Case." is an example of sentence in proper case.
'Tip: Proper case should not be confused with Title case, which is most of the words being capitalized.
function _toProperCase (byVal text as String) as String
	dim makeUpper as Boolean = true
	dim char      as String
	
	for i = 0 to text.length - 1
		char = text.getChar(i)
		select case char
			case " ", "\t", "\n", ".", "?"						
				makeUpper = true				
			case else				
				if makeUpper then					
					char.makeUpper()					
					makeUpper = false
				else
					char.makeLower()
				end if
				
				text.replaceChar (i, char)
		end select
	next
	_toProperCase = text
end function





'--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
'                                                                                   					 ---   VALUE SETTERS   ---
'--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

sub updateValue ()
	dim targetContainer as Container = _getTargetContainer()
	
	select case getParameterInt("parameterType")	
		case PARAMETER_TYPE_TEXT
		
			_updateTextValue (targetContainer)
			
		case PARAMETER_TYPE_GEOMETRY
		
			_updateGeometryValue (targetContainer)
			
		case PARAMETER_TYPE_FUNCTION
		
			_updateFunctionPluginValue (targetContainer)
			
		case PARAMETER_TYPE_SCRIPT
		
			_setPluginValue (targetContainer.scriptPluginInstance)
			
		case PARAMETER_TYPE_SCENE
		
			_updateScenePluginValue ()
			
		case PARAMETER_TYPE_ACTIVE
		
			_updateActiveValue (targetContainer)
			
		case PARAMETER_TYPE_SELECTOR
		
			_updateSelectorValue (targetContainer)
			
		case PARAMETER_TYPE_MATERIAL
			
			_updateMaterialValue (targetContainer)
			
		case PARAMETER_TYPE_OBJECT
		
			_updateObjectValue (targetContainer)
			
		case PARAMETER_TYPE_IMAGE
		
			_updateImageValue (targetContainer)
			
		case PARAMETER_TYPE_PROPERTY
			
			_updatePropertyValue (targetContainer)
	end select	
	
end sub



sub _updateTextValue (targetContainer as Container)
	dim value as String = getValue()
	
	if getParameterInt("outputFormat") == OUTPUT_FORMAT_DOUBLE then
		if getParameterInt ("precision") >= 0 then
			value = doubleToString(cDbl(getValue()), getParameterInt("precision"))
		end if
	end if
	
	targetContainer.geometry.text = getParameterString("prefix") & value & getParameterString("sufix")
	
	_hideOnEmpty (targetContainer)
	
end sub


sub _hideOnEmpty (targetContainer as Container)
	if not getParameterBool ("hideOnEmpty") then
		exit sub
	end if
	
	select case getParameterInt("outputFormat")
		case OUTPUT_FORMAT_STRING
		
			dim value as String = getValue()
			value.trim()
			targetContainer.active = value <> ""
			
		case else
			
			_updateActiveValue (targetContainer)
			
	end select
end sub

sub _updateActiveValue (targetContainer as Container)
	targetContainer.active = cBool(getValue())
end sub

sub _updateGeometryValue (targetContainer as Container)
	_setPluginValue (targetContainer.getGeometryPluginInstance())
end sub

sub _updateFunctionPluginValue (targetContainer as Container)
	_setPluginValue (targetContainer.getFunctionPluginInstance (getParameterString("functionName")))
end sub

sub _updateScenePluginValue ()
	_setPluginValue (Scene.getScenePluginInstance (getParameterString("functionName")))
end sub

sub _updatePropertyValue (targetContainer as Container)
	dim value         as String = getValue()
	dim property      as String = getParameterString("propertyName")
	dim parameterName as String = getParameterString("parameterName")
	parameterName.trim()
	if parameterName.length > 0 then
		property &= "*" & parameterName
	end if
	dim command as String = "#" & targetContainer.vizId & "*" & property & " SET " & value
	println (12, "command: " & command)
	System.sendCommand (command)
end sub

sub _setPluginValue (pi as PluginInstance)
	'println (9, pi.PluginName)
	select case getParameterInt("outputFormat")
		case OUTPUT_FORMAT_STRING
			
			pi.setParameterString(getParameterString("parameterName"), getParameterString("prefix") & _getStringValue() & getParameterString("sufix"))
			
		case OUTPUT_FORMAT_DOUBLE
		
			pi.setParameterDouble(getParameterString("parameterName"), _getDoubleValue())
			
		case OUTPUT_FORMAT_INTEGER
		
			pi.setParameterInt(getParameterString("parameterName"), _getIntValue())
			
		case OUTPUT_FORMAT_BOOL
		
			pi.setParameterBool(getParameterString("parameterName"), _getBoolValue())
			
	end select
end sub

sub _updateSelectorValue (targetContainer as Container)
	targetContainer.showOneChildContainer (cInt(getValue()))
	select case getParameterInt("outputFormat")
		case OUTPUT_FORMAT_STRING
		
			dim value as String = getValue()
			value.trim()			
			targetContainer.showOneChildContainer (cInt(value <> ""))
			
		case else
			
			targetContainer.showOneChildContainer (cInt(getValue()))
			
	end select
end sub

sub _updateMaterialValue (targetContainer as Container)
	dim value as String = getPrefixSufixValue ()
	targetContainer.createMaterial (value)
end sub

sub _updateObjectValue (targetContainer as Container)
	dim value as String = getPrefixSufixValue ()
	targetContainer.CreateGeometry (value)
end sub

sub _updateImageValue (targetContainer as Container)
	dim value as String = getPrefixSufixValue ()
	targetContainer.createTexture (value)
end sub

function getPrefixSufixValue () as String
	getPrefixSufixValue = getParameterString("prefix") & cStr(getValue()) & getParameterString("sufix")
end function

'--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
'                                                                                   					 ^^^   VALUE SETTERS   ^^^
'--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
