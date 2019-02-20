Structure countdownItems
	daysLeft As integer
	hoursLeft As integer
	minutesLeft As integer
	dateIsInThePast As boolean
End Structure

Dim SECONDS_IN_A_DAY as Integer = 60 * 60 * 24
Dim DIMINEATA        as Integer = 2
dim REGEX_DDMMYYYY_HHMM   as String = "^\\d{2}\\.\\d{2}\\.20\\d{2}_\\d{2}:\\d{2}$"

' receives a dateString in the format dd.mm.yyyy_hh:mm

function returnCountDownToDate(dateString As String) As String
	Dim targetDateAndTime As Datetime = readTargetTime(dateString)
	Dim countdownData As countdownItems
	
	countdownData = getCountdown(targetDateAndTime)

	returnCountDownToDate = buildOutputString(countdownData)
end function

function buildOutputString(countdownData As countdownItems) as String 
	Dim outputString As String = ""
	
	If countdownData.dateIsInThePast Then
		buildOutputString = ""	
		Exit Function
	End If

	If countdownData.daysLeft > 0 Then
		outputString = maiSunt(countdownData.daysLeft)	& " " & numeralRo(countdownData.daysLeft, "zi", "zile")
	Elseif countdownData.hoursLeft >= 1 Then
		outputString = maiSunt(countdownData.hoursLeft) & " " & numeralRo (countdownData.hoursLeft, "oră", "ore") & " " & siMinute(countdownData.minutesLeft)
	Else			
		outputString = maiSunt(countdownData.minutesLeft) & " " & numeralRo(countdownData.minutesLeft, "minut", "minute")
	End If

	buildOutputString = outputString
End Function

function maiSunt (number as Integer) as String
	if number > 1 then
		maiSunt = "mai sunt"
	elseif number == 1 then
		maiSunt = "mai este"
	end if
end function	

function numeralRo (number as Integer, singular as String, plural as String) as String
	if number >= 20 then
		numeralRo = number & " de " & plural		
	elseif number == 1 then
		numeralRo = number & " " & singular		
	elseif number == 0 then
		numeralRo = ""		
	else
		numeralRo = number & " " & plural
	end if
end function

function siMinute (mins as Integer) as String
	siMinute = numeralRo (mins, "minut", "minute")
	if siMinute <> "" then
		siMinute = "şi " & siMinute
	end if
end function

function siNumeralRo (number as Integer, singular as String, plural as String) as String
	siNumeralRo = numeralRo (number, singular, plural)
	if siNumeralRo <> "" then
		siNumeralRo = "şi " & siNumeralRo
	end if
end function

function getCountdown(targetDateAndTime As Datetime) As countdownItems
	Dim tempCountdown As countdownItems
	Dim currentTime as DateTime = getCurrentTime()
	
	If currentTime.totalSeconds > targetDateAndTime.totalSeconds Then 
		tempCountdown.dateIsInThePast = true
		getCountdown = tempCountdown
		Exit Function
	End If

	Dim remainingSecs as Integer = targetDateAndTime.totalSeconds - currentTime.totalSeconds
	Dim daysRemaining as Integer = (Integer) Floor(remainingSecs / SECONDS_IN_A_DAY)
	Dim hoursRemaining As Integer = (Integer) Floor(remainingSecs / (60 * 60))
	Dim minutesRemaining As Integer = (Integer) ((remainingSecs / 60) mod 60)

	If currentTime.hour <= DIMINEATA Then
		daysRemaining += 1
	Elseif currentTime.hour = targetDateAndTime.hour And currentTime.minute >= targetDateAndTime.minute Then
		daysRemaining +=1
	Elseif currentTime.hour > targetDateAndTime.hour Then
		daysRemaining +=1
	End If
	
	tempCountdown.dateIsInThePast = false
	tempCountdown.daysLeft = daysRemaining 
	tempCountdown.hoursLeft = hoursRemaining 
	tempCountdown.minutesLeft = minutesRemaining		
	
	getCountdown = tempCountdown	
End Function

function readTargetTime(dateString As String) as DateTime
	If dateString.Match(REGEX_DDMMYYYY_HHMM) Then	
'                                                   20.09.2019_20:20
'													0123456789012345
		readTargetTime.year       = CInt(dateString.GetSubstring(6, 4))
		readTargetTime.month      = CInt(dateString.GetSubstring(3, 2))
		readTargetTime.dayOfMonth = CInt(dateString.GetSubstring(0, 2))
		readTargetTime.hour       = CInt(dateString.GetSubstring(11, 2))
		readTargetTime.minute     = CInt(dateString.GetSubstring(14, 2))
		readTargetTime.second     = 0
		readTargetTime.normalize()
	End If
end function
