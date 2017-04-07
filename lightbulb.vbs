Sub switch(status As boolean)
	FindSubContainer("OFF").Active = not status	
	FindSubContainer("ON").Active = status
End Sub

Sub OnInitParameters()
	RegisterParameterBool("onoff", "LIGHTS", FALSE)
End Sub

Sub OnParameterChanged(parameterName As String)
	switch(GetParameterBool("onoff"))
End Sub
