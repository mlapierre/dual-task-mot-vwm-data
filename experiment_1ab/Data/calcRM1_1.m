%clear all;
numSessions = 11;
blocksPerSession = 8;
conditions = 4;
trialsPerBlock = 20; % Blocks are shown twice, the 2nd time in reverse
trialsPerConditionPerSession = 40; % Thus there are 2 blocks per condition
trialsPerCondition = trialsPerConditionPerSession;
totalBlocks = blocksPerSession*numSessions;
binSize = 20;
showGraphs = 0;
showInf = 1;

fn{1} = 'RM1-1_07-Feb-2012_MOT_VWM_FF_1_0.0.2_Session_1.mat';
fn{2} = 'RM1-2_08-Feb-2012_MOT_VWM_FF_1_0.0.2_Session_1.mat';
fn{3} = 'RM1-3_09-Feb-2012_MOT_VWM_FF_1_0.0.2_Session_1.mat';
fn{4} = 'RM1-4_09-Feb-2012_MOT_VWM_FF_1_0.0.2_Session_1.mat';
fn{5} = 'RM1-5_10-Feb-2012_MOT_VWM_FF_1_0.0.2_Session_1.mat';
fn{6} = 'RM1-6_13-Feb-2012_MOT_VWM_FF_1_0.0.2_Session_1.mat';
fn{7} = 'RM1-7_21-Feb-2012_MOT_VWM_FF_1_0.0.2_Session_1.mat';
fn{8} = 'RM1-8_27-Feb-2012_MOT_VWM_FF_1_0.0.2_Session_1.mat';
fn{9} = 'RM1-9_05-Mar-2012_MOT_VWM_FF_1_0.0.2_Session_1.mat';
fn{10} = 'RM1-10_09-Mar-2012_MOT_VWM_FF_1_0.0.2_Session_1.mat';
fn{11} = 'RM1-11_02-Apr-2012_MOT_VWM_FF_1_0.0.2_Session_1.mat';

trialTime = zeros(numSessions);
condition = {};
MOTCorrect = zeros(trialsPerBlock, blocksPerSession, numSessions);
MOTValidProbe = zeros(trialsPerBlock, blocksPerSession, numSessions);
VWMCorrect = zeros(trialsPerBlock, blocksPerSession, numSessions);
VWMValidProbe = zeros(trialsPerBlock, blocksPerSession, numSessions);
for sess = 1:numSessions
    load(fn{sess});
    trialTime(sess) = (endTime-startTime)/60;
    
    [MOT, VWM, condition(:,sess)] = getCorrectByCondition(obj.TestResults, blocksPerSession, trialsPerBlock);

    MOTCorrect(:,:,sess) = MOT.Correct;
    MOTValidProbe(:,:,sess) = MOT.ValidProbe;
    VWMCorrect(:,:,sess) = VWM.Correct;
    VWMValidProbe(:,:,sess) = VWM.ValidProbe;
end

MOTCorrectByCondition = zeros(trialsPerConditionPerSession*numSessions, conditions);
MOTValidProbeByCondition = zeros(trialsPerConditionPerSession*numSessions, conditions);
VWMCorrectByCondition = zeros(trialsPerConditionPerSession*numSessions, conditions);
VWMValidProbeByCondition = zeros(trialsPerConditionPerSession*numSessions, conditions);
condIdx = zeros(numSessions*2, conditions);
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

% 
% disp('MOT performance');
% disp('MOT-Only vs MOTResFirst');
% disp('logistic regression analysis');
% [b,dev,stats] = glmfit(group, [xMOT_Only; xMOT_MOTResFirst], 'binomial');
% disp(sprintf('coef: %f\np: %f\n', stats.beta(2), stats.p(2)));
% 
% disp('paired sample t-test');
% [h,p] = ttest(xMOT_Only, xMOT_MOTResFirst);
% disp(sprintf('h: %d, p: %f\n',h,p));
% 
% disp('unpaired two-sample t-test');
% [h,p] = ttest2(xMOT_Only, xMOT_MOTResFirst);
% disp(sprintf('h: %d, p: %f\n',h,p));
% 
% % Is there a significant difference between single-task and dual-task
% % performance when the VWM response is made first.
% disp('MOT-Only vs VWMResFirst');
% disp('logistic regression analysis');
% [b,dev,stats] = glmfit(group, [xMOT_Only; xMOT_VWMResFirst], 'binomial');
% disp(sprintf('b: %f\np: %f\n', stats.beta(2), stats.p(2)));
% 
% disp('paired sample t-test');
% [h,p] = ttest(xMOT_Only, xMOT_VWMResFirst);
% disp(sprintf('h: %d, p: %f\n',h,p));
% 
% disp('unpaired two-sample t-test');
% [h,p] = ttest2(xMOT_Only, xMOT_VWMResFirst);
% disp(sprintf('h: %d, p: %f\n',h,p));
% 
% 
% disp('VWM performance');
% % VWM-Only vs MOTResFirst, VWM performance
% disp('VWM-Only vs MOTResFirst');
% disp('logistic regression analysis');
% [b,dev,stats] = glmfit(group, [xVWM_Only; xVWM_MOTResFirst], 'binomial');
% disp(sprintf('b: %f\np: %f\n', stats.beta(2), stats.p(2)));
% 
% disp('paired sample t-test');
% [h,p] = ttest(xVWM_Only, xVWM_MOTResFirst);
% disp(sprintf('h: %d, p: %f\n',h,p));
% 
% disp('unpaired two-sample t-test');
% [h,p] = ttest2(xVWM_Only, xVWM_MOTResFirst);
% disp(sprintf('h: %d, p: %f\n',h,p));
% 
% % VWM-Only vs VWMResFirst, VWM performance
% disp('VWM-Only vs VWMResFirst');
% disp('logistic regression analysis');
% [b,dev,stats] = glmfit(group, [xVWM_Only; xVWM_VWMResFirst], 'binomial');
% disp(sprintf('b: %f\np: %f\n', stats.beta(2), stats.p(2)));
% 
% disp('paired sample t-test');
% [h,p] = ttest(xVWM_Only, xVWM_VWMResFirst);
% disp(sprintf('h: %d, p: %f\n',h,p));
% 
% disp('unpaired two-sample t-test');
% [h,p] = ttest2(xVWM_Only, xVWM_VWMResFirst);
% disp(sprintf('h: %d, p: %f\n',h,p));
% 
% if showGraphs == 1
%     figure;
%     x = [1 2 3 4 5 6];
%     y = [mean(xMOT_Only) mean(xMOT_MOTResFirst) mean(xMOT_VWMResFirst) mean(xVWM_Only) mean(xVWM_MOTResFirst) mean(xVWM_VWMResFirst)];
%     err = [stm(xMOT_Only)*1.96 stm(xMOT_MOTResFirst)*1.96 stm(xMOT_VWMResFirst)*1.96 stm(xVWM_Only)*1.96 stm(xVWM_MOTResFirst)*1.96 stm(xVWM_VWMResFirst)*1.96];
%     bar(x,y);
%     hold all;
%     h = errorbar(x,y,err);
%     set(h,'linestyle','none');
%     set(gca,'XTickLabel',{'Single', 'MOTResFirst', 'VWMResFirst', 'Single', 'MOTResFirst', 'VWMResFirst'});
%     title('Mean number of targets tracked/remembered per condition (raw percentages)');
% end
% 
% % Perform the same tests as above, but use the corrections for guessing used by Zhang et al. and
% % Fougnie & Marois
% 
% % I don't have multiple subjects, so instead I'll divide the data into bins and derive the relevant
% % statistics from those bins.
% 
% % E.g., after 4 sessions I have 160 observations per condition. These observations can be split into
% % 8 bins if each bin contains 20 observations. I can then treat each bin as the other researchers
% % treated each individual subject. Of course I'll also need to account for the fact that I'm not
% % actually using single subjects. It may be better to do this experiment as a regular experiment
% % with a group of participants.
% 
% % for each bin
% %   calculate Zhang's K & M
% %   calculate the means & sds of K & M values
% % input the K & M values into t-tests as above
% 
% for i = 1:(numSessions*trialsPerConditionPerSession)/binSize
%     hrMOT_Only(i) = getHR(MOTCorrectByCondition((i-1)*binSize+1:i*binSize, motOnlyIdx), MOTValidProbeByCondition((i-1)*binSize+1:i*binSize, motOnlyIdx));
%     crMOT_Only(i) = getCR(MOTCorrectByCondition((i-1)*binSize+1:i*binSize, motOnlyIdx), MOTValidProbeByCondition((i-1)*binSize+1:i*binSize, motOnlyIdx));
%     hrMOT_MOTResFirst(i) = getHR(MOTCorrectByCondition((i-1)*binSize+1:i*binSize, motResFirstIdx), MOTValidProbeByCondition((i-1)*binSize+1:i*binSize, motResFirstIdx));
%     crMOT_MOTResFirst(i) = getCR(MOTCorrectByCondition((i-1)*binSize+1:i*binSize, motResFirstIdx), MOTValidProbeByCondition((i-1)*binSize+1:i*binSize, motResFirstIdx));
%     hrMOT_VWMResFirst(i) = getHR(MOTCorrectByCondition((i-1)*binSize+1:i*binSize, vwmResFirstIdx), MOTValidProbeByCondition((i-1)*binSize+1:i*binSize, vwmResFirstIdx));
%     crMOT_VWMResFirst(i) = getCR(MOTCorrectByCondition((i-1)*binSize+1:i*binSize, vwmResFirstIdx), MOTValidProbeByCondition((i-1)*binSize+1:i*binSize, vwmResFirstIdx));
%     hrVWM_Only(i) = getHR(VWMCorrectByCondition((i-1)*binSize+1:i*binSize, vwmOnlyIdx), VWMValidProbeByCondition((i-1)*binSize+1:i*binSize, vwmOnlyIdx));
%     crVWM_Only(i) = getCR(VWMCorrectByCondition((i-1)*binSize+1:i*binSize, vwmOnlyIdx), VWMValidProbeByCondition((i-1)*binSize+1:i*binSize, vwmOnlyIdx));
%     hrVWM_MOTResFirst(i) = getHR(MOTCorrectByCondition((i-1)*binSize+1:i*binSize, motResFirstIdx), MOTValidProbeByCondition((i-1)*binSize+1:i*binSize, motResFirstIdx));
%     crVWM_MOTResFirst(i) = getCR(MOTCorrectByCondition((i-1)*binSize+1:i*binSize, motResFirstIdx), MOTValidProbeByCondition((i-1)*binSize+1:i*binSize, motResFirstIdx));
%     hrVWM_VWMResFirst(i) = getHR(MOTCorrectByCondition((i-1)*binSize+1:i*binSize, vwmResFirstIdx), MOTValidProbeByCondition((i-1)*binSize+1:i*binSize, vwmResFirstIdx));
%     crVWM_VWMResFirst(i) = getCR(MOTCorrectByCondition((i-1)*binSize+1:i*binSize, vwmResFirstIdx), MOTValidProbeByCondition((i-1)*binSize+1:i*binSize, vwmResFirstIdx));
%     llhrMOT_Only(i) = LLHR(MOTCorrectByCondition((i-1)*binSize+1:i*binSize, motOnlyIdx), MOTValidProbeByCondition((i-1)*binSize+1:i*binSize, motOnlyIdx));
%     llfrMOT_Only(i) = LLFR(MOTCorrectByCondition((i-1)*binSize+1:i*binSize, motOnlyIdx), MOTValidProbeByCondition((i-1)*binSize+1:i*binSize, motOnlyIdx));
%     llhrMOT_MOTResFirst(i) = LLHR(MOTCorrectByCondition((i-1)*binSize+1:i*binSize, motResFirstIdx), MOTValidProbeByCondition((i-1)*binSize+1:i*binSize, motResFirstIdx));
%     llfrMOT_MOTResFirst(i) = LLFR(MOTCorrectByCondition((i-1)*binSize+1:i*binSize, motResFirstIdx), MOTValidProbeByCondition((i-1)*binSize+1:i*binSize, motResFirstIdx));
%     llhrMOT_VWMResFirst(i) = LLHR(MOTCorrectByCondition((i-1)*binSize+1:i*binSize, vwmResFirstIdx), MOTValidProbeByCondition((i-1)*binSize+1:i*binSize, vwmResFirstIdx));
%     llfrMOT_VWMResFirst(i) = LLFR(MOTCorrectByCondition((i-1)*binSize+1:i*binSize, vwmResFirstIdx), MOTValidProbeByCondition((i-1)*binSize+1:i*binSize, vwmResFirstIdx));
%     llhrVWM_Only(i) = LLHR(VWMCorrectByCondition((i-1)*binSize+1:i*binSize, vwmOnlyIdx), VWMValidProbeByCondition((i-1)*binSize+1:i*binSize, vwmOnlyIdx));
%     llfrVWM_Only(i) = LLFR(VWMCorrectByCondition((i-1)*binSize+1:i*binSize, vwmOnlyIdx), VWMValidProbeByCondition((i-1)*binSize+1:i*binSize, vwmOnlyIdx));
%     llhrVWM_MOTResFirst(i) = LLHR(MOTCorrectByCondition((i-1)*binSize+1:i*binSize, motResFirstIdx), MOTValidProbeByCondition((i-1)*binSize+1:i*binSize, motResFirstIdx));
%     llfrVWM_MOTResFirst(i) = LLFR(MOTCorrectByCondition((i-1)*binSize+1:i*binSize, motResFirstIdx), MOTValidProbeByCondition((i-1)*binSize+1:i*binSize, motResFirstIdx));
%     llhrVWM_VWMResFirst(i) = LLHR(MOTCorrectByCondition((i-1)*binSize+1:i*binSize, vwmResFirstIdx), MOTValidProbeByCondition((i-1)*binSize+1:i*binSize, vwmResFirstIdx));
%     llfrVWM_VWMResFirst(i) = LLFR(MOTCorrectByCondition((i-1)*binSize+1:i*binSize, vwmResFirstIdx), MOTValidProbeByCondition((i-1)*binSize+1:i*binSize, vwmResFirstIdx));
% 
%     xZM_MOT_Only(:,i) = ZhangM(4, llhrMOT_Only(i), 1-llfrMOT_Only(i));
%     xMOT_Only_RawMean(:,i) = mean(MOTCorrectByCondition((i-1)*binSize+1:i*binSize, motOnlyIdx));
%     xZM_MOT_MOTResFirst(:,i) = ZhangM(4, llhrMOT_MOTResFirst(i), 1-llfrMOT_MOTResFirst(i));
%     xMOT_MOTResFirst_RawMean(:,i) = mean(MOTCorrectByCondition((i-1)*binSize+1:i*binSize, motResFirstIdx));
%     xZM_MOT_VWMResFirst(:,i) = ZhangM(4, llhrMOT_VWMResFirst(i), 1-llfrMOT_VWMResFirst(i));
%     xMOT_VWMResFirst_RawMean(:,i) = mean(MOTCorrectByCondition((i-1)*binSize+1:i*binSize, vwmResFirstIdx));
%     xZK_VWM_Only(:,i) = ZhangK(4, llhrVWM_Only(i), 1-llfrVWM_Only(i));
%     xVWM_Only_RawMean(:,i) = mean(VWMCorrectByCondition((i-1)*binSize+1:i*binSize, vwmOnlyIdx));
%     xZK_VWM_MOTResFirst(:,i) = ZhangK(4, llhrVWM_MOTResFirst(i), 1-llfrVWM_MOTResFirst(i));
%     xVWM_MOTResFirst_RawMean(:,i) = mean(MOTCorrectByCondition((i-1)*binSize+1:i*binSize, motResFirstIdx));
%     xZK_VWM_VWMResFirst(:,i) = ZhangK(4, llhrVWM_VWMResFirst(i), 1-llfrVWM_VWMResFirst(i));
%     xVWM_VWMResFirst_RawMean(:,i) = mean(MOTCorrectByCondition((i-1)*binSize+1:i*binSize, vwmResFirstIdx));
% %     xZM_MOT_Only(:,i) = ZhangM(4, hrMOT_Only(i), crMOT_Only(i));
% %     xMOT_Only_RawMean(:,i) = mean(MOTCorrectByCondition((i-1)*binSize+1:i*binSize, motOnlyIdx));
% %     xZM_MOT_MOTResFirst(:,i) = ZhangM(4, hrMOT_MOTResFirst(i), crMOT_MOTResFirst(i));
% %     xMOT_MOTResFirst_RawMean(:,i) = mean(MOTCorrectByCondition((i-1)*binSize+1:i*binSize, motResFirstIdx));
% %     xZM_MOT_VWMResFirst(:,i) = ZhangM(4, hrMOT_VWMResFirst(i), crMOT_VWMResFirst(i));
% %     xMOT_VWMResFirst_RawMean(:,i) = mean(MOTCorrectByCondition((i-1)*binSize+1:i*binSize, vwmResFirstIdx));
% %     xZK_VWM_Only(:,i) = ZhangK(4, hrVWM_Only(i), crVWM_Only(i));
% %     xVWM_Only_RawMean(:,i) = mean(VWMCorrectByCondition((i-1)*binSize+1:i*binSize, vwmOnlyIdx));
% %     xZK_VWM_MOTResFirst(:,i) = ZhangK(4, hrVWM_MOTResFirst(i), crVWM_MOTResFirst(i));
% %     xVWM_MOTResFirst_RawMean(:,i) = mean(MOTCorrectByCondition((i-1)*binSize+1:i*binSize, motResFirstIdx));
% %     xZK_VWM_VWMResFirst(:,i) = ZhangK(4, hrVWM_VWMResFirst(i), crVWM_VWMResFirst(i));
% %     xVWM_VWMResFirst_RawMean(:,i) = mean(MOTCorrectByCondition((i-1)*binSize+1:i*binSize, vwmResFirstIdx));
% 
%     xCK_MOT_Only(:,i) = CowanK(4, hrMOT_Only(i), crMOT_Only(i));
%     xCK_MOT_MOTResFirst(:,i) = CowanK(4, hrMOT_MOTResFirst(i), crMOT_MOTResFirst(i));
%     xCK_MOT_VWMResFirst(:,i) = CowanK(4, hrMOT_VWMResFirst(i), crMOT_VWMResFirst(i));
%     xCK_VWM_Only(:,i) = CowanK(4, hrVWM_Only(i), crVWM_Only(i));
%     xCK_VWM_MOTResFirst(:,i) = CowanK(4, hrVWM_MOTResFirst(i), crVWM_MOTResFirst(i));
%     xCK_VWM_VWMResFirst(:,i) = CowanK(4, hrVWM_VWMResFirst(i), crVWM_VWMResFirst(i));
% 
% end
% 
% disp('Analysis after correction for guessing');
% disp('as per Zhang et al. 2010');
% disp('MOT performance');
% disp('MOT-Only vs MOTResFirst');
% 
% disp('paired sample t-test');
% [h,p] = ttest(xZM_MOT_Only, xZM_MOT_MOTResFirst);
% disp(sprintf('h: %d, p: %f\n',h,p));
% 
% disp('unpaired two-sample t-test');
% [h,p] = ttest2(xZM_MOT_Only, xZM_MOT_MOTResFirst);
% disp(sprintf('h: %d, p: %f\n',h,p));
% 
% disp('MOT-Only vs VWMResFirst');
% disp('paired sample t-test');
% [h,p] = ttest(xZM_MOT_Only, xZM_MOT_VWMResFirst);
% disp(sprintf('h: %d, p: %f\n',h,p));
% 
% disp('unpaired two-sample t-test');
% [h,p] = ttest2(xZM_MOT_Only, xZM_MOT_VWMResFirst);
% disp(sprintf('h: %d, p: %f\n',h,p));
% 
% 
% disp('VWM performance');
% disp('VWM-Only vs MOTResFirst');
% 
% disp('paired sample t-test');
% [h,p] = ttest(xZK_VWM_Only, xZK_VWM_MOTResFirst);
% disp(sprintf('h: %d, p: %f\n',h,p));
% 
% disp('unpaired two-sample t-test');
% [h,p] = ttest2(xZK_VWM_Only, xZK_VWM_MOTResFirst);
% disp(sprintf('h: %d, p: %f\n',h,p));
% 
% disp('VWM-Only vs VWMResFirst');
% 
% disp('paired sample t-test');
% [h,p] = ttest(xZK_VWM_Only, xZK_VWM_VWMResFirst);
% disp(sprintf('h: %d, p: %f\n',h,p));
% 
% disp('unpaired two-sample t-test');
% [h,p] = ttest2(xZK_VWM_Only, xZK_VWM_VWMResFirst);
% disp(sprintf('h: %d, p: %f\n',h,p));
% 
% if showGraphs == 1
%     figure;
%     x = [1 2 3 4 5 6];
%     y = [mean(xZM_MOT_Only) mean(xZM_MOT_MOTResFirst) mean(xZM_MOT_VWMResFirst) mean(xZK_VWM_Only) mean(xZK_VWM_MOTResFirst) mean(xZK_VWM_VWMResFirst)];
%     err = [stm(xZM_MOT_Only)*1.96 stm(xZM_MOT_MOTResFirst)*1.96 stm(xZM_MOT_VWMResFirst)*1.96 stm(xZK_VWM_Only)*1.96 stm(xZK_VWM_MOTResFirst)*1.96 stm(xZK_VWM_VWMResFirst)*1.96];
%     bar(x,y);
%     hold all;
%     h = errorbar(x,y,err);
%     set(h,'linestyle','none');
%     set(gca,'XTickLabel',{'Single', 'MOTResFirst', 'VWMResFirst', 'Single', 'MOTResFirst', 'VWMResFirst'});
%     title('Mean number of targets tracked/remembered per condition (as per Zhang et al.)');
% end
% 
% disp('Analysis after correction for guessing');
% disp('as per Fougnie & Marois. 2006');
% disp('MOT performance');
% disp('MOT-Only vs MOTResFirst');
% 
% disp('paired sample t-test');
% [h,p] = ttest(xCK_MOT_Only, xCK_MOT_MOTResFirst);
% disp(sprintf('h: %d, p: %f\n',h,p));
% 
% disp('unpaired two-sample t-test');
% [h,p] = ttest2(xCK_MOT_Only, xCK_MOT_MOTResFirst);
% disp(sprintf('h: %d, p: %f\n',h,p));
% 
% disp('MOT-Only vs VWMResFirst');
% disp('paired sample t-test');
% [h,p] = ttest(xCK_MOT_Only, xCK_MOT_VWMResFirst);
% disp(sprintf('h: %d, p: %f\n',h,p));
% 
% disp('unpaired two-sample t-test');
% [h,p] = ttest2(xCK_MOT_Only, xCK_MOT_VWMResFirst);
% disp(sprintf('h: %d, p: %f\n',h,p));
% 
% 
% disp('VWM performance');
% disp('VWM-Only vs MOTResFirst');
% 
% disp('paired sample t-test');
% [h,p] = ttest(xCK_VWM_Only, xCK_VWM_MOTResFirst);
% disp(sprintf('h: %d, p: %f\n',h,p));
% 
% disp('unpaired two-sample t-test');
% [h,p] = ttest2(xCK_VWM_Only, xCK_VWM_MOTResFirst);
% disp(sprintf('h: %d, p: %f\n',h,p));
% 
% disp('VWM-Only vs VWMResFirst');
% 
% disp('paired sample t-test');
% [h,p] = ttest(xCK_VWM_Only, xCK_VWM_VWMResFirst);
% disp(sprintf('h: %d, p: %f\n',h,p));
% 
% disp('unpaired two-sample t-test');
% [h,p] = ttest2(xCK_VWM_Only, xCK_VWM_VWMResFirst);
% disp(sprintf('h: %d, p: %f\n',h,p));
% 
% if showGraphs == 1
%     figure;
%     x = [1 2 3 4 5 6];
%     y = [mean(xCK_MOT_Only) mean(xCK_MOT_MOTResFirst) mean(xCK_MOT_VWMResFirst) mean(xCK_VWM_Only) mean(xCK_VWM_MOTResFirst) mean(xCK_VWM_VWMResFirst)];
%     err = [stm(xCK_MOT_Only)*1.96 stm(xCK_MOT_MOTResFirst)*1.96 stm(xCK_MOT_VWMResFirst)*1.96 stm(xCK_VWM_Only)*1.96 stm(xCK_VWM_MOTResFirst)*1.96 stm(xCK_VWM_VWMResFirst)*1.96];
%     bar(x,y);
%     hold all;
%     h = errorbar(x,y,err);
%     set(h,'linestyle','none');
%     set(gca,'XTickLabel',{'Single', 'MOTResFirst', 'VWMResFirst', 'Single', 'MOTResFirst', 'VWMResFirst'});
%     title('Mean number of targets tracked/remembered per condition (as per Fougnie & Marois)');
% end
% 
% % SDT analysis
% % The correction for guessing shows that there is a difference between
% % performance according to raw accuracy, and performance when hit rate and
% % correct reject rate are taken into account. MOT performance drops under 
% % dual-task conditions when the VWM response is elicited first. This may be
% % because the VWM response introduces uncertainty into the MOT response,
% % which would be reflected in a change in Bias, but not sensitivity.
% 
% % hit rate and false alarm rate sometimes reach values 0 & 1, which is problematic for d' & Beta
% % analysis. Therefore HR and FR when used in this SDT are corrected using the loglinear approach.
% 
% % false alarm rate = 1 - correct reject rate
% % Sensitivity: d' = probit(hit_rate) - probit(false_alarm_rate)
% % Bias: Beta = exp((probit(false_alarm_rate)^2 - probit(hit_rate)^2)/2)
% 
% dPrime.MOT_Only = probit(llhrMOT_Only) - probit(llfrMOT_Only);
% Bias.MOT_Only = exp((probit(llfrMOT_Only).^2 - probit(llhrMOT_Only).^2)/2);
% dPrime.VWM_Only = probit(llhrVWM_Only) - probit(llfrVWM_Only);
% Bias.VWM_Only = exp((probit(llfrVWM_Only).^2 - probit(llhrVWM_Only).^2)/2);
% dPrime.MOT_MOTResFirst = probit(llhrMOT_MOTResFirst) - probit(llfrMOT_MOTResFirst);
% Bias.MOT_MOTResFirst = exp((probit(llfrMOT_MOTResFirst).^2 - probit(llhrMOT_MOTResFirst).^2)/2);
% dPrime.MOT_VWMResFirst = probit(llhrMOT_VWMResFirst) - probit(llfrMOT_VWMResFirst);
% Bias.MOT_VWMResFirst = exp((probit(llfrMOT_VWMResFirst).^2 - probit(llhrMOT_VWMResFirst).^2)/2);
% dPrime.VWM_MOTResFirst = probit(llhrVWM_MOTResFirst) - probit(llfrVWM_MOTResFirst);
% Bias.VWM_MOTResFirst = exp((probit(llfrVWM_MOTResFirst).^2 - probit(llhrVWM_MOTResFirst).^2)/2);
% dPrime.VWM_VWMResFirst = probit(llhrVWM_VWMResFirst) - probit(llfrVWM_VWMResFirst);
% Bias.VWM_VWMResFirst = exp((probit(llfrVWM_VWMResFirst).^2 - probit(llhrVWM_VWMResFirst).^2)/2);