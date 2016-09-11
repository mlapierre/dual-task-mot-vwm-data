% collate the results for each participant, including
% correction for guessing, and SDT stats.
% includes generation of graphs, and can do various anovas and
% t-tests if enabled within each participant's calc file. It doesn't
% summarise results in a simple manner.
calcAll

% generate a CSV file to import into SPSS
RawToCSV_long

% generate a CSV file of data corrected for guessing. 
% each data point is the average of performance for 20 consecutive trials.
% i.e., one measurement of number of objects tracked/remembered was 
% calculated from the HR and CR of 20 consecutive trials. Thus there are 16
% to 32 data points per participant.
GuessingCorrectionToCSV

% Run GuessingCorrectionByCond.sps in SPSS to perform a repeated measures ANOVA on
% MOT and VWM performance

