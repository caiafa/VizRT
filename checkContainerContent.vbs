sub onInit ()
	geometry.registerTextChangedCallback ()
end sub

sub OnGeometryChanged(geom As Geometry)
	active = geometry.text <> ""
end sub
