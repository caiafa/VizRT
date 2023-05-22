sub onInit ()
	geometry.registerTextChangedCallback ()
	updateText ()
end sub

sub onGeometryChanged (geom As Geometry)
	updateText ()
end sub

sub updateText ()
	dim text as String = geometry.text
	text.trim ()
	geometry.text = text
	for i = 0 to this.childContainerCount - 1
		this.getChildContainerByIndex(i).geometry.text = text
	next
end sub

sub OnInitParameters()
	RegisterInfoText("V 1.00 Copies the current container's text to all subcontainers.")
end sub
