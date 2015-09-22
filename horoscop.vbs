Dim SYMBOLS_PATH As string = "/GLOBALS/IMAGES/HOROSCOPE/protv2015/"
Dim counter As integer = 0
Dim zodiiList As array[zodiac]
Dim zodie As zodiac
Dim ZODIE_START As string = "zodieStart"
Dim currentZodie As Integer
Dim CURRENT_ZODIE As Container
Dim NEXT_ZODIE As Container
Dim CURRENT_NAME As Container
Dim NEXT_NAME As Container

Structure zodiac
	nume 		As string
	inceput 	As datetime 
	symbol		As string
	index		As integer
End Structure

Sub OnSharedMemoryVariableChanged(map As SharedMemory, mapKey As String)
	If mapKey == ZODIE_START Then
		populateZodii()
		
		CURRENT_ZODIE.CreateTexture(SYMBOLS_PATH & zodiiList[currentZodie mod 12 - 1].symbol)
		NEXT_ZODIE.CreateTexture(SYMBOLS_PATH & zodiiList[(currentZodie+1) mod 12 - 1].symbol)
		CURRENT_NAME.Geometry.Text = zodiiList[currentZodie mod 12 - 1].nume
		NEXT_NAME.Geometry.Text =  zodiiList[(currentZodie+1) mod 12 - 1].nume
	End If
End Sub

Sub OnInitParameters()
	RegisterPushButton("INIT", "INIT", 2)
	RegisterPushButton("NEXT", "NEXT", 1)
	RegisterPushButton("CHANGE", "CHANGE", 3)
	RegisterPushButton("RESTART", "RESTART", 4)
End Sub

Sub nextZodie()
	NEXT_ZODIE.CreateTexture(SYMBOLS_PATH & zodiiList[(currentZodie+1) mod 12 - 1].symbol)	
	NEXT_NAME.Geometry.Text =  zodiiList[(currentZodie+1) mod 12 - 1].nume	
End Sub

Sub changeCurrent()
	currentZodie++
	CURRENT_ZODIE.CreateTexture(SYMBOLS_PATH & zodiiList[currentZodie mod 12 - 1].symbol)
	CURRENT_NAME.Geometry.Text = zodiiList[currentZodie mod 12 - 1].nume
End Sub

Sub init()
	CURRENT_ZODIE = This.NextContainer.FindSubContainer("CURRENT_ZODIE")
	NEXT_ZODIE = This.NextContainer.FindSubContainer("NEXT_ZODIE")
	CURRENT_NAME = This.NextContainer.FindSubContainer("CURRENT_NAME")
	NEXT_NAME = This.NextContainer.FindSubContainer("NEXT_NAME")
	
	Scene.Map.RegisterChangedCallback (ZODIE_START)

	initZodii()
	populateZodii()
	
	CURRENT_ZODIE.CreateTexture(SYMBOLS_PATH & zodiiList[currentZodie mod 12 - 1].symbol)
	NEXT_ZODIE.CreateTexture(SYMBOLS_PATH & zodiiList[(currentZodie+1) mod 12 - 1].symbol)
	CURRENT_NAME.Geometry.Text = zodiiList[currentZodie mod 12 - 1].nume
	NEXT_NAME.Geometry.Text =  zodiiList[(currentZodie+1) mod 12 - 1].nume
End Sub

Sub populateZodii()
	Dim avemZodie As boolean = false
	Dim zodieStartUpp As string = CStr(Scene.Map["zodieStart"])
	Dim zodieStartLow As string = CStr(Scene.Map["zodieStart"])

	Dim currentDate As datetime 	= GetCurrentTime()
	zodieStartUpp.MakeUpper()
	zodieStartLow.MakeLower()
	
	currentZodie = 1
	
	For Each element In zodiiList
		If element.nume == zodieStartUpp Or element.symbol == zodieStartLow Or element.index = CInt(Scene.Map["zodieStart"]) Then
			avemZodie = true
			Exit For
		Else
			currentZodie++
		End If
	Next
	
	If avemZodie == false Then
		currentZodie = 0
		
		For Each element In zodiiList
			If element.inceput.TotalSeconds < currentDate.TotalSeconds Then
				currentZodie++
			Else
				Exit For
			End If
		Next
	End If
	
End Sub

Sub initZodii()
	Dim utilityDate As datetime 	= GetCurrentTime()
	
	utilityDate.Hour = 0
	utilityDate.Minute = 0

	utilityDate.DayOfMonth = 20
	utilityDate.Month 				   = 1
	zodie.nume 					   = "VĂRSĂTOR"
	zodie.inceput 					   = utilityDate
	zodie.symbol					   = "varsator"
	zodie.index 					   = 11
	zodiiList.Push(zodie)
	
	utilityDate.DayOfMonth = 19
	utilityDate.Month 				   = 2
	zodie.nume 					   = "PEŞTI"
	zodie.inceput 					   = utilityDate
	zodie.symbol					   = "pesti"
	zodie.index 					   = 12
	zodiiList.Push(zodie)

	utilityDate.DayOfMonth = 21
	utilityDate.Month 			           = 3
	zodie.nume 					   = "BERBEC"
	zodie.inceput 					   = utilityDate
	zodie.symbol					   = "berbec"
	zodie.index 					   = 1
	zodiiList.Push(zodie)

	utilityDate.DayOfMonth = 21
	utilityDate.Month 					=	4
	zodie.nume 					   = "TAUR"
	zodie.inceput 					   = utilityDate
	zodie.symbol					   = "taur"
	zodie.index 					   = 2
	zodiiList.Push(zodie)
	
	utilityDate.DayOfMonth = 21
	utilityDate.Month 					=	5
	zodie.nume 					   = "GEMENI"
	zodie.inceput 					   = utilityDate
	zodie.symbol					   = "gemeni"
	zodie.index 					   = 3
	zodiiList.Push(zodie)
	
	utilityDate.DayOfMonth = 22
	utilityDate.Month 					=	6
	zodie.nume 					   = "RAC"
	zodie.inceput 					   = utilityDate
	zodie.symbol					   = "rac"
	zodie.index 					   = 4
	zodiiList.Push(zodie)

	utilityDate.DayOfMonth = 23
	utilityDate.Month 					=	7
	zodie.nume 					   = "LEU"
	zodie.inceput 					   = utilityDate
	zodie.symbol					   = "leu"
	zodie.index 					   = 5
	zodiiList.Push(zodie)

	utilityDate.DayOfMonth = 23
	utilityDate.Month 					=	8
	zodie.nume 					   = "FECIOARĂ"
	zodie.inceput 					   = utilityDate
	zodie.symbol					   = "fecioara"
	zodie.index 					   = 6
	zodiiList.Push(zodie)
	
	utilityDate.DayOfMonth = 23
	utilityDate.Month 					=	9
	zodie.nume 					   = "BALANŢĂ"
	zodie.inceput 					   = utilityDate
	zodie.symbol					   = "balanta"
	zodie.index 					   = 7
	zodiiList.Push(zodie)
	
	utilityDate.DayOfMonth = 23
	utilityDate.Month 					=	10
	zodie.nume 					   = "SCORPION"
	zodie.inceput 					   = utilityDate
	zodie.symbol					   = "scorpion"
	zodie.index 					   = 8
	zodiiList.Push(zodie)

	utilityDate.DayOfMonth = 22
	utilityDate.Month 					=	11
	zodie.nume 					   = "SĂGETĂTOR"
	zodie.inceput 					   = utilityDate
	zodie.symbol					   = "sagetator"
	zodie.index 					   = 9
	zodiiList.Push(zodie)

	utilityDate.DayOfMonth = 21
	utilityDate.Month 					=	12
	utilityDate.Year      += utilityDate.Year
	zodie.nume 					   = "CAPRICORN"
	zodie.inceput 					   = utilityDate
	zodie.symbol					   = "capricorn"
	zodie.index 					   = 10
	zodiiList.Push(zodie)
End Sub

Sub OnExecAction(buttonId As Integer)
	If buttonId == 1 Then
		nextZodie()
	Elseif buttonId == 2 Then
		init()
	Elseif buttonId == 3 Then
		changeCurrent()
	Elseif buttonId == 4 Then
		GetDirector().Show(GetDirector().FindKeyframe("IN").Time)
		GetDirector().ContinueAnimation()
	End If
End Sub
