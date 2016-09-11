session_config.debug = 0;
session_config.InitialSpeed = 17;
session_config.doPractice = 0;
session_config.doTest = 1;
session_config.DotWidthScaleFactor = 0.5;
session_config.MinSepScaleFactor = 0.5;
session_config.NumTrialsPerCondition = 16;
session_config.NumPracticeTrialsPerCondition = 4;
session_config.NumVWMObjects = 5;
session_config.NumMOTObjects = 10;
session_config.NumMOTTargets = 5;
session_config.TestConditionTypes = [Condition.PerformMOT Condition.PerformVWM Condition.PerformBoth Condition.PerformBoth];

StartSession('ML1_5', session_config);