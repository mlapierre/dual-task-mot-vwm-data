% Perform the same tests as above, but use the corrections for guessing used by Zhang et al. and
% Fougnie & Marois

% I don't have multiple subjects, so instead I'll divide the data into bins and derive the relevant
% statistics from those bins.

% E.g., after 4 sessions I have 160 observations per condition. These observations can be split into
% 8 bins if each bin contains 20 observations. I can then treat each bin as the other researchers
% treated each individual subject. Of course I'll also need to account for the fact that I'm not
% actually using single subjects. It may be better to do this experiment as a regular experiment
% with a group of participants.

% for each bin
%   calculate Zhang's K & M
%   calculate the means & sds of K & M values
% input the K & M values into t-tests as above
numBins = (numSessions*trialsPerCondition)/binSize;

hrMOT_Only = zeros(1,numBins);
crMOT_Only = zeros(1,numBins);
hrMOT_MOTResFirst = zeros(1,numBins);
crMOT_MOTResFirst = zeros(1,numBins);
hrMOT_VWMResFirst = zeros(1,numBins);
crMOT_VWMResFirst = zeros(1,numBins);
hrVWM_Only = zeros(1,numBins);
crVWM_Only = zeros(1,numBins);
hrVWM_MOTResFirst = zeros(1,numBins);
crVWM_MOTResFirst = zeros(1,numBins);
hrVWM_VWMResFirst = zeros(1,numBins);
crVWM_VWMResFirst = zeros(1,numBins);
llhrMOT_Only = zeros(1,numBins);
llfrMOT_Only = zeros(1,numBins);
llhrMOT_MOTResFirst = zeros(1,numBins);
llfrMOT_MOTResFirst = zeros(1,numBins);
llhrMOT_VWMResFirst = zeros(1,numBins);
llfrMOT_VWMResFirst = zeros(1,numBins);
llhrVWM_Only = zeros(1,numBins);
llfrVWM_Only = zeros(1,numBins);
llhrVWM_MOTResFirst = zeros(1,numBins);
llfrVWM_MOTResFirst = zeros(1,numBins);
llhrVWM_VWMResFirst = zeros(1,numBins);
llfrVWM_VWMResFirst = zeros(1,numBins);
xZM_MOT_Only = zeros(1,numBins);
xMOT_Only_RawMean = zeros(1,numBins);
xZM_MOT_MOTResFirst = zeros(1,numBins);
xMOT_MOTResFirst_RawMean = zeros(1,numBins);
xZM_MOT_VWMResFirst = zeros(1,numBins);
xMOT_VWMResFirst_RawMean = zeros(1,numBins);
xZK_VWM_Only = zeros(1,numBins);
xVWM_Only_RawMean = zeros(1,numBins);
xZK_VWM_MOTResFirst = zeros(1,numBins);
xVWM_MOTResFirst_RawMean = zeros(1,numBins);
xZK_VWM_VWMResFirst = zeros(1,numBins);
xVWM_VWMResFirst_RawMean = zeros(1,numBins);

xCK_MOT_Only = zeros(1,numBins);
xCK_MOT_MOTResFirst = zeros(1,numBins);
xCK_MOT_VWMResFirst = zeros(1,numBins);
xCK_VWM_Only = zeros(1,numBins);
xCK_VWM_MOTResFirst = zeros(1,numBins);
xCK_VWM_VWMResFirst = zeros(1,numBins);

dZK_MOT_MOTResFirst = zeros(1,numBins);
dZK_MOT_VWMResFirst = zeros(1,numBins);
dZK_VWM_MOTResFirst = zeros(1,numBins);
dZK_VWM_VWMResFirst = zeros(1,numBins);
dCK_MOT_MOTResFirst = zeros(1,numBins);
dCK_MOT_VWMResFirst = zeros(1,numBins);
dCK_VWM_MOTResFirst = zeros(1,numBins);
dCK_VWM_VWMResFirst = zeros(1,numBins);

for i = 1:numBins
    hrMOT_Only(i) = getHR(MOTCorrectByCondition((i-1)*binSize+1:i*binSize, motOnlyIdx), MOTValidProbeByCondition((i-1)*binSize+1:i*binSize, motOnlyIdx));
    crMOT_Only(i) = getCR(MOTCorrectByCondition((i-1)*binSize+1:i*binSize, motOnlyIdx), MOTValidProbeByCondition((i-1)*binSize+1:i*binSize, motOnlyIdx));
    hrMOT_MOTResFirst(i) = getHR(MOTCorrectByCondition((i-1)*binSize+1:i*binSize, motResFirstIdx), MOTValidProbeByCondition((i-1)*binSize+1:i*binSize, motResFirstIdx));
    crMOT_MOTResFirst(i) = getCR(MOTCorrectByCondition((i-1)*binSize+1:i*binSize, motResFirstIdx), MOTValidProbeByCondition((i-1)*binSize+1:i*binSize, motResFirstIdx));
    hrMOT_VWMResFirst(i) = getHR(MOTCorrectByCondition((i-1)*binSize+1:i*binSize, vwmResFirstIdx), MOTValidProbeByCondition((i-1)*binSize+1:i*binSize, vwmResFirstIdx));
    crMOT_VWMResFirst(i) = getCR(MOTCorrectByCondition((i-1)*binSize+1:i*binSize, vwmResFirstIdx), MOTValidProbeByCondition((i-1)*binSize+1:i*binSize, vwmResFirstIdx));
    hrVWM_Only(i) = getHR(VWMCorrectByCondition((i-1)*binSize+1:i*binSize, vwmOnlyIdx), VWMValidProbeByCondition((i-1)*binSize+1:i*binSize, vwmOnlyIdx));
    crVWM_Only(i) = getCR(VWMCorrectByCondition((i-1)*binSize+1:i*binSize, vwmOnlyIdx), VWMValidProbeByCondition((i-1)*binSize+1:i*binSize, vwmOnlyIdx));
    hrVWM_MOTResFirst(i) = getHR(MOTCorrectByCondition((i-1)*binSize+1:i*binSize, motResFirstIdx), MOTValidProbeByCondition((i-1)*binSize+1:i*binSize, motResFirstIdx));
    crVWM_MOTResFirst(i) = getCR(MOTCorrectByCondition((i-1)*binSize+1:i*binSize, motResFirstIdx), MOTValidProbeByCondition((i-1)*binSize+1:i*binSize, motResFirstIdx));
    hrVWM_VWMResFirst(i) = getHR(MOTCorrectByCondition((i-1)*binSize+1:i*binSize, vwmResFirstIdx), MOTValidProbeByCondition((i-1)*binSize+1:i*binSize, vwmResFirstIdx));
    crVWM_VWMResFirst(i) = getCR(MOTCorrectByCondition((i-1)*binSize+1:i*binSize, vwmResFirstIdx), MOTValidProbeByCondition((i-1)*binSize+1:i*binSize, vwmResFirstIdx));
    llhrMOT_Only(i) = LLHR(MOTCorrectByCondition((i-1)*binSize+1:i*binSize, motOnlyIdx), MOTValidProbeByCondition((i-1)*binSize+1:i*binSize, motOnlyIdx));
    llfrMOT_Only(i) = LLFR(MOTCorrectByCondition((i-1)*binSize+1:i*binSize, motOnlyIdx), MOTValidProbeByCondition((i-1)*binSize+1:i*binSize, motOnlyIdx));
    llhrMOT_MOTResFirst(i) = LLHR(MOTCorrectByCondition((i-1)*binSize+1:i*binSize, motResFirstIdx), MOTValidProbeByCondition((i-1)*binSize+1:i*binSize, motResFirstIdx));
    llfrMOT_MOTResFirst(i) = LLFR(MOTCorrectByCondition((i-1)*binSize+1:i*binSize, motResFirstIdx), MOTValidProbeByCondition((i-1)*binSize+1:i*binSize, motResFirstIdx));
    llhrMOT_VWMResFirst(i) = LLHR(MOTCorrectByCondition((i-1)*binSize+1:i*binSize, vwmResFirstIdx), MOTValidProbeByCondition((i-1)*binSize+1:i*binSize, vwmResFirstIdx));
    llfrMOT_VWMResFirst(i) = LLFR(MOTCorrectByCondition((i-1)*binSize+1:i*binSize, vwmResFirstIdx), MOTValidProbeByCondition((i-1)*binSize+1:i*binSize, vwmResFirstIdx));
    llhrVWM_Only(i) = LLHR(VWMCorrectByCondition((i-1)*binSize+1:i*binSize, vwmOnlyIdx), VWMValidProbeByCondition((i-1)*binSize+1:i*binSize, vwmOnlyIdx));
    llfrVWM_Only(i) = LLFR(VWMCorrectByCondition((i-1)*binSize+1:i*binSize, vwmOnlyIdx), VWMValidProbeByCondition((i-1)*binSize+1:i*binSize, vwmOnlyIdx));
    llhrVWM_MOTResFirst(i) = LLHR(MOTCorrectByCondition((i-1)*binSize+1:i*binSize, motResFirstIdx), MOTValidProbeByCondition((i-1)*binSize+1:i*binSize, motResFirstIdx));
    llfrVWM_MOTResFirst(i) = LLFR(MOTCorrectByCondition((i-1)*binSize+1:i*binSize, motResFirstIdx), MOTValidProbeByCondition((i-1)*binSize+1:i*binSize, motResFirstIdx));
    llhrVWM_VWMResFirst(i) = LLHR(MOTCorrectByCondition((i-1)*binSize+1:i*binSize, vwmResFirstIdx), MOTValidProbeByCondition((i-1)*binSize+1:i*binSize, vwmResFirstIdx));
    llfrVWM_VWMResFirst(i) = LLFR(MOTCorrectByCondition((i-1)*binSize+1:i*binSize, vwmResFirstIdx), MOTValidProbeByCondition((i-1)*binSize+1:i*binSize, vwmResFirstIdx));

    xZM_MOT_Only(:,i) = ZhangM(4, llhrMOT_Only(i), 1-llfrMOT_Only(i));
    xMOT_Only_RawMean(:,i) = mean(MOTCorrectByCondition((i-1)*binSize+1:i*binSize, motOnlyIdx));
    xZM_MOT_MOTResFirst(:,i) = ZhangM(4, llhrMOT_MOTResFirst(i), 1-llfrMOT_MOTResFirst(i));
    xMOT_MOTResFirst_RawMean(:,i) = mean(MOTCorrectByCondition((i-1)*binSize+1:i*binSize, motResFirstIdx));
    xZM_MOT_VWMResFirst(:,i) = ZhangM(4, llhrMOT_VWMResFirst(i), 1-llfrMOT_VWMResFirst(i));
    xMOT_VWMResFirst_RawMean(:,i) = mean(MOTCorrectByCondition((i-1)*binSize+1:i*binSize, vwmResFirstIdx));
    xZK_VWM_Only(:,i) = ZhangK(4, llhrVWM_Only(i), 1-llfrVWM_Only(i));
    xVWM_Only_RawMean(:,i) = mean(VWMCorrectByCondition((i-1)*binSize+1:i*binSize, vwmOnlyIdx));
    xZK_VWM_MOTResFirst(:,i) = ZhangK(4, llhrVWM_MOTResFirst(i), 1-llfrVWM_MOTResFirst(i));
    xVWM_MOTResFirst_RawMean(:,i) = mean(MOTCorrectByCondition((i-1)*binSize+1:i*binSize, motResFirstIdx));
    xZK_VWM_VWMResFirst(:,i) = ZhangK(4, llhrVWM_VWMResFirst(i), 1-llfrVWM_VWMResFirst(i));
    xVWM_VWMResFirst_RawMean(:,i) = mean(MOTCorrectByCondition((i-1)*binSize+1:i*binSize, vwmResFirstIdx));
%     xZM_MOT_Only(:,i) = ZhangM(4, hrMOT_Only(i), crMOT_Only(i));
%     xMOT_Only_RawMean(:,i) = mean(MOTCorrectByCondition((i-1)*binSize+1:i*binSize, motOnlyIdx));
%     xZM_MOT_MOTResFirst(:,i) = ZhangM(4, hrMOT_MOTResFirst(i), crMOT_MOTResFirst(i));
%     xMOT_MOTResFirst_RawMean(:,i) = mean(MOTCorrectByCondition((i-1)*binSize+1:i*binSize, motResFirstIdx));
%     xZM_MOT_VWMResFirst(:,i) = ZhangM(4, hrMOT_VWMResFirst(i), crMOT_VWMResFirst(i));
%     xMOT_VWMResFirst_RawMean(:,i) = mean(MOTCorrectByCondition((i-1)*binSize+1:i*binSize, vwmResFirstIdx));
%     xZK_VWM_Only(:,i) = ZhangK(4, hrVWM_Only(i), crVWM_Only(i));
%     xVWM_Only_RawMean(:,i) = mean(VWMCorrectByCondition((i-1)*binSize+1:i*binSize, vwmOnlyIdx));
%     xZK_VWM_MOTResFirst(:,i) = ZhangK(4, hrVWM_MOTResFirst(i), crVWM_MOTResFirst(i));
%     xVWM_MOTResFirst_RawMean(:,i) = mean(MOTCorrectByCondition((i-1)*binSize+1:i*binSize, motResFirstIdx));
%     xZK_VWM_VWMResFirst(:,i) = ZhangK(4, hrVWM_VWMResFirst(i), crVWM_VWMResFirst(i));
%     xVWM_VWMResFirst_RawMean(:,i) = mean(MOTCorrectByCondition((i-1)*binSize+1:i*binSize, vwmResFirstIdx));

    xCK_MOT_Only(:,i) = CowanK(4, hrMOT_Only(i), crMOT_Only(i));
    xCK_MOT_MOTResFirst(:,i) = CowanK(4, hrMOT_MOTResFirst(i), crMOT_MOTResFirst(i));
    xCK_MOT_VWMResFirst(:,i) = CowanK(4, hrMOT_VWMResFirst(i), crMOT_VWMResFirst(i));
    xCK_VWM_Only(:,i) = CowanK(4, hrVWM_Only(i), crVWM_Only(i));
    xCK_VWM_MOTResFirst(:,i) = CowanK(4, hrVWM_MOTResFirst(i), crVWM_MOTResFirst(i));
    xCK_VWM_VWMResFirst(:,i) = CowanK(4, hrVWM_VWMResFirst(i), crVWM_VWMResFirst(i));
    
    dZK_MOT_MOTResFirst(:,i) = (xZM_MOT_Only(:,i) - xZM_MOT_MOTResFirst(:,i)) / xZM_MOT_Only(:,i);
    dZK_MOT_VWMResFirst(:,i) = (xZM_MOT_Only(:,i) - xZM_MOT_VWMResFirst(:,i)) / xZM_MOT_Only(:,i);
    dZK_VWM_MOTResFirst(:,i) = (xZK_VWM_Only(:,i) - xZK_VWM_MOTResFirst(:,i)) / xZK_VWM_Only(:,i);
    dZK_VWM_VWMResFirst(:,i) = (xZK_VWM_Only(:,i) - xZK_VWM_VWMResFirst(:,i)) / xZK_VWM_Only(:,i);
    dCK_MOT_MOTResFirst(:,i) = (xCK_MOT_Only(:,i) - xCK_MOT_MOTResFirst(:,i)) / xCK_MOT_Only(:,i);
    dCK_MOT_VWMResFirst(:,i) = (xCK_MOT_Only(:,i) - xCK_MOT_VWMResFirst(:,i)) / xCK_MOT_Only(:,i);
    dCK_VWM_MOTResFirst(:,i) = (xCK_VWM_Only(:,i) - xCK_VWM_MOTResFirst(:,i)) / xCK_VWM_Only(:,i);
    dCK_VWM_VWMResFirst(:,i) = (xCK_VWM_Only(:,i) - xCK_VWM_VWMResFirst(:,i)) / xCK_VWM_Only(:,i);
end

% SDT analysis
% The correction for guessing shows that there is a difference between
% performance according to raw accuracy, and performance when hit rate and
% correct reject rate are taken into account. MOT performance drops under 
% dual-task conditions when the VWM response is elicited first. This may be
% because the VWM response introduces uncertainty into the MOT response,
% which would be reflected in a change in Bias, but not sensitivity.

% hit rate and false alarm rate sometimes reach values 0 & 1, which is problematic for d' & Beta
% analysis. Therefore HR and FR when used in this SDT are corrected using the loglinear approach.

% false alarm rate = 1 - correct reject rate
% Sensitivity: d' = probit(hit_rate) - probit(false_alarm_rate)
% Bias: Beta = exp((probit(false_alarm_rate)^2 - probit(hit_rate)^2)/2)

dPrime.MOT_Only = probit(llhrMOT_Only) - probit(llfrMOT_Only);
dPrime.VWM_Only = probit(llhrVWM_Only) - probit(llfrVWM_Only);
dPrime.MOT_MOTResFirst = probit(llhrMOT_MOTResFirst) - probit(llfrMOT_MOTResFirst);
dPrime.MOT_VWMResFirst = probit(llhrMOT_VWMResFirst) - probit(llfrMOT_VWMResFirst);
dPrime.VWM_VWMResFirst = probit(llhrVWM_VWMResFirst) - probit(llfrVWM_VWMResFirst);
dPrime.VWM_MOTResFirst = probit(llhrVWM_MOTResFirst) - probit(llfrVWM_MOTResFirst);
Beta.MOT_Only = exp((probit(llfrMOT_Only).^2 - probit(llhrMOT_Only).^2)/2);
Beta.VWM_Only = exp((probit(llfrVWM_Only).^2 - probit(llhrVWM_Only).^2)/2);
Beta.MOT_MOTResFirst = exp((probit(llfrMOT_MOTResFirst).^2 - probit(llhrMOT_MOTResFirst).^2)/2);
Beta.MOT_VWMResFirst = exp((probit(llfrMOT_VWMResFirst).^2 - probit(llhrMOT_VWMResFirst).^2)/2);
Beta.VWM_MOTResFirst = exp((probit(llfrVWM_MOTResFirst).^2 - probit(llhrVWM_MOTResFirst).^2)/2);
Beta.VWM_VWMResFirst = exp((probit(llfrVWM_VWMResFirst).^2 - probit(llhrVWM_VWMResFirst).^2)/2);

C.MOT_Only = -(probit(llfrMOT_Only) + probit(llhrMOT_Only))/2;
C.VWM_Only = -(probit(llfrVWM_Only) + probit(llhrVWM_Only))/2;
C.MOT_MOTResFirst = -(probit(llfrMOT_MOTResFirst) + probit(llhrMOT_MOTResFirst))/2;
C.MOT_VWMResFirst = -(probit(llfrMOT_VWMResFirst) + probit(llhrMOT_VWMResFirst))/2;
C.VWM_MOTResFirst = -(probit(llfrVWM_MOTResFirst) + probit(llhrVWM_MOTResFirst))/2;
C.VWM_VWMResFirst = -(probit(llfrVWM_VWMResFirst) + probit(llhrVWM_VWMResFirst))/2;

APrime.MOT_Only = aprime(hrMOT_Only, 1-crMOT_Only);
APrime.VWM_Only = aprime(hrVWM_Only, 1-crVWM_Only);
APrime.MOT_MOTResFirst = aprime(hrMOT_MOTResFirst, 1-crMOT_MOTResFirst);
APrime.MOT_VWMResFirst = aprime(hrMOT_VWMResFirst, 1-crMOT_VWMResFirst);
APrime.VWM_VWMResFirst = aprime(hrVWM_VWMResFirst, 1-crVWM_VWMResFirst);
APrime.VWM_MOTResFirst = aprime(hrVWM_MOTResFirst, 1-crVWM_MOTResFirst);
BDoublePrime.MOT_Only = bdoubleprime(hrMOT_Only, 1-crMOT_Only);
BDoublePrime.VWM_Only = bdoubleprime(hrVWM_Only, 1-crVWM_Only);
BDoublePrime.MOT_MOTResFirst = bdoubleprime(hrMOT_MOTResFirst, 1-crMOT_MOTResFirst);
BDoublePrime.MOT_VWMResFirst = bdoubleprime(hrMOT_VWMResFirst, 1-crMOT_VWMResFirst);
BDoublePrime.VWM_VWMResFirst = bdoubleprime(hrVWM_VWMResFirst, 1-crVWM_VWMResFirst);
BDoublePrime.VWM_MOTResFirst = bdoubleprime(hrVWM_MOTResFirst, 1-crVWM_MOTResFirst);

% Compare average relative dual-task cost to MOT performance vs VWM performance
% arDK = (dKMOT1st + dKVWM1st) / 2

ardZKMOT = (dZK_MOT_MOTResFirst + dZK_MOT_VWMResFirst) / 2;
ardZKVWM = (dZK_VWM_MOTResFirst + dZK_VWM_VWMResFirst) / 2;
ardCKMOT = (dCK_MOT_MOTResFirst + dCK_MOT_VWMResFirst) / 2;
ardCKVWM = (dCK_VWM_MOTResFirst + dCK_VWM_VWMResFirst) / 2;

% Descriptive statistics

fprintf('\t\t\tRaw perc.\tZhang''s M/K\tCowan''s K\n');
fprintf('MOT\n');
fprintf('  Single Task\t%.2f (%.2f)\t%.2f (%.2f)\t%.2f (%.2f)\n', mean(xMOT_Only), std(xMOT_Only), mean(xZM_MOT_Only), std(xZM_MOT_Only), mean(xCK_MOT_Only), std(xCK_MOT_Only));
fprintf('  MOT Resp. 1st\t%.2f (%.2f)\t%.2f (%.2f)\t%.2f (%.2f)\n', mean(xMOT_MOTResFirst), std(xMOT_MOTResFirst), mean(xZM_MOT_MOTResFirst), std(xZM_MOT_MOTResFirst), mean(xCK_MOT_MOTResFirst), std(xCK_MOT_MOTResFirst));
fprintf('  VWM Resp. 1st\t%.2f (%.2f)\t%.2f (%.2f)\t%.2f (%.2f)\n', mean(xMOT_VWMResFirst), std(xMOT_VWMResFirst), mean(xZM_MOT_VWMResFirst), std(xZM_MOT_VWMResFirst), mean(xCK_MOT_VWMResFirst), std(xCK_MOT_VWMResFirst));
fprintf('VWM\n');
fprintf('  Single Task\t%.2f (%.2f)\t%.2f (%.2f)\t%.2f (%.2f)\n', mean(xVWM_Only), std(xVWM_Only), mean(xZK_VWM_Only), std(xZK_VWM_Only), mean(xCK_VWM_Only), std(xCK_VWM_Only));
fprintf('  MOT Resp. 1st\t%.2f (%.2f)\t%.2f (%.2f)\t%.2f (%.2f)\n', mean(xVWM_MOTResFirst), std(xVWM_MOTResFirst), mean(xZK_VWM_MOTResFirst), std(xZK_VWM_MOTResFirst), mean(xCK_VWM_MOTResFirst), std(xCK_VWM_MOTResFirst));
fprintf('  VWM Resp. 1st\t%.2f (%.2f)\t%.2f (%.2f)\t%.2f (%.2f)\n', mean(xVWM_VWMResFirst), std(xVWM_VWMResFirst), mean(xZK_VWM_VWMResFirst), std(xZK_VWM_VWMResFirst), mean(xCK_VWM_VWMResFirst), std(xCK_VWM_VWMResFirst));
fprintf('\n');
fprintf('\t\t\tHR\t\tFR\t\td''\t\tBeta\t\tA''\t\tB''''\n');
fprintf('MOT\n');
fprintf('  Single Task\t%.2f (%.2f)\t%.2f (%.2f)\t%.2f (%.2f)\t%.2f (%.2f)\t%.2f (%.2f)\t%.2f (%.2f)\n', mean(hrMOT_Only), std(hrMOT_Only), mean(1-crMOT_Only), std(1-crMOT_Only), mean(dPrime.MOT_Only), std(dPrime.MOT_Only), mean(Beta.MOT_Only), std(Beta.MOT_Only), mean(APrime.MOT_Only), std(APrime.MOT_Only), mean(BDoublePrime.MOT_Only), std(BDoublePrime.MOT_Only));
fprintf('  MOT Resp. 1st\t%.2f (%.2f)\t%.2f (%.2f)\t%.2f (%.2f)\t%.2f (%.2f)\t%.2f (%.2f)\t%.2f (%.2f)\n', mean(hrMOT_MOTResFirst), std(hrMOT_MOTResFirst), mean(1-crMOT_MOTResFirst), std(1-crMOT_MOTResFirst), mean(dPrime.MOT_MOTResFirst), std(dPrime.MOT_MOTResFirst), mean(Beta.MOT_MOTResFirst), std(Beta.MOT_MOTResFirst), mean(APrime.MOT_MOTResFirst), std(APrime.MOT_MOTResFirst), mean(BDoublePrime.MOT_MOTResFirst), std(BDoublePrime.MOT_MOTResFirst));
fprintf('  VWM Resp. 1st\t%.2f (%.2f)\t%.2f (%.2f)\t%.2f (%.2f)\t%.2f (%.2f)\t%.2f (%.2f)\t%.2f (%.2f)\n', mean(hrMOT_VWMResFirst), std(hrMOT_VWMResFirst), mean(1-crMOT_VWMResFirst), std(1-crMOT_VWMResFirst), mean(dPrime.MOT_VWMResFirst), std(dPrime.MOT_VWMResFirst), mean(Beta.MOT_VWMResFirst), std(Beta.MOT_VWMResFirst), mean(APrime.MOT_VWMResFirst), std(APrime.MOT_VWMResFirst), mean(BDoublePrime.MOT_VWMResFirst), std(BDoublePrime.MOT_VWMResFirst));
fprintf('VWM\n');
fprintf('  Single Task\t%.2f (%.2f)\t%.2f (%.2f)\t%.2f (%.2f)\t%.2f (%.2f)\t%.2f (%.2f)\t%.2f (%.2f)\n', mean(hrVWM_Only), std(hrVWM_Only), mean(1-crVWM_Only), std(1-crVWM_Only), mean(dPrime.VWM_Only), std(dPrime.VWM_Only), mean(Beta.VWM_Only), std(Beta.VWM_Only), mean(APrime.VWM_Only), std(APrime.VWM_Only), mean(BDoublePrime.VWM_Only), std(BDoublePrime.VWM_Only));
fprintf('  MOT Resp. 1st\t%.2f (%.2f)\t%.2f (%.2f)\t%.2f (%.2f)\t%.2f (%.2f)\t%.2f (%.2f)\t%.2f (%.2f)\n', mean(hrVWM_MOTResFirst), std(hrVWM_MOTResFirst), mean(1-crVWM_MOTResFirst), std(1-crVWM_MOTResFirst), mean(dPrime.VWM_MOTResFirst), std(dPrime.VWM_MOTResFirst), mean(Beta.VWM_MOTResFirst), std(Beta.VWM_MOTResFirst), mean(APrime.VWM_MOTResFirst), std(APrime.VWM_MOTResFirst), mean(BDoublePrime.VWM_MOTResFirst), std(BDoublePrime.VWM_MOTResFirst));
fprintf('  VWM Resp. 1st\t%.2f (%.2f)\t%.2f (%.2f)\t%.2f (%.2f)\t%.2f (%.2f)\t%.2f (%.2f)\t%.2f (%.2f)\n', mean(hrVWM_VWMResFirst), std(hrVWM_VWMResFirst), mean(1-crVWM_VWMResFirst), std(1-crVWM_VWMResFirst), mean(dPrime.VWM_VWMResFirst), std(dPrime.VWM_VWMResFirst), mean(Beta.VWM_VWMResFirst), std(Beta.VWM_VWMResFirst), mean(APrime.VWM_VWMResFirst), std(APrime.VWM_VWMResFirst), mean(BDoublePrime.VWM_VWMResFirst), std(BDoublePrime.VWM_VWMResFirst));
fprintf('\n\n');

fprintf('Mean relative dual-task cost [dK = (Ks - Kd)/Ks]\n');
fprintf('Zhang''s formulas\n');
fprintf('MOT\n');
fprintf('  MOT Resp. 1st\t%.2f (%.2f)\n',mean(dZK_MOT_MOTResFirst), std(dZK_MOT_MOTResFirst));
fprintf('  VWM Resp. 1st\t%.2f (%.2f)\n',mean(dZK_MOT_VWMResFirst), std(dZK_MOT_VWMResFirst));
fprintf('VWM\n');
fprintf('  MOT Resp. 1st\t%.2f (%.2f)\n',mean(dZK_VWM_MOTResFirst), std(dZK_VWM_MOTResFirst));
fprintf('  VWM Resp. 1st\t%.2f (%.2f)\n',mean(dZK_VWM_VWMResFirst), std(dZK_VWM_VWMResFirst));
fprintf('Cowan''s formulas\n');
fprintf('MOT\n');
fprintf('  MOT Resp. 1st\t%.2f (%.2f)\n',mean(dCK_MOT_MOTResFirst), std(dCK_MOT_MOTResFirst));
fprintf('  VWM Resp. 1st\t%.2f (%.2f)\n',mean(dCK_MOT_VWMResFirst), std(dCK_MOT_VWMResFirst));
fprintf('VWM\n');
fprintf('  MOT Resp. 1st\t%.2f (%.2f)\n',mean(dCK_VWM_MOTResFirst), std(dCK_VWM_MOTResFirst));
fprintf('  VWM Resp. 1st\t%.2f (%.2f)\n',mean(dCK_VWM_VWMResFirst), std(dCK_VWM_VWMResFirst));
fprintf('\n\n');

fprintf('Mean combined relative dual-task cost [(dKMOT1st + dKVWM1st) / 2]\n');
fprintf('Zhang''s formulas\n');
fprintf('MOT\t%.2f (%.2f)\n',mean(ardZKMOT), std(ardZKMOT));
fprintf('VWM\t%.2f (%.2f)\n',mean(ardZKVWM), std(ardZKVWM));
fprintf('Cowan''s formulas\n');
fprintf('MOT\t%.2f (%.2f)\n',mean(ardCKMOT), std(ardCKMOT));
fprintf('VWM\t%.2f (%.2f)\n',mean(ardCKVWM), std(ardCKVWM));
fprintf('\n\n');

fprintf('Accuracy per session as mean percent correct (SD)\n');
fprintf('%d trials per condition per session\n\n', trialsPerCondition);
fprintf('\t\t\t  MOT\t\t\t\t\t VWM\n');
fprintf('   Single\t\tMOT 1st\t     VWM 1st\t  Single       MOT 1st\t    VWM 1st\t\n');
for i = 1:numSessions
    range = (i-1)*trialsPerCondition+1:i*trialsPerCondition;
    fprintf('%d) %.2f (%.2f)  %.2f (%.2f)  %.2f (%.2f)  %.2f (%.2f)  %.2f (%.2f)  %.2f (%.2f)\n', i,...
        mean(xMOT_Only(range)), std(xMOT_Only(range)), mean(xMOT_MOTResFirst(range)), std(xMOT_MOTResFirst(range)), mean(xMOT_VWMResFirst(range)), std(xMOT_VWMResFirst(range)),...
        mean(xVWM_Only(range)), std(xVWM_Only(range)), mean(xVWM_MOTResFirst(range)), std(xVWM_MOTResFirst(range)), mean(xVWM_VWMResFirst(range)), std(xVWM_VWMResFirst(range))...
        );
end
fprintf('\n\n');

fprintf('Accuracy per bin as mean percent correct (SD)\n');
fprintf('%d trials per condition per bin\n\n', binSize);
fprintf('\t\t\t  MOT\t\t\t\t\t VWM\n');
fprintf('   Single\t\tMOT 1st\t     VWM 1st\t  Single       MOT 1st\t    VWM 1st\t\n');
for i = 1:numBins
    range = (i-1)*binSize+1:i*binSize;
    fprintf('%2d) %.2f (%.2f)  %.2f (%.2f)  %.2f (%.2f)  %.2f (%.2f)  %.2f (%.2f)  %.2f (%.2f)\n', i,...
        mean(xMOT_Only(range)), std(xMOT_Only(range)), mean(xMOT_MOTResFirst(range)), std(xMOT_MOTResFirst(range)), mean(xMOT_VWMResFirst(range)), std(xMOT_VWMResFirst(range)),...
        mean(xVWM_Only(range)), std(xVWM_Only(range)), mean(xVWM_MOTResFirst(range)), std(xVWM_MOTResFirst(range)), mean(xVWM_VWMResFirst(range)), std(xVWM_VWMResFirst(range))...
        );
end
fprintf('\n\n');

if showGraphs == 1
%%
    dualLineGraphBySession('Mean percentage of targets tracked/remembered per condition per session', numSessions, trialsPerCondition,...
         [xMOT_Only xMOT_MOTResFirst xMOT_VWMResFirst xVWM_Only xVWM_MOTResFirst xVWM_VWMResFirst],...
         [0 1; 0 1], {'SouthEast','SouthEast'});
%%
     dualLineGraphBySession('Mean percentage of targets tracked/remembered per condition per bin', numBins, binSize,...
         [xMOT_Only xMOT_MOTResFirst xMOT_VWMResFirst xVWM_Only xVWM_MOTResFirst xVWM_VWMResFirst],...
         [0 1; 0 1], {'SouthEast','SouthEast'});
%%    
    dualBarGraph('Mean percentage of targets tracked/remembered per condition',...
        [xMOT_Only xMOT_MOTResFirst xMOT_VWMResFirst xVWM_Only xVWM_MOTResFirst xVWM_VWMResFirst],...
        [0.5 1]);
%%
    dualBarGraph('Mean number of targets tracked/remembered per condition (as per Zhang et al.)',...
        [xZM_MOT_Only; xZM_MOT_MOTResFirst; xZM_MOT_VWMResFirst; xZK_VWM_Only; xZK_VWM_MOTResFirst; xZK_VWM_VWMResFirst]',...
        [0 4]);

    dualBarGraph('Mean number of targets tracked/remembered per condition (as per Fougnie & Marois)',...
        [xCK_MOT_Only; xCK_MOT_MOTResFirst; xCK_MOT_VWMResFirst; xCK_VWM_Only; xCK_VWM_MOTResFirst; xCK_VWM_VWMResFirst]',...
        [0 4]);

    dualBarGraph('Mean d'' per condition',...
        [dPrime.MOT_Only; dPrime.MOT_MOTResFirst; dPrime.MOT_VWMResFirst; dPrime.VWM_Only; dPrime.VWM_MOTResFirst; dPrime.VWM_VWMResFirst]',...
        [0 4]);

    dualBarGraph('Mean Beta per condition',...
        [Beta.MOT_Only; Beta.MOT_MOTResFirst; Beta.MOT_VWMResFirst; Beta.VWM_Only; Beta.VWM_MOTResFirst; Beta.VWM_VWMResFirst]',...
        [0 3.5]);

    dualBarGraph('Mean A'' per condition',...
        [APrime.MOT_Only; APrime.MOT_MOTResFirst; APrime.MOT_VWMResFirst; APrime.VWM_Only; APrime.VWM_MOTResFirst; APrime.VWM_VWMResFirst]',...
        [0 1]);

    dualBarGraph('Mean B'''' per condition',...
        [BDoublePrime.MOT_Only; BDoublePrime.MOT_MOTResFirst; BDoublePrime.MOT_VWMResFirst; BDoublePrime.VWM_Only; BDoublePrime.VWM_MOTResFirst; BDoublePrime.VWM_VWMResFirst]',...
        [-1 1]);
end


if showInf == 1
%%
fprintf('ANOVA across condition: MOT_Only / MOTRes1st / VWMRes1st');
groups = {'MOT_Only','MOTRes1st','VWMRes1st'};
[p,anovatab,stats] = anova1([xMOT_Only xMOT_MOTResFirst xMOT_VWMResFirst], groups, 'off');
anovatab

fprintf('ANOVA across condition: VWM_Only / MOTRes1st / VWMRes1st');
groups = {'VWM_Only','MOTRes1st','VWMRes1st'};
[p,anovatab,stats] = anova1([xVWM_Only xVWM_MOTResFirst xVWM_VWMResFirst], groups, 'off');
anovatab
    
fprintf('Zhang et al. MOT');
groups = {'MOT_Only','MOTRes1st','VWMRes1st'};
[~,anovatab,~] = anova1([xZM_MOT_Only' xZM_MOT_MOTResFirst' xZM_MOT_VWMResFirst'], groups, 'off');
anovatab

fprintf('Zhang et al. VWM');
groups = {'VWM_Only','MOTRes1st','VWMRes1st'};
[p,anovatab,stats] = anova1([xZK_VWM_Only' xZK_VWM_MOTResFirst' xZK_VWM_VWMResFirst'], groups, 'off');
anovatab

fprintf('Fougnie and Marios MOT');
groups = {'MOT_Only','MOTRes1st','VWMRes1st'};
[p,anovatab,stats] = anova1([xCK_MOT_Only' xCK_MOT_MOTResFirst' xCK_MOT_VWMResFirst'], groups, 'off');
anovatab

fprintf('Fougnie and Marios VWM');
groups = {'VWM_Only','MOTRes1st','VWMRes1st'};
[p,anovatab,stats] = anova1([xCK_VWM_Only' xCK_VWM_MOTResFirst' xCK_VWM_VWMResFirst'], groups, 'off');
anovatab

fprintf('d'' MOT');
groups = {'MOT_Only','MOTRes1st','VWMRes1st'};
[p,anovatab,stats] = anova1([dPrime.MOT_Only' dPrime.MOT_MOTResFirst' dPrime.MOT_VWMResFirst'], groups, 'off');
anovatab

fprintf('d'' VWM');
groups = {'VWM_Only','MOTRes1st','VWMRes1st'};
[p,anovatab,stats] = anova1([dPrime.VWM_Only' dPrime.VWM_MOTResFirst' dPrime.VWM_VWMResFirst'], groups, 'off');
anovatab

fprintf('A'' MOT');
groups = {'MOT_Only','MOTRes1st','VWMRes1st'};
[p,anovatab,stats] = anova1([APrime.MOT_Only' APrime.MOT_MOTResFirst' APrime.MOT_VWMResFirst'], groups, 'off');
anovatab

fprintf('A'' VWM');
groups = {'VWM_Only','MOTRes1st','VWMRes1st'};
[p,anovatab,stats] = anova1([APrime.VWM_Only' APrime.VWM_MOTResFirst' APrime.VWM_VWMResFirst'], groups, 'off');
anovatab

fprintf('Beta MOT');
groups = {'MOT_Only','MOTRes1st','VWMRes1st'};
[p,anovatab,stats] = anova1([Beta.MOT_Only' Beta.MOT_MOTResFirst' Beta.MOT_VWMResFirst'], groups, 'off');
anovatab

fprintf('Beta VWM');
groups = {'VWM_Only','MOTRes1st','VWMRes1st'};
[p,anovatab,stats] = anova1([Beta.VWM_Only' Beta.VWM_MOTResFirst' Beta.VWM_VWMResFirst'], groups, 'off');
anovatab

fprintf('c MOT');
groups = {'MOT_Only','MOTRes1st','VWMRes1st'};
[p,anovatab,stats] = anova1([C.MOT_Only' C.MOT_MOTResFirst' C.MOT_VWMResFirst'], groups, 'off');
anovatab

fprintf('c VWM');
groups = {'VWM_Only','MOTRes1st','VWMRes1st'};
[p,anovatab,stats] = anova1([C.VWM_Only' C.VWM_MOTResFirst' C.VWM_VWMResFirst'], groups, 'off');
anovatab

%%
fprintf('Each test is a test of single task performance vs. dual-task performance\n');
fprintf('Tests are paired sample t-tests unless specified otherwise\n\n');
fprintf('\t\t  MOT performance\t\t\t\t\t\t\t\tVWM performance\n');
fprintf('\t\t  MOT Res 1st\tVWM Res 1st\t\tMOT1st v VWM1st\tMOT Res 1st\t\tVWM Res 1st\t\tMOT1st v VWM1st\n');
fprintf('Analysis as raw accuracy\n');
fprintf('log. reg. ');
% [~,~,stats] = glmfit(group, [xMOT_Only; xMOT_MOTResFirst], 'binomial');
% fprintf('b:%.3f p:%.3f\t', stats.beta(2), stats.p(2));
% [~,~,stats] = glmfit(group, [xMOT_Only; xMOT_VWMResFirst], 'binomial');
% fprintf('b:%.3f p:%.3f\t', stats.beta(2), stats.p(2));
% [~,~,stats] = glmfit(group, [xMOT_MOTResFirst; xMOT_VWMResFirst], 'binomial');
% fprintf('b:%.3f, p:%.3f\t', stats.beta(2), stats.p(2));
% [~,~,stats] = glmfit(group, [xVWM_Only; xVWM_MOTResFirst], 'binomial');
% fprintf('b:%.3f, p:%.3f\t', stats.beta(2), stats.p(2));
% [~,~,stats] = glmfit(group, [xVWM_Only; xVWM_VWMResFirst], 'binomial');
% fprintf('b:%.3f, p:%.3f\t', stats.beta(2), stats.p(2));
% [~,~,stats] = glmfit(group, [xVWM_MOTResFirst; xVWM_VWMResFirst], 'binomial');
% fprintf('b:%.3f, p:%.3f\n', stats.beta(2), stats.p(2));
[~,~,stats] = glmfit(group, [xMOT_Only; xMOT_MOTResFirst], 'binomial');
fprintf('p:%.3f\t\t', stats.p(2));
[~,~,stats] = glmfit(group, [xMOT_Only; xMOT_VWMResFirst], 'binomial');
fprintf('p:%.3f\t\t\t', stats.p(2));
[~,~,stats] = glmfit(group, [xMOT_MOTResFirst; xMOT_VWMResFirst], 'binomial');
fprintf('p:%.3f\t\t\t', stats.p(2));
[~,~,stats] = glmfit(group, [xVWM_Only; xVWM_MOTResFirst], 'binomial');
fprintf('p:%.3f\t\t\t', stats.p(2));
[~,~,stats] = glmfit(group, [xVWM_Only; xVWM_VWMResFirst], 'binomial');
fprintf('p:%.3f\t\t\t', stats.p(2));
[~,~,stats] = glmfit(group, [xVWM_MOTResFirst; xVWM_VWMResFirst], 'binomial');
fprintf('p:%.3f\n', stats.p(2));
fprintf('t-test\t  ');
[~,p] = ttest(xMOT_Only, xMOT_MOTResFirst);
fprintf('p: %.3f\t\t',p);
[~,p] = ttest(xMOT_Only, xMOT_VWMResFirst);
fprintf('p: %.3f\t\t',p);
[~,p] = ttest(xMOT_MOTResFirst, xVWM_VWMResFirst);
fprintf('p: %.3f\t\t',p);
[~,p] = ttest(xVWM_Only, xVWM_MOTResFirst);
fprintf('p: %.3f\t\t',p);
[~,p] = ttest(xVWM_Only, xVWM_VWMResFirst);
fprintf('p: %.3f\t\t',p);
[~,p] = ttest(xVWM_MOTResFirst, xVWM_VWMResFirst);
fprintf('p: %.3f\n\n',p);


fprintf('Analysis after correction for guessing as per Zhang et al. 2010\n');
fprintf('t-test\t  ');
[~,p] = ttest(xZM_MOT_Only, xZM_MOT_MOTResFirst);
fprintf('p: %.3f\t\t',p);
[~,p] = ttest(xZM_MOT_Only, xZM_MOT_VWMResFirst);
fprintf('p: %.3f\t\t',p);
[~,p] = ttest(xZM_MOT_MOTResFirst, xZM_MOT_VWMResFirst);
fprintf('p: %.3f\t\t',p);

%fprintf('\t\t\t\t\t\t\t\t\t\tVWM performance\n');
%fprintf('\t\t\t\t\t\tSingle vs MOT Res 1st\t\tSingle vs VWM Res 1st\n');
%fprintf('paired sample t-test\t');
[~,p] = ttest(xZK_VWM_Only, xZK_VWM_MOTResFirst);
fprintf('p: %.3f\t\t',p);
[~,p] = ttest(xZK_VWM_Only, xZK_VWM_VWMResFirst);
fprintf('p: %.3f\t\t',p);
[~,p] = ttest(xZK_VWM_MOTResFirst, xZK_VWM_VWMResFirst);
fprintf('p: %.3f\n\n',p);


fprintf('Analysis after correction for guessing as per Fougnie & Marois. 2006\n');
%fprintf('\t\t\t\t\t\t\t\t\t\tMOT performance\n');
%fprintf('\t\t\t\t\t\tSingle vs MOT Res 1st\t\tSingle vs VWM Res 1st\n');
fprintf('t-test\t  ');
[~,p] = ttest(xCK_MOT_Only, xCK_MOT_MOTResFirst);
fprintf('p: %.3f\t\t',p);
[~,p] = ttest(xCK_MOT_Only, xCK_MOT_VWMResFirst);
fprintf('p: %.3f\t\t',p);
[~,p] = ttest(xCK_MOT_MOTResFirst, xCK_MOT_VWMResFirst);
fprintf('p: %.3f\t\t',p);

%fprintf('\t\t\t\t\t\t\t\t\t\tVWM performance\n');
%fprintf('\t\t\t\t\t\tSingle vs MOT Res 1st\t\tSingle vs VWM Res 1st\n');
%fprintf('t-test\t');
[~,p] = ttest(xCK_VWM_Only, xCK_VWM_MOTResFirst);
fprintf('p: %.3f\t\t',p);
[~,p] = ttest(xCK_VWM_Only, xCK_VWM_VWMResFirst);
fprintf('p: %.3f\t\t',p);
[~,p] = ttest(xCK_VWM_MOTResFirst, xCK_VWM_VWMResFirst);
fprintf('p: %.3f\n\n',p);

fprintf('SDT Analysis: d''\n');
%fprintf('\t\t\t\t\t\t\t\t\t\tMOT performance\n');
%fprintf('\t\t\t\t\t\tSingle vs MOT Res 1st\t\tSingle vs VWM Res 1st\n');
fprintf('t-test\t  ');
[~,p] = ttest(dPrime.MOT_Only, dPrime.MOT_MOTResFirst);
fprintf('p: %.3f\t\t',p);
[~,p] = ttest(dPrime.MOT_Only, dPrime.MOT_VWMResFirst);
fprintf('p: %.3f\t\t',p);
[~,p] = ttest(dPrime.MOT_MOTResFirst, dPrime.MOT_VWMResFirst);
fprintf('p: %.3f\t\t',p);

%fprintf('\t\t\t\t\t\t\t\t\t\tVWM performance\n');
%fprintf('\t\t\t\t\t\tSingle vs MOT Res 1st\t\tSingle vs VWM Res 1st\n');
%fprintf('t-test\t  ');
[~,p] = ttest(dPrime.VWM_Only, dPrime.VWM_MOTResFirst);
fprintf('p: %.3f\t\t',p);
[~,p] = ttest(dPrime.VWM_Only, dPrime.VWM_VWMResFirst);
fprintf('p: %.3f\t\t',p);
[~,p] = ttest(dPrime.VWM_MOTResFirst, dPrime.VWM_VWMResFirst);
fprintf('p: %.3f\n\n',p);

fprintf('SDT Analysis: A''\n');
fprintf('t-test\t  ');
[~,p] = ttest(APrime.MOT_Only, APrime.MOT_MOTResFirst);
fprintf('p: %.3f\t\t',p);
[~,p] = ttest(APrime.MOT_Only, APrime.MOT_VWMResFirst);
fprintf('p: %.3f\t\t',p);
[~,p] = ttest(APrime.MOT_MOTResFirst, APrime.MOT_VWMResFirst);
fprintf('p: %.3f\t\t',p);
[~,p] = ttest(APrime.VWM_Only, APrime.VWM_MOTResFirst);
fprintf('p: %.3f\t\t',p);
[~,p] = ttest(APrime.VWM_Only, APrime.VWM_VWMResFirst);
fprintf('p: %.3f\t\t',p);
[~,p] = ttest(APrime.VWM_MOTResFirst, APrime.VWM_VWMResFirst);
fprintf('p: %.3f\n\n',p);

fprintf('SDT Analysis: Beta\n');
fprintf('t-test\t  ');
[~,p] = ttest(Beta.MOT_Only, Beta.MOT_MOTResFirst);
fprintf('p: %.3f\t\t',p);
[~,p] = ttest(Beta.MOT_Only, Beta.MOT_VWMResFirst);
fprintf('p: %.3f\t\t',p);
[~,p] = ttest(Beta.MOT_MOTResFirst, Beta.MOT_VWMResFirst);
fprintf('p: %.3f\t\t',p);
[~,p] = ttest(Beta.VWM_Only, Beta.VWM_MOTResFirst);
fprintf('p: %.3f\t\t',p);
[~,p] = ttest(Beta.VWM_Only, Beta.VWM_VWMResFirst);
fprintf('p: %.3f\t\t',p);
[~,p] = ttest(Beta.VWM_MOTResFirst, Beta.VWM_VWMResFirst);
fprintf('p: %.3f\n\n',p);

fprintf('SDT Analysis: C\n');
fprintf('t-test\t  ');
[~,p] = ttest(C.MOT_Only, C.MOT_MOTResFirst);
fprintf('p: %.3f\t\t',p);
[~,p] = ttest(C.MOT_Only, C.MOT_VWMResFirst);
fprintf('p: %.3f\t\t',p);
[~,p] = ttest(C.MOT_MOTResFirst, C.MOT_VWMResFirst);
fprintf('p: %.3f\t\t',p);
[~,p] = ttest(C.VWM_Only, C.VWM_MOTResFirst);
fprintf('p: %.3f\t\t',p);
[~,p] = ttest(C.VWM_Only, C.VWM_VWMResFirst);
fprintf('p: %.3f\t\t',p);
[~,p] = ttest(C.VWM_MOTResFirst, C.VWM_VWMResFirst);
fprintf('p: %.3f\n\n',p);


fprintf('dK Analysis\n');
fprintf('Zhang''s formulas\n');
fprintf('  MOT (MOTRes1st vs. VWMRes1st)\n');
[~,p] = ttest(dZK_MOT_MOTResFirst, dZK_MOT_VWMResFirst);
fprintf('p: %.3f\n',p);
fprintf('  VWM (MOTRes1st vs. VWMRes1st)\n');
[~,p] = ttest(dZK_VWM_MOTResFirst, dZK_VWM_VWMResFirst);
fprintf('p: %.3f\n',p);
fprintf('Cowan''s formulas\n');
fprintf('  MOT (MOTRes1st vs. VWMRes1st)\n');
[~,p] = ttest(dCK_MOT_MOTResFirst, dCK_MOT_VWMResFirst);
fprintf('p: %.3f\n',p);
fprintf('  VWM (MOTRes1st vs. VWMRes1st)\n');
[~,p] = ttest(dCK_VWM_MOTResFirst, dCK_VWM_VWMResFirst);
fprintf('p: %.3f\n\n',p);

fprintf('Comparison of average relative dual-task cost: MOT vs. VWM\n');
fprintf('  Zhang''s formulas\n');
[~,p] = ttest(ardZKMOT, ardZKVWM);
fprintf('p: %.3f\n',p);
fprintf('  Cowan''s formulas\n');
[~,p] = ttest(ardCKMOT, ardCKVWM);
fprintf('p: %.3f\n',p);



fprintf('\n');
end