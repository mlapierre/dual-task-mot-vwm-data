clear all;

session_num = 1;

try 
    io_ = MOTWindow();
    config = MOT_SessionConfig(io_, 'ml1_mcs', session_num, 0, [], []);
    if exist(config.SessionFN, 'file')
        error('Session save file exists');
    end
    config.ProvideVWMFeedback = 1;
    config.PostVWMISI = 0.5;

    numTrials = 12;

    index = Shuffle(1:numTrials);
    stim_display_time = 2;
    object_num = 3;
    stim_inc = 1;
    % speedLevels = [initialSpeed - 2*speed_inc...
    %                 initialSpeed - speed_inc...
    %                 initialSpeed ...
    %                 initialSpeed + speed_inc...
    %                 initialSpeed + 2*speed_inc];
      stimLevels = [object_num - stim_inc...
                    object_num ...
                    object_num + stim_inc...
                   ];
    %stimLevels = object_num;
    % Randomly arrange an equal number of each stimLevel
    % For each stimLevel, there should be an equal number of changes (i.e., 50% change, %50 no change)
    if mod(numTrials, size(stimLevels,2)) ~= 0
        error('Number of levels must be a factor of number of trials.');
    end
    levels = repmat(stimLevels, 1, numTrials/size(stimLevels,2));
    %speeds = speeds(:,index);

    % determine for each trial whether the MOT probe is a target
    probeFlags = [zeros(numTrials/2,1); ones(numTrials/2,1)];
    %probeFlags = [1 1 1 1 1];
    MOTValidProbe = Shuffle([zeros(numTrials/2,1); ones(numTrials/2,1)]);
catch ERROR
    Screen('CloseAll');
    delete(io_);
    rethrow(ERROR);
end
%% Generate Trials

for trial_num = 1:numTrials
    io_.DisplayMessage(sprintf('Loading %d/%d...',trial_num, numTrials));
    
    config.NumVWMObjects = levels(trial_num);
    
    trial = VWM_Cubes_Trial(config, io_);
    trial.Change = probeFlags(trial_num);
    trial.Object_Num = levels(trial_num);
    
    trials(trial_num) = trial;
end

trials = Shuffle(trials);

%% Collect data
try
    trialStart = zeros(1,numTrials);
    trialDisplayEnd = zeros(1,numTrials);
    trialResponseEnd = zeros(1,numTrials);
    correct = zeros(1,numTrials);
    levels = zeros(1,numTrials);
    
    startTime = GetSecs;
    for i=1:numTrials
        message = ['Trial ' num2str(i) ' of ' num2str(numTrials) '\n\n'...
                   'Loading...\n\n'];
        io_.DisplayMessage(message);
        
        mot_trial = MOT_Trial(config, io_, TaskType.MOT, 10, QuadrantLayout.All, []);
        mot_trial.Condition = [Condition.MOTvVWM Condition.FullField Condition.DualTask Condition.PerformTaskA Condition.VWMTask1st Condition.NA];
        [pos] = mot_trial.GeneratePositions();
        mot_trial.Positions = pos;
        mot_trial.ValidProbe = MOTValidProbe(i);
        
        save(config.ResultsFN, 'correct', 'levels', 'trials', 'mot_trial', 'trialStart', 'trialDisplayEnd', 'trialResponseEnd');        
        message = ['Trial ' num2str(i) ' of ' num2str(numTrials) '\n\n'...
                   'Press any key to begin.\n\n'];
        io_.DisplayMessageAndWait(message);

        trialStart(i) = GetSecs;
        
        cubes = trials(i).DisplayStimuli(stim_display_time);
%        trials(i).DisplayProbe(finPos);
        
        trialDisplayEnd(i) = GetSecs;
        % Blank screen
        io_.Flip();
        WaitSecs(config.PostVWMISI);
        
                
        [finPos missedFrames] = mot_trial.DisplayTrial();
        trialDisplayEnd = GetSecs;
        mot_trial.DisplayProbe(finPos);
        
        response = trials(i).DisplayProbeAndGetResponse(cubes);
        correct(i) = response.correct;
        
        levels(i) = trials(i).Object_Num;
        trialResponseEnd(i) = GetSecs;
    end
    endTime = GetSecs;
    save(config.SessionFN, 'config','trials','mot_trial','correct','levels','startTime','endTime','trialStart', 'trialDisplayEnd', 'trialResponseEnd');
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