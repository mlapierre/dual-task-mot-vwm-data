session_config.debug = 0;
session_config.InitialSpeed = 20;
session_config.doPractice = 0;
session_config.doTest = 1;
session_config.DotWidthScaleFactor = 0.5;
session_config.MinSepScaleFactor = 1;
session_config.NumTrialsPerCondition = 16;
session_config.NumPracticeTrialsPerCondition = 4;
session_config.NumVWMObjects = 4;
session_config.NumMOTObjects = 10;
session_config.NumMOTTargets = 5;
session_config.VWMObjectDisplayTime = 0.1;
session_config.session_num = 2;
session_config.TestConditionTypes = [Condition.PerformBoth Condition.PerformMOT Condition.PerformVWM Condition.PerformBoth];

num_blocks = 1;

StartSession('SS1_2', session_config, num_blocks);