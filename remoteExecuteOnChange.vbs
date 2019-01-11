Dim targetContainer As Container

sub onInit()
	geometry.registerTextChangedCallback()
end sub

sub onInitParameters ()
	RegisterInfoText("Runs the remoteExecuteOnChange() function in the script \nassigned to the dispach container on text change.")
	registerParameterContainer ("dispachContainer", "Dispach container")
end sub	

sub OnParameterChanged(parameterName As String)
	targetContainer = GetParameterContainer("dispachContainer")
end sub

sub OnGeometryChanged(geom As Geometry)
	targetContainer.Script.remoteExecuteOnChange()
end sub

