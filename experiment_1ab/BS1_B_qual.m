obj.InitialSpeed = 28;
obj.doPractice = 1;
obj.doQuest = 0;
obj.doTest = 0;
obj.DotWidthScaleFactor = 1;
obj.MinSepScaleFactor = 2;
obj.DotWidth = round(obj.DotWidthScaleFactor/obj.DegPerPixel);
obj.MinSep = round(obj.MinSepScaleFactor/obj.DegPerPixel); 
obj.InterQuadrantPadding = obj.DotWidth/2;
obj.NumVWMObjects = 6;
obj.NumPracticeTrialsPerCondition = 40;
obj.PracticeConditionTypes = [...
    Condition.MOTvVWM Condition.FullField Condition.DualTask Condition.PerformTaskA Condition.VWMTask1st Condition.NA;...
];
