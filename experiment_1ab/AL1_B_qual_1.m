obj.InitialSpeed = 10;
obj.doPractice = 1;
obj.doQuest = 1;
obj.doTest = 1;
obj.DotWidthScaleFactor = 1;
obj.MinSepScaleFactor = 2;
obj.DotWidth = round(obj.DotWidthScaleFactor/obj.DegPerPixel);
obj.MinSep = round(obj.MinSepScaleFactor/obj.DegPerPixel); 
obj.InterQuadrantPadding = obj.DotWidth/2;
obj.NumTrialsPerCondition = 40;
obj.TestConditionTypes = [...
    Condition.MOTvVWM Condition.FullField Condition.DualTask Condition.PerformTaskA Condition.VWMTask1st Condition.NA;...
];
obj.NumVWMObjects = 5;
obj.NumVWMObjectPositions = 10;
obj.VWMObjectDistanceFactor = 3;
obj.VWMObjectDisplayTime = 0.3;
