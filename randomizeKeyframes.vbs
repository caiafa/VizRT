Sub OnExecAction(buttonId As Integer)
	If buttonId == 1 Then
		exec()
	End If
End Sub

Sub exec()
	Dim kf As Array[Keyframe]
	Dim i As integer = 0
	Dim currentKFIndex As integer
	
	Stage.FindDirector("catAnimIn").GetKeyframes(kf)
	
	Do While kf.ubound <> -1 
		currentKFIndex = Random(kf.ubound)
		println currentKFIndex
		kf[currentKFIndex].Time = i * GetParameterDouble("TIME")
		println i*GetParameterDouble("TIME")
		kf.Erase(currentKFIndex)
		i++
	Loop
End Sub

Sub OnInitParameters()
	RegisterPushButton("RANDOM", "RANDOM", 1)
	RegisterParameterDouble("TIME", "TIME", 0.1, 0, 1)	
End Sub
