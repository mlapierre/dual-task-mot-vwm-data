session_config.debug = 0;
session_config.InitialSpeed = 14;
session_config.doPractice = 1;
session_config.doTest = 1;
session_config.DotWidthScaleFactor = 0.6;
session_config.MinSepScaleFactor = 0.8;
session_config.NumTrialsPerCondition = 16;
session_config.NumPracticeTrialsPerCondition = 4;
session_config.NumVWMObjects = 5;
session_config.NumMOTObjects = 10;
session_config.NumMOTTargets = 5;
session_config.VWMObjectDisplayTime = 0.1;
session_config.session_num = 5;
session_config.TestConditionTypes = [Condition.PerformBoth Condition.PerformMOT Condition.PerformVWM Condition.PerformBoth];
session_config.VWMObjectColours = [255 0 0; 0 255 0; 255 255 0; 0 0 255; 0 255 255; 128 64 0; 255 0 255; 128 0 255; 255 128 0; 128 128 64]';
num_blocks = 4;

StartSession('ZST1_2', session_config, num_blocks);