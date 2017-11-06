sub OnInitParameters()
	RegisterParameterInt("targetDay", "Ziua", 24, 1, 31)
	RegisterParameterInt("targetMonth", "Luna", 2, 1, 12)
	RegisterParameterInt("targetYear", "Anul", 2016, 2017, 2050)
	RegisterPushButton("setDateButton", "Set to current date", 1)
end sub

sub OnParameterChanged(parameterName As String)
	checkDate()
end sub

sub OnExecAction(buttonId As Integer)
	if buttonId = 1 then
		dim currentDate as DateTime = GetCurrentTime()
		SendCommand("#" & this.VizId & "*SCRIPT*INSTANCE*targetDay SET " & currentDate.dayOfMonth)
		SendCommand("#" & this.VizId & "*SCRIPT*INSTANCE*targetMonth SET " & currentDate.month)
		SendCommand("#" & this.VizId & "*SCRIPT*INSTANCE*targetYear SET " & currentDate.year)
		checkDate()
	end if
end sub

Sub OnInit()
	checkDate()
End Sub

Sub checkDate()
	Dim timeHelper As datetime
	timeHelper = GetCurrentTime()
	timeHelper.DayOfMonth  = GetParameterInt("targetDay")
	timeHelper.Month   = GetParameterInt("targetMonth")
	timeHelper.Year  = GetParameterInt("targetYear")
	timeHelper.Normalize()

	If dateIsToday(timeHelper) Then 
		This.Geometry.Text  = Cstr(1)
	Else
		This.Geometry.Text = Cstr(0)
	End If
End Sub

Function dateIsToday(date As datetime) As Boolean
	Dim currentTime As Datetime
	currentTime = GetCurrentTime()
	
	If currentTime.DayOfYear = date.DayOfYear Then
		dateIsToday = true
	Else 
		dateIsToday = false
	End If
End Function
