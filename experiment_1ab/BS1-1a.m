obj.InitialSpeed = 5;
obj.doPractice = 1;
obj.doQuest = 1;
obj.doTest = 0;
obj.DotWidthScaleFactor = 1;
obj.MinSepScaleFactor = 2;
obj.DotWidth = round(obj.DotWidthScaleFactor/obj.DegPerPixel);
obj.MinSep = round(obj.MinSepScaleFactor/obj.DegPerPixel); 
obj.InterQuadrantPadding = obj.DotWidth/2;
obj.NumPracticeTrialsPerCondition = 20;
