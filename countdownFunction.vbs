Structure countdown
	daysLeft As Integer
End Structure

Function countdownCalculator(targetTime As Datetime, cutoffHour As Integer) As countdown
	Dim now As Datetime
	Dim tmpCD As Countdown
	
	now = GetCurrentTime()
	
	If now.Hour < cutoffHour Then
		now.DayOfYear -= 1
	End If
	
	If targetTime.Hour < cutoffHour Then
		targetTime.DayOfYear -= 1
	End If
	
	tmpCD.daysLeft = targetTime.DayOfYear - now.DayOfYear
	countdownCalculator = tmpCD
End Function
