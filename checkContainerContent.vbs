sub onInit ()
	geometry.registerTextChangedCallback ()
end sub

sub OnGeometryChanged(geom As Geometry)
	if geometry.text <> "" then
		active = true
	else
		active = false
	end if
end sub
