clear all;

session_num = 2;

io_ = MOTWindow();
config = MOT_SessionConfig(io_, 'al1_mcs_1', session_num, 0, [], []);
if exist(config.SessionFN, 'file')
    error('Session save file exists');
end

numTrials = 60;
initialSpeed = 19;

index = Shuffle(1:numTrials);

speed_inc = 2;
% speedLevels = [initialSpeed - 2*speed_inc...
%                 initialSpeed - speed_inc...
%                 initialSpeed ...
%                 initialSpeed + speed_inc...
%                 initialSpeed + 2*speed_inc];
 speedLevels = [initialSpeed - speed_inc...
                initialSpeed ...
                initialSpeed + speed_inc...
                ];
% Randomly arrange an equal number of each stimLevel
% For each stimLevel, there should be an equal number of changes (i.e., 50% change, %50 no change)
speeds = repmat(speedLevels, 1, numTrials/size(speedLevels,2));
%speeds = speeds(:,index);

% determine for each trial whether the MOT probe is a target
probeFlags = [zeros(numTrials/2,1); ones(numTrials/2,1)];
%probeFlags = [1 1 1 1 1];

%% Generate Trials

for trial_num = 1:numTrials
    io_.DisplayMessage(sprintf('Loading %d/%d...',trial_num, numTrials));
    trial = MOT_Trial(config, io_, TaskType.MOT, speeds(trial_num), QuadrantLayout.All, []);
    trial.Condition = [Condition.MOTvVWM Condition.FullField Condition.DualTask Condition.PerformTaskB Condition.VWMTask1st Condition.NA];
    [pos] = trial.GeneratePositions();
    trial.Positions = pos;
    trial.ValidProbe = probeFlags(trial_num);
    trial.Speed = speeds(trial_num);
    
    trials(trial_num) = trial;
end

trials = Shuffle(trials);

%% Collect data
try
    trialStart = zeros(1,numTrials);
    trialDisplayEnd = zeros(1,numTrials);
    trialResponseEnd = zeros(1,numTrials);
    correct = zeros(1,numTrials);
    speed = zeros(1,numTrials);
    
    startTime = GetSecs;
    for i=1:numTrials
        message = ['Trial ' num2str(i) ' of ' num2str(numTrials) '\n\n'...
                   'Loading...\n\n'];
        io_.DisplayMessage(message);
        save(config.ResultsFN, 'correct', 'speed', 'trials', 'trialStart', 'trialDisplayEnd', 'trialResponseEnd');        
        message = ['Trial ' num2str(i) ' of ' num2str(numTrials) '\n\n'...
                   'Press any key to begin.\n\n'];
        io_.DisplayMessageAndWait(message);

        trialStart(i) = GetSecs;
        
        [finPos missedFrames] = trials(i).DisplayTrial(0, 0, 1);
        trials(i).DisplayProbe(finPos);
        
        trialDisplayEnd(i) = GetSecs;
        
        correct(i) = trials(i).GetResponse(finPos, trials(i).ValidProbe);
        
        speed(i) = trials(i).Speed;
        trialResponseEnd(i) = GetSecs;
    end
    endTime = GetSecs;
    save(config.SessionFN, 'config','trials','correct','speed','startTime','endTime','trialStart', 'trialDisplayEnd', 'trialResponseEnd');
    if exist(config.SessionFN, 'file') && exist(config.ResultsFN, 'file')
        delete(config.ResultsFN);
    end
    io_.DisplayMessageAndWait('This stage of the experiment is complete, thank you.\nPlease inform the researcher.');
    
    %[s q] = CalcThreshold([results.Speed], [results.MOTCorrect], 0.75, .5)
    Screen('CloseAll');
    delete(io_);
catch ERROR
    Screen('CloseAll');
    delete(io_);
    rethrow(ERROR);
end