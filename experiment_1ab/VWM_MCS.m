clear all;

session_num = 2;

io_ = MOTWindow();
config = MOT_SessionConfig(io_, 'ub1_vwm_mcs_1', session_num, 0, [], []);
if exist(config.SessionFN, 'file')
    error('Session save file exists');
end

config.NumVWMObjectPositions = 7;
config.VWMObjectDistanceFactor = 5;
config.VWMObjectDisplayTime = 0.5;
config.VWMObjectColours = [0 255 0; 100 255 100; 50 255 50; 0 128 0; 64 128 64; 0 64 0]';

numTrials = 60;
initialStim = 5;
speed = 25;

index = Shuffle(1:numTrials);

stim_inc = 1;
% speedLevels = [initialSpeed - 2*speed_inc...
%                 initialSpeed - speed_inc...
%                 initialSpeed ...
%                 initialSpeed + speed_inc...
%                 initialSpeed + 2*speed_inc];
stimLevels = [initialStim - stim_inc...
                initialStim ...
                initialStim + stim_inc...
                ];
% Randomly arrange an equal number of each stimLevel
% For each stimLevel, there should be an equal number of changes (i.e., 50% change, %50 no change)
vwm_objects = repmat(stimLevels, 1, numTrials/size(stimLevels,2));
%speeds = speeds(:,index);

% determine for each trial whether the MOT probe is a target
vwmProbeFlags = [zeros(numTrials/2,1); ones(numTrials/2,1)];
%probeFlags = [1 1 1 1 1];
probeFlags = Shuffle(vwmProbeFlags);

%% Generate Trials

for trial_num = 1:numTrials
    io_.DisplayMessage(sprintf('Loading %d/%d...',trial_num, numTrials));
    trial = MOT_Trial(config, io_, TaskType.MOT, speed, QuadrantLayout.All, []);
    trial.Condition = [Condition.MOTvVWM Condition.FullField Condition.DualTask Condition.PerformTaskB Condition.VWMTask1st Condition.NA];
    [pos] = trial.GeneratePositions();
    trial.Positions = pos;
    trial.ValidProbe = probeFlags(trial_num);
    trial.Speed = speed;
    
    config.NumVWMObjects = vwm_objects(trial_num);
    VWMtrial = VWM_Trial(config, io_);
    VWMtrial.ValidProbe = vwmProbeFlags(trial_num);
 
    trials(trial_num) = trial;
    VWMtrials(trial_num) = VWMtrial;
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
                   num2str(vwm_objects(i)) ' objects to remember\n'...
                   'Press any key to begin.\n\n'];
        io_.DisplayMessageAndWait(message);

        trialStart(i) = GetSecs;
        
        % Display VWM stimuli
        VWMtrial = VWMtrials(i);
        VWMStim = VWMtrial.DisplayStimuli(1, config.VWMObjectDisplayTime);
        
        [finPos missedFrames] = trials(i).DisplayTrial(0, 0, 1);
        trialDisplayEnd(i) = GetSecs;
        
        VWMoutput = VWMtrial.DisplayProbeAndGetResponse(VWMStim);
        correct(i) = VWMoutput.correct;
        
        trialResponseEnd(i) = GetSecs;
    end
    endTime = GetSecs;
    save(config.SessionFN, 'config','trials','correct','vwm_objects','startTime','endTime','trialStart', 'trialDisplayEnd', 'trialResponseEnd');
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