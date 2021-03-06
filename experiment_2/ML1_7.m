session_config.debug = 0;
session_config.InitialSpeed = 15;
session_config.doPractice = 0;
session_config.doTest = 1;
session_config.DotWidthScaleFactor = 0.6;
session_config.MinSepScaleFactor = 0.6;
session_config.NumTrialsPerCondition = 16;
session_config.NumPracticeTrialsPerCondition = 4;
session_config.NumVWMObjects = 5;
session_config.NumMOTObjects = 10;
session_config.NumMOTTargets = 5;
session_config.VWMObjectDisplayTime = 0.1;
session_config.session_num = 17;
session_config.TestConditionTypes = [Condition.PerformMOT Condition.PerformVWM Condition.PerformBoth Condition.PerformBoth];

StartSession('ML1_8', session_config);