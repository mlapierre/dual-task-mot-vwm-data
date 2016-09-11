obj.InitialSpeed = 11;
obj.doPractice = 1;
obj.doQuest = 0;
obj.doTest = 1;
obj.DotWidthScaleFactor = 1;
obj.MinSepScaleFactor = 2;
obj.DotWidth = round(obj.DotWidthScaleFactor/obj.DegPerPixel);
obj.MinSep = round(obj.MinSepScaleFactor/obj.DegPerPixel); 
obj.InterQuadrantPadding = obj.DotWidth/2;
obj.NumTrialsPerCondition = 20;
obj.TestConditionTypes = [...
    Condition.MOTvVWM Condition.FullField Condition.DualTask Condition.PerformBoth Condition.VWMTask1st Condition.MOTResponse1st;...
    Condition.MOTvVWM Condition.FullField Condition.DualTask Condition.PerformTaskA Condition.VWMTask1st Condition.NA;...
    Condition.MOTvVWM Condition.FullField Condition.DualTask Condition.PerformTaskB Condition.VWMTask1st Condition.NA;...
    Condition.MOTvVWM Condition.FullField Condition.DualTask Condition.PerformBoth Condition.VWMTask1st Condition.VWMResponse1st;...
    Condition.MOTvVWM Condition.FullField Condition.DualTask Condition.PerformBoth Condition.VWMTask1st Condition.VWMResponse1st;...
    Condition.MOTvVWM Condition.FullField Condition.DualTask Condition.PerformTaskB Condition.VWMTask1st Condition.NA;...
    Condition.MOTvVWM Condition.FullField Condition.DualTask Condition.PerformTaskA Condition.VWMTask1st Condition.NA;...
    Condition.MOTvVWM Condition.FullField Condition.DualTask Condition.PerformBoth Condition.VWMTask1st Condition.MOTResponse1st;...
];
