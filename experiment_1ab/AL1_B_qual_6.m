obj.InitialSpeed = 13;
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
obj.NumVWMObjects = 6;
obj.NumVWMObjectPositions = 7;
obj.VWMObjectDistanceFactor = 6;
obj.VWMObjectDisplayTime = 0.6;
obj.VWMObjectColours = [0 255 0; 100 255 100; 50 255 50; 0 128 0; 64 128 64; 0 64 0; 32 128 32]';
