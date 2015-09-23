Dim centerPoints As Array[string]
centerPoints.push("Top Left")
centerPoints.push("Top Right")
centerPoints.push("Bottom Left")
centerPoints.push("Bottom Right")
centerPoints.push("Center")

Sub OnInit()
	This.Geometry.RegisterChangedCallback()
	move()
End Sub

Sub OnGeometryChanged(geom as Geometry)
	move()
End Sub

Sub OnInitParameters()
	RegisterParameterInt("dX","X", 960, 0, 1920)
	RegisterParameterInt("dY","Y", 540, 0, 1080)
	RegisterRadioButton("centerPoint", "CENTER", 4, centerPoints)
End Sub

Sub move()
	Dim dX, dY As Integer
	Dim centerPoint As Integer
	Dim transformInput As Vertex
	
	centerPoint = GetParameterInt("centerPoint")
	
	Select Case centerPoint
	Case 0
		SendCommand("#" & this.VizId & "*TRANSFORMATION*CENTER*Y SET T")
		SendCommand("#" & this.VizId & "*TRANSFORMATION*CENTER*X SET L")
	Case 1
		SendCommand("#" & this.VizId & "*TRANSFORMATION*CENTER*Y SET T")
		SendCommand("#" & this.VizId & "*TRANSFORMATION*CENTER*X SET R")
	Case 2
		SendCommand("#" & this.VizId & "*TRANSFORMATION*CENTER*Y SET B")
		SendCommand("#" & this.VizId & "*TRANSFORMATION*CENTER*X SET L")
	Case 3
		SendCommand("#" & this.VizId & "*TRANSFORMATION*CENTER*Y SET B")
		SendCommand("#" & this.VizId & "*TRANSFORMATION*CENTER*X SET R")
	Case 4
		SendCommand("#" & this.VizId & "*TRANSFORMATION*CENTER*Y SET C")
		SendCommand("#" & this.VizId & "*TRANSFORMATION*CENTER*X SET C")
	End Select
	
	dX = GetParameterInt("dX")
	dY = GetParameterInt("dY")
	
	transformInput = ScreenToRendererPosition(dX, dY)
	
	This.Position.xyz = This.ScreenPosToLocalPos(transformInput.x, transformInput.y)
End Sub

Sub OnParameterChanged(parameterName As String)
	move()
End Sub

Function ScreenToRendererPosition(x As Integer, y As Integer) As Vertex
	Dim xHD, yHD, xC, yC As Integer
	
	xHD  = System.RenderEditorWidth
	yHD  = System.RenderEditorHeight
	xC   = System.RenderWindowWidth
	yC   = System.RenderWindowHeight
	
	ScreenToRendererPosition.x = cInt((x*cInt(xC))/cInt(xHD))
	ScreenToRendererPosition.y = cInt((y*cInt(yC))/cInt(yHD))
End Function
