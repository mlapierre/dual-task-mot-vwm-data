obj.InitialSpeed = 24;
obj.doPractice = 1;
obj.doQuest = 0;
obj.doTest = 1;
obj.DotWidthScaleFactor = 0.8;
obj.MinSepScaleFactor = 1.6;
obj.DotWidth = round(obj.DotWidthScaleFactor/obj.DegPerPixel);
obj.MinSep = round(obj.MinSepScaleFactor/obj.DegPerPixel); 
obj.InterQuadrantPadding = obj.DotWidth/2;
obj.NumTrialsPerCondition = 20;
obj.NumPracticeTrialsPerCondition = 4;
obj.TestConditionTypes = [...
    Condition.MOTvVWM Condition.FullField Condition.DualTask Condition.PerformBoth Condition.VWMTask1st Condition.MOTResponse1st;...
    Condition.MOTvVWM Condition.FullField Condition.DualTask Condition.PerformBoth Condition.VWMTask1st Condition.VWMResponse1st;...
    Condition.MOTvVWM Condition.FullField Condition.DualTask Condition.PerformTaskA Condition.VWMTask1st Condition.NA;...
    Condition.MOTvVWM Condition.FullField Condition.DualTask Condition.PerformTaskB Condition.VWMTask1st Condition.NA;...
    Condition.MOTvVWM Condition.FullField Condition.DualTask Condition.PerformTaskB Condition.VWMTask1st Condition.NA;...
    Condition.MOTvVWM Condition.FullField Condition.DualTask Condition.PerformTaskA Condition.VWMTask1st Condition.NA;...
    Condition.MOTvVWM Condition.FullField Condition.DualTask Condition.PerformBoth Condition.VWMTask1st Condition.VWMResponse1st;...
    Condition.MOTvVWM Condition.FullField Condition.DualTask Condition.PerformBoth Condition.VWMTask1st Condition.MOTResponse1st;...
];
obj.NumVWMObjects = 5;
obj.NumVWMObjectPositions = 7;
obj.VWMObjectDistanceFactor = 6;
obj.VWMObjectDisplayTime = 0.4;
obj.VWMObjectColours = [0 255 0; 100 255 100; 50 255 50; 0 128 0; 64 128 64; 0 64 0; 32 128 32]';
