clear all;
numSessions = 1;
blocksPerSession = 8;
conditions = 4;
trialsPerBlock = 10; % Blocks are shown twice, the 2nd time in reverse
trialsPerConditionPerSession = 20; % Thus there are 2 blocks per condition
trialsPerCondition = trialsPerConditionPerSession;
totalBlocks = blocksPerSession*numSessions;
binSize = 10;
showGraphs = 1;
showInf = 1;

fn{1} = 'PDC1-1c_14-Feb-2012_MOT_VWM_FF_1_0.0.2_Session_1.mat';

for sess = 1:numSessions
    load(fn{sess});
    trialTime(sess) = (endTime-startTime)/60;
    
    [MOT, VWM, condition(:,sess)] = getCorrectByCondition(obj.TestResults, blocksPerSession, trialsPerBlock);

    MOTCorrect(:,:,sess) = MOT.Correct;
    MOTValidProbe(:,:,sess) = MOT.ValidProbe;
    VWMCorrect(:,:,sess) = VWM.Correct;
    VWMValidProbe(:,:,sess) = VWM.ValidProbe;
end

for cond = 1:size(condition,1)/2
  condIdx(:,cond) = find(strcmp(condition, condition{cond,1}));
  if strcmp(condition(cond,1), 'MOT-Only')
      MOTCorrectByCondition(:, cond) = reshape(MOTCorrect(:, condIdx(:,cond)), trialsPerConditionPerSession*numSessions, 1);
      MOTValidProbeByCondition(:, cond) = reshape(MOTValidProbe(:, condIdx(:,cond)), trialsPerConditionPerSession*numSessions, 1);
  elseif strcmp(condition(cond,1), 'VWM-Only')
      VWMCorrectByCondition(:, cond) = reshape(VWMCorrect(:, condIdx(:,cond)), trialsPerConditionPerSession*numSessions, 1);
      VWMValidProbeByCondition(:, cond) = reshape(VWMValidProbe(:, condIdx(:,cond)), trialsPerConditionPerSession*numSessions, 1);
  elseif strcmp(condition(cond,1), 'MOTResFirst')
      MOTCorrectByCondition(:, cond) = reshape(MOTCorrect(:, condIdx(:,cond)), trialsPerConditionPerSession*numSessions, 1);
      MOTValidProbeByCondition(:, cond) = reshape(MOTValidProbe(:, condIdx(:,cond)), trialsPerConditionPerSession*numSessions, 1);
      VWMCorrectByCondition(:, cond) = reshape(VWMCorrect(:, condIdx(:,cond)), trialsPerConditionPerSession*numSessions, 1);
      VWMValidProbeByCondition(:, cond) = reshape(VWMValidProbe(:, condIdx(:,cond)), trialsPerConditionPerSession*numSessions, 1);
  elseif strcmp(condition(cond,1), 'VWMResFirst')
      MOTCorrectByCondition(:, cond) = reshape(MOTCorrect(:, condIdx(:,cond)), trialsPerConditionPerSession*numSessions, 1);
      MOTValidProbeByCondition(:, cond) = reshape(MOTValidProbe(:, condIdx(:,cond)), trialsPerConditionPerSession*numSessions, 1);
      VWMCorrectByCondition(:, cond) = reshape(VWMCorrect(:, condIdx(:,cond)), trialsPerConditionPerSession*numSessions, 1);
      VWMValidProbeByCondition(:, cond) = reshape(VWMValidProbe(:, condIdx(:,cond)), trialsPerConditionPerSession*numSessions, 1);
  end
end

MOTMeansOverall = mean(MOTCorrectByCondition);
VWMMeansOverall = mean(VWMCorrectByCondition);

% Is there a significant difference between single-task and dual-task 
% performance for the MOT or VWM tasks?

% Given the categorical dependent variable (success/failure in tracking/recognition), 
% perform logistic regression with task (single/dual) as the categorical predictor. 
% Do this for each type of task (MOT/VWM)

% MOT-Only vs MOTResFirst, MOT performance
% Predictor: dual-task (single task coded as 0, dual-task coded as 1)

group = [zeros(trialsPerConditionPerSession*numSessions,1); ones(trialsPerConditionPerSession*numSessions,1)];
xMOT_Only = MOTCorrectByCondition(:, find(strcmp(condition(:,1), 'MOT-Only'),1));
xMOT_MOTResFirst = MOTCorrectByCondition(:, find(strcmp(condition(:,1), 'MOTResFirst'),1));
xMOT_VWMResFirst = MOTCorrectByCondition(:, find(strcmp(condition(:,1), 'VWMResFirst'),1));
xVWM_Only = VWMCorrectByCondition(:, find(strcmp(condition(:,1), 'VWM-Only'),1));
xVWM_MOTResFirst = VWMCorrectByCondition(:, find(strcmp(condition(:,1), 'MOTResFirst'),1));
xVWM_VWMResFirst = VWMCorrectByCondition(:, find(strcmp(condition(:,1), 'VWMResFirst'),1));
motOnlyIdx = find(strcmp(condition(:,1), 'MOT-Only'),1);
motResFirstIdx = find(strcmp(condition(:,1), 'MOTResFirst'),1);
vwmOnlyIdx = find(strcmp(condition(:,1), 'VWM-Only'),1);
vwmResFirstIdx = find(strcmp(condition(:,1), 'VWMResFirst'),1);

calcMOT_VWM_1;