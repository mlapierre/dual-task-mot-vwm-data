ConfigurePath();

session_config.debug = 0;
session_config.InitialSpeed = 16;
session_config.doPractice = 1;
session_config.doTest = 1;
session_config.DotWidthScaleFactor = 0.6;
session_config.MinSepScaleFactor = 1.2;
session_config.NumTrialsPerCondition = 16;
session_config.NumPracticeTrialsPerCondition = 4;
session_config.NumVWMObjects = 4;
session_config.NumMOTObjects = 10;
session_config.NumMOTTargets = 5;
session_config.VWMObjectDisplayTime = 0.1;
session_config.TestConditionTypes = [Condition.PerformBoth Condition.PerformMOT Condition.PerformVWM Condition.PerformBoth];
session_config.VWMObjectColours = [255 0 0; 0 255 0; 255 255 0; 0 0 255; 0 255 255]';
session_config.session_num = 4;
num_blocks = 1;
data_set = 1;

StartSession('AS1', session_config, num_blocks, data_set);