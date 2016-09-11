obj.InitialSpeed = 25;
obj.doPractice = 0;
obj.doQuest = 0;
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
obj.NumVWMObjects = 7;
obj.NumVWMObjectPositions = 10;
obj.VWMObjectDistanceFactor = 2.9;
obj.VWMObjectDisplayTime = 0.2;
