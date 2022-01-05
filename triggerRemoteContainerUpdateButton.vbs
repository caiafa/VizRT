sub onInit ()
	geometry.registerTextChangedCallback ()
end sub

sub OnGeometryChanged(geom As Geometry)
	triggerRemoteUpdate()
end sub

Sub OnInitParameters()
	RegisterParameterContainer("updateThis", "Push UPDATE on this container's script")
End Sub

Sub triggerRemoteUpdate()
	GetParameterContainer("updateThis").ScriptPluginInstance.PushButton("update")
End Sub

sub OnParameterChanged(parameterName As String)
	triggerRemoteUpdate()
end sub

