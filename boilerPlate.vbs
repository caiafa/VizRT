'--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
'                                                                                    ---   CONSOLE LOGGING VARS  ---
'--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
dim LOG_LEVELS      as Array[String]
	LOG_LEVELS.push (" Trace ")
	LOG_LEVELS.push (" Debug ")
	LOG_LEVELS.push (" Info ")
	LOG_LEVELS.push (" WARNING ")
	LOG_LEVELS.push (" ERROR ")
	LOG_LEVELS.push (" OFF ")
	
dim LOG_COLORS      as Array[Integer]
	LOG_COLORS.push (5)
	LOG_COLORS.push (4)
	LOG_COLORS.push (9)
	LOG_COLORS.push (13)
	LOG_COLORS.push (12)
	
dim LOG_TRACE       as Integer = 0
dim LOG_DEBUG       as Integer = 1
dim LOG_INFO        as Integer = 2
dim LOG_WARNING     as Integer = 3
dim LOG_ERROR       as Integer = 4

dim LOG_EVENT_NAMES as Array[String]
    LOG_EVENT_NAMES.push ("logMessage")
	LOG_EVENT_NAMES.push ("logEvent")

dim _prevLogTime    as Double
dim _timers         as StringMap
'--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
'                                                                                    ^^^   CONSOLE LOGGING VARS  ^^^
'--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
'libs
dim _utils          as Container = parentContainer.findSiblingSubContainer ("utils")

'----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
'																				---   INIT, GUI & EVENTS   ---
'----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
sub onInitParameters ()

	'logging
	Eventpool.registerEvents ("logManager", LOG_EVENT_NAMES)
	registerRadioButton      ("logLevel"  , "Log Level", LOG_INFO, LOG_LEVELS)
end sub

'--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
'                                                                                    ---   CONSOLE LOGGING METHODS  ---
'--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
sub log (level as Integer, message as Variant)
	if level >= getParameterInt ("logLevel") then
		dim output as String = LOG_LEVELS[level]
		output.trim()
		output &= ": " & this.name & " @ " & getCurrentTime().toString()
		
		if getParameterInt ("logLevel") <= LOG_DEBUG then
			output &= " deltaT: " & _secondsToReadableTime (System.getElapsedTime() - _prevLogTime)
			_prevLogTime = System.getElapsedTime()
		end if
		
		output &= "\n\n" & cStr(message) & "\n"
		
		println (LOG_COLORS[level], output)
		
		if level >= LOG_INFO then
		
			dim args as StringMap
			args["level"    ] = level
			args["message"  ] = message
			args["container"] = this
			
			Eventpool.emitEvent ("logMessage", args)
		end if
	end if
end sub

' otuput example: 1d 15h 24m 32s 160ms 133.77ns
function _secondsToReadableTime (seconds as Double) as String	
	dim minutes  as Integer = seconds / 60
	dim hours    as Integer = minutes / 60
	dim days     as Integer = hours / 24
	dim miliSecs as Double  = (seconds - cInt(seconds)) * 1000
		
	if days > 0 then
		_secondsToReadableTime &= days & "d " 
	end if
	
	if hours > 0 then
		_secondsToReadableTime &= intToString (hours   mod 24, 2, true) & "h " 
	end if
	
	if minutes > 0 then
		_secondsToReadableTime &= intToString (minutes mod 60, 2, true) & "m "
	end if
	
	if cInt(seconds) > 0 then
		_secondsToReadableTime &= intToString (cInt(seconds) mod 60, 2, true) & "s " 
	end if
	
	_secondsToReadableTime &= intToString (cInt(miliSecs) , 3, true) & "ms "
	
	_secondsToReadableTime &= doubleToString ((miliSecs - cInt(miliSecs)) * 1000, 2, 6) & "ns"
end function

sub timerStart (timerKey as Variant)
	_timers[cStr(timerKey)] = System.getElapsedTime()
end sub

'timers can only be stopped once; a stopped timer has a negative value, while a started one has a positive value
function timerStop (timerKey as Variant) as Boolean
	if _timers.containsKey (cStr(timerKey)) then
		if cDbl(_timers[cStr(timerKey)]) > 0 then
			_timers[cStr(timerKey)] = cDbl(_timers[cStr(timerKey)]) - System.getElapsedTime()
			timerStop = true
		end if
	end if
end function


function timerGetElapsed (timerKey as Variant) as Double
	if _timers.containsKey (cStr(timerKey)) then
		if cDbl(_timers[cStr(timerKey)]) > 0 then
			timerGetElapsed = System.getElapsedTime() - cDbl(_timers[cStr(timerKey)])
		else
			timerGetElapsed = abs(cDbl(_timers[cStr(timerKey)]))
		end if
	end if
end function

function timerGetElapsedReadable (timerKey as Variant) as String
	timerGetElapsedReadable = _secondsToReadableTime (timerGetElapsed(timerKey))
end function

function timerIsRunning (timerKey as Variant) as Boolean
	if _timers.containsKey (cStr(timerKey)) then
		if cDbl(_timers[cStr(timerKey)]) > 0 then
			timerIsRunning = true
		end if
	end if
end function
'--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
'                                                                                    ^^^   CONSOLE LOGGING METHODS  ^^^
'--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------




