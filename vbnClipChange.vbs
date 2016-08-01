sub onInit ()
	geometry.registerTextChangedCallback ()
	update ()
end sub

sub onInitParameters ()
	registerDirSelector        ("clipsPath"    , "Clips Folder", "D:/Clips/videoWall/vremea2015/")
	registerParameterContainer ("clipContainer", "Clip Container")
end sub

sub update ()
	dim path as String = getParameterString("clipsPath")
	path.substitute("\\", "/", true)
	if not path.endsWith("/") then
		path &= "/"
	end if
	path &= geometry.text
	if not System.directoryExists(path) then
		'println ("<" & path & ">")
		exit sub
	end if
	dim c as Container = getParameterContainer ("clipContainer")
	dim imageClip as PluginInstance = c.getFunctionPluginInstance("imageClip")
	if imageClip == null then
		exit sub
	end if
	dim currentPath as String = imageClip.getParameterString("imageLoadFileName")
	currentPath.substitute("\\", "/", true)
	path &= "/" & geometry.text & "_000.vbn"
	if currentPath <> path then
		imageClip.setParameterString("imageLoadFileName", path)
	end if
end sub

sub onGeometryChanged (geom As Geometry)
	update ()
end sub

