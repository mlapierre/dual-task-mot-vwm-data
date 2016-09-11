%
% Coordinates the execution of a session, organising trials into blocks and phases (e.g, practise vs. QUEST vs test).
%
classdef MOT_Session < Session
    properties
    end % properties
    
    methods
        function obj = MOT_Session(conf, window)
            obj = obj@Session(conf, window);
        end
        
        % Coordinates and displays the trials for the current session.
        % Results are saved after each trial. QUEST results are saved
        function obj = StartSession(obj)
            obj.SessionStartTime = GetSecs;
            
            if obj.Config.doPractice
                disp('Begin practice phase');
                obj = obj.ExecutePracticePhase(obj.Config.TaskTypes);
            end

            speed = obj.Config.InitialSpeed;
            if obj.Config.doQuest
                disp('Begin Staircase/QUEST phase');
                message = ['Qualification phase\n\n'...
                           'You will see ' num2str(obj.Config.NumObjectsPerSet) ' dots. '...
                           num2str(obj.Config.NumTargetsPerSet) ' of them will be coloured red. '...
                           'Your task is to track those red target dots.\n\n'...
                           'All the dots will begin moving, then after a few moments '...
                           'the red target dots will become black. '...
                           'Keep tracking the same ' num2str(obj.Config.NumTargetsPerSet) ' targets\n\n'...
                           'The speed will vary from trial to trial.\n\n'...
                           '\n\n'...
                           'Please press ''t'' to begin.'];
                obj.Win.DisplayMessageAndWaitForKey(message, 't');
                
                [obj speed] = obj.StartQuest(obj.Config.TaskTypes, speed);
            end
            
            if obj.Config.Debug == 1 && obj.Config.doQuest ~= 1
                speed = 7;
            end
            
            if obj.Config.doTest
                disp('Begin test phase');
                obj = obj.ExecuteTestPhase(obj.Config.TaskTypes, speed);
            end
            
            obj.Win.DisplayMessageAndWait('This session is complete.\n\nPlease inform the experimenter.\n\nThank you for your participation so far!');
            obj.SessionEndTime = GetSecs;
        end % function StartSession(obj)

        % %%%%%%%%%%%%%%
        % Practice Phase
        %
        function obj = ExecutePracticePhase(obj, taskTypes)
            % Reduce the length of each trial for this practice phase
            oldTime = obj.Config.TimeTrialTotal;
            obj.Config.TimeTrialTotal = obj.Config.TrialTimePractice;
            totalTrials = size(obj.Config.PracticeConditionTypes, 1) * obj.Config.NumPracticeTrialsPerCondition;
            trialNum = 1;
            phase = 1;

            % Display each condition blocked
            for i=1:size(obj.Config.PracticeConditionTypes, 1)
                message = 'Practice phase\n\n You''ll briefly see 4 coloured circles. ';
                if find(obj.Config.PracticeConditionTypes(i,:) == Condition.PerformTaskA)
                    message = [message '\nYour task is to remember the colour and location '...
                        'of each circle.\n\n'...
                        'Next you''ll see ' num2str(obj.Config.NumObjectsPerSet) ' dots that will begin moving after a moment. '...
                        'Please ignore them.\n\n'...
                        'Once the dots stop moving you''ll see 1 coloured circle. You''ll be asked if you '...
                        'saw a circle of that colour in that position before.\n'...
                        'Respond ''y'' only if the circle is '...
                        'both the same colour and in the same position as you remember.\n'...
                        'Guess if you''re unsure.\n\n'];
                elseif find(obj.Config.PracticeConditionTypes(i,:) == Condition.PerformTaskB)
                    message = [message 'Please ignore them.\n\n'...
                        'Next you''ll see ' num2str(obj.Config.NumObjectsPerSet) ' dots. '...
                        num2str(obj.Config.NumTargetsPerSet) ' of them will be coloured red. '...
                        'Your task is to track those red target dots.\n\n'...
                        'All the dots will begin moving. After a few moments '...
                        'the red target dots will become black. '...
                        'Keep tracking the same ' num2str(obj.Config.NumTargetsPerSet) ' targets.\n\n'...
                        'Once the dots stop moving you''ll then be asked to click on the targets you were tracking.\n'...
                        'Guess if you''re unsure.\n\n'];
                elseif find(obj.Config.PracticeConditionTypes(i,:) == Condition.PerformBoth)
                    message = [message 'Your task is to remember the colour and location '...
                        'of each circle.\n\n'...
                        'Next you''ll see ' num2str(obj.Config.NumObjectsPerSet) ' dots. '...
                        num2str(obj.Config.NumTargetsPerSet) ' of them will be coloured red. '...
                        'Your task is to track those red target dots.\n\n'...
                        'All the dots will begin moving. After a few moments '...
                        'the red target dots will become black. '...
                        'Keep tracking the same ' num2str(obj.Config.NumTargetsPerSet) ' targets.\n\n'];
                        if find(obj.Config.PracticeConditionTypes(i,:) == Condition.MOTResponse1st)
                            message = [message 'Once the dots stop moving you''ll be asked to click on the targets you were tracking.\n'...
                                'You''ll then see a coloured circle in one of the positions of one of the circles you saw at the start, '...
                                'and you''ll be asked if you saw a circle of that colour in that position before.\n'...
                                'Guess if you''re unsure.\n\n'];
                        elseif find(obj.Config.PracticeConditionTypes(i,:) == Condition.VWMResponse1st)
                            message = [message 'Once the dots stop moving you''ll see a coloured circle in one of the positions of one of the circles you saw at the start, '...
                                'and you''ll be asked if you saw a circle of that colour in that position before.\n'...
                                'You''ll then be asked to click on the targets you were tracking.\n'...
                                'Guess if you''re unsure.\n\n'];
                        else
                            error('Invalid condition');
                        end
                end
                obj.Win.DisplayMessageAndWaitForKey([message 'Please press ''t'' to begin.'], 't');
                
                MOTValidProbe = Shuffle([zeros(obj.Config.NumPracticeTrialsPerCondition/2,1); ones(obj.Config.NumPracticeTrialsPerCondition/2,1)]);
                VWMValidProbe = Shuffle(MOTValidProbe);
                
                for j=1:obj.Config.NumPracticeTrialsPerCondition;
                    layout = obj.GetLayout(obj.Config.PracticeConditionTypes(i,:));
                    
                    trial = MOT_Trial(obj.Config, obj.Win, taskTypes, obj.Config.InitialSpeed-1, layout, []);
                    trial.Condition = obj.Config.PracticeConditionTypes(i,:);
                    [pos] = trial.GeneratePositions();
                    trial.Positions = pos;
                    trial.ValidProbe = MOTValidProbe(j);
                    
                    message = obj.GetInstructions(obj.Config.PracticeConditionTypes(i,:), layout, obj.Config.FlipConditionOrder);
                    message = ['Trial ' num2str(trialNum) ' of ' num2str(totalTrials) '\n\n'...
                               'Press any key to begin.\n\n' message];
                    obj.Win.DisplayMessageAndWait(message);

                    testTarget = [];
                    if find(obj.Config.PracticeConditionTypes(i,:) == Condition.VWMTask1st)
                        % Display VWM stimuli
                        VWMtrial = VWM_Trial(obj.Config, obj.Win);
                        VWMtrial.ValidProbe = VWMValidProbe(j);
                        VWMStim = VWMtrial.DisplayStimuli(phase, obj.Config.VWMObjectDisplayTime);
                        
                        % Blank screen
                        obj.Win.Flip();
                        WaitSecs(obj.Config.PostVWMISI);
                        
                        % Display MOT stimuli
                        trialStart = GetSecs;
                        [finPos missedFrames] = trial.DisplayTrial();
                        trialDisplayEnd = GetSecs;
                        testTarget = trial.DisplayProbe(finPos);
                    elseif find(obj.Config.PracticeConditionTypes(i,:) == Condition.MOTTask1st)
                        % Display MOT stimuli
                        trialStart = GetSecs;
                        [finPos missedFrames] = trial.DisplayTrial();
                        trialDisplayEnd = GetSecs;
                        testTarget = trial.DisplayProbe(finPos);

                        % Display VWM stimuli & ISI
                        VWMtrial = VWM_Trial(obj.Config, obj.Win);
                        VWMtrial.ValidProbe = VWMValidProbe(j);
                        VWMStim = VWMtrial.DisplayStimuli(phase);
                    else
                        error('Invalid condition');
                    end
                    
                    % Get responses
                    trialMOTResponseStart = [];
                    trialMOTResponseEnd = [];
                    trialVWMResponseStart = [];
                    trialVWMResponseEnd = [];
                    VWMoutput.correct = [];
                    MOToutput.correct = [];
                    MOToutput.incorrect = [];
                    MOToutput.selected = [];
                    if find(obj.Config.PracticeConditionTypes(i,:) == Condition.MOTResponse1st)
                        trialMOTResponseStart = GetSecs;
                        [~, MOToutput] = trial.GetResponse(finPos, testTarget);
                        trialMOTResponseEnd = GetSecs;
                        trialVWMResponseStart = GetSecs;
                        VWMoutput = VWMtrial.DisplayProbeAndGetResponse(VWMStim);
                        trialVWMResponseEnd = GetSecs;
                    elseif find(obj.Config.PracticeConditionTypes(i,:) == Condition.VWMResponse1st)
                        trialVWMResponseStart = GetSecs;
                        VWMoutput = VWMtrial.DisplayProbeAndGetResponse(VWMStim);
                        trialVWMResponseEnd = GetSecs;
                        trialMOTResponseStart = GetSecs;
                        [~, MOToutput] = trial.GetResponse(finPos, testTarget);
                        trialMOTResponseEnd = GetSecs;
                    elseif find(obj.Config.PracticeConditionTypes(i,:) == Condition.PerformTaskA)
                        trialVWMResponseStart = GetSecs;
                        VWMoutput = VWMtrial.DisplayProbeAndGetResponse(VWMStim);
                        trialVWMResponseEnd = GetSecs;
                    elseif find(obj.Config.PracticeConditionTypes(i,:) == Condition.PerformTaskB)
                        trialMOTResponseStart = GetSecs;
                        [~, MOToutput] = trial.GetResponse(finPos, testTarget);
                        trialMOTResponseEnd = GetSecs;
                    end

                    obj.PracticeResults(i, j).Condition = obj.Config.PracticeConditionTypes(i,:);
                    obj.PracticeResults(i, j).TaskTypes = taskTypes;
                    obj.PracticeResults(i, j).TrialStart = trialStart;
                    obj.PracticeResults(i, j).TrialDisplayEnd = trialDisplayEnd;
                    obj.PracticeResults(i, j).trialMOTResponseStart = trialMOTResponseStart;
                    obj.PracticeResults(i, j).trialMOTResponseEnd = trialMOTResponseEnd;
                    obj.PracticeResults(i, j).trialVWMResponseStart = trialVWMResponseStart;
                    obj.PracticeResults(i, j).trialVWMResponseEnd = trialVWMResponseEnd;
                    obj.PracticeResults(i, j).VWMCorrect = VWMoutput.correct;
                    obj.PracticeResults(i, j).VWMValidProbe = VWMValidProbe(j);
                    obj.PracticeResults(i, j).MOTNumCorrect = MOToutput.correct;
                    obj.PracticeResults(i, j).MOTNumIncorrect = MOToutput.incorrect;
                    obj.PracticeResults(i, j).MOTValidProbe = MOTValidProbe(j);
                    %obj.PracticeResults(i, j).MOTSelected = MOToutput.selected;
                    obj.PracticeResults(i, j).MissedFrames = missedFrames;
                    obj.PracticeResults(i, j).LayoutID = QuadrantLayout.GetLayoutID(layout);
                    obj.PracticeResults(i, j).Positions = pos;
                    obj.PracticeResults(i, j).Speed = obj.Config.InitialSpeed-1;

                    obj.SaveResults(obj.PracticeResults);
                    trialNum = trialNum + 1;
                end
            end
            obj.Config.TimeTrialTotal = oldTime;
            obj.SaveSession();
        end % End ExecutePracticePhase
        
        % %%%%%%%%%%
        % Test phase
        function obj = ExecuteTestPhase(obj, taskTypes, speed)
            totalTrials = size(obj.Config.TestConditionTypes, 1) * obj.Config.NumTrialsPerCondition;
            trialNum = 1;
            phase = 1;
            % Display each condition blocked
            for i=1:size(obj.Config.TestConditionTypes, 1)
                message = 'Test phase\n\n You''ll briefly see 4 coloured circles. ';
                if find(obj.Config.TestConditionTypes(i,:) == Condition.PerformTaskA)
                    message = [message '\nYour task is to remember the colour and location '...
                        'of each circle.\n\n'...
                        'Next you''ll see ' num2str(obj.Config.NumObjectsPerSet) ' dots that will begin moving after a moment. '...
                        'Please ignore them.\n\n'...
                        'Once the dots stop moving you''ll see 1 coloured circle. You''ll be asked if you '...
                        'saw a circle of that colour in that position before.\n'...
                        'Respond ''y'' only if the circle is '...
                        'both the same colour and in the same position as you remember.\n'...
                        'Guess if you''re unsure.\n\n'];
                elseif find(obj.Config.TestConditionTypes(i,:) == Condition.PerformTaskB)
                    message = [message 'Please ignore them.\n\n'...
                        'Next you''ll see ' num2str(obj.Config.NumObjectsPerSet) ' dots. '...
                        num2str(obj.Config.NumTargetsPerSet) ' of them will be coloured red. '...
                        'Your task is to track those red target dots.\n\n'...
                        'All the dots will begin moving. After a few moments '...
                        'the red target dots will become black. '...
                        'Keep tracking the same ' num2str(obj.Config.NumTargetsPerSet) ' targets.\n\n'...
                        'Once the dots stop moving you''ll then be asked to click on the targets you were tracking.\n'...
                        'Guess if you''re unsure.\n\n'];
                elseif find(obj.Config.TestConditionTypes(i,:) == Condition.PerformBoth)
                    message = [message 'Your task is to remember the colour and location '...
                        'of each circle.\n\n'...
                        'Next you''ll see ' num2str(obj.Config.NumObjectsPerSet) ' dots. '...
                        num2str(obj.Config.NumTargetsPerSet) ' of them will be coloured red. '...
                        'Your task is to track those red target dots.\n\n'...
                        'All the dots will begin moving. After a few moments '...
                        'the red target dots will become black. '...
                        'Keep tracking the same ' num2str(obj.Config.NumTargetsPerSet) ' targets.\n\n'];
                        if find(obj.Config.TestConditionTypes(i,:) == Condition.MOTResponse1st)
                            message = [message 'Once the dots stop moving you''ll be asked to click on the targets you were tracking.\n'...
                                'You''ll then see a coloured circle in one of the positions of one of the circles you saw at the start, '...
                                'and you''ll be asked if you saw a circle of that colour in that position before.\n'...
                                'Guess if you''re unsure.\n\n'];
                        elseif find(obj.Config.TestConditionTypes(i,:) == Condition.VWMResponse1st)
                            message = [message 'Once the dots stop moving you''ll see a coloured circle in one of the positions of one of the circles you saw at the start, '...
                                'and you''ll be asked if you saw a circle of that colour in that position before.\n'...
                                'You''ll then be asked to click on the targets you were tracking.\n'...
                                'Guess if you''re unsure.\n\n'];
                        else
                            error('Invalid condition');
                        end
                end
                MOTValidProbe = Shuffle([zeros(obj.Config.NumTrialsPerCondition/2,1); ones(obj.Config.NumTrialsPerCondition/2,1)]);
                VWMValidProbe = Shuffle(MOTValidProbe);
                
                obj.Win.DisplayMessageAndWaitForKey([message 'Please press ''t'' to begin.'], 't');                
                for j=1:obj.Config.NumTrialsPerCondition;
                    layout = obj.GetLayout(obj.Config.TestConditionTypes(i,:));
                    
                    trial = MOT_Trial(obj.Config, obj.Win, taskTypes, speed, layout, []);
                    trial.Condition = obj.Config.TestConditionTypes(i,:);
                    [pos] = trial.GeneratePositions();
                    trial.Positions = pos;
                    trial.ValidProbe = MOTValidProbe(j);
                    
                    message = obj.GetInstructions(obj.Config.TestConditionTypes(i,:), layout);
                    message = ['Trial ' num2str(trialNum) ' of ' num2str(totalTrials) '\n\n'...
                               'Press any key to begin.\n\n' message];
                    obj.Win.DisplayMessageAndWait(message);

                    %MOTValidProbe = [];
                    if find(obj.Config.TestConditionTypes(i,:) == Condition.VWMTask1st)
                        % Display VWM stimuli
                        VWMtrial = VWM_Trial(obj.Config, obj.Win);
                        VWMtrial.ValidProbe = VWMValidProbe(j);
                        VWMStim = VWMtrial.DisplayStimuli(phase, obj.Config.VWMObjectDisplayTime);
                        
                        % Blank screen
                        obj.Win.Flip();
                        WaitSecs(obj.Config.PostVWMISI);
                        
                        % Display MOT stimuli
                        trialStart = GetSecs;
                        [finPos missedFrames] = trial.DisplayTrial();
                        trialDisplayEnd = GetSecs;
                        trial.DisplayProbe(finPos);
                    else
                        error('Invalid condition');
                    end
                    
                    % Get responses
                    trialMOTResponseStart = [];
                    trialMOTResponseEnd = [];
                    trialVWMResponseStart = [];
                    trialVWMResponseEnd = [];
                    VWMoutput.correct = [];
                    VWMoutput.validProbe = [];
                    MOToutput.correct = [];
                    MOToutput.incorrect = [];
                    MOToutput.selected = [];
                    MOToutput.validProbe = [];
                    if find(obj.Config.TestConditionTypes(i,:) == Condition.MOTResponse1st)
                        trialMOTResponseStart = GetSecs;
                        [~, MOToutput] = trial.GetResponse(finPos, MOTValidProbe(j));
                        trialMOTResponseEnd = GetSecs;
                        trialVWMResponseStart = GetSecs;
                        VWMoutput = VWMtrial.DisplayProbeAndGetResponse(VWMStim);
                        trialVWMResponseEnd = GetSecs;
                    elseif find(obj.Config.TestConditionTypes(i,:) == Condition.VWMResponse1st)
                        trialVWMResponseStart = GetSecs;
                        VWMoutput = VWMtrial.DisplayProbeAndGetResponse(VWMStim);
                        trialVWMResponseEnd = GetSecs;
                        trialMOTResponseStart = GetSecs;
                        [~, MOToutput] = trial.GetResponse(finPos, MOTValidProbe(j));
                        trialMOTResponseEnd = GetSecs;
                    elseif find(obj.Config.TestConditionTypes(i,:) == Condition.PerformTaskA)
                        trialVWMResponseStart = GetSecs;
                        VWMoutput = VWMtrial.DisplayProbeAndGetResponse(VWMStim);
                        trialVWMResponseEnd = GetSecs;
                    elseif find(obj.Config.TestConditionTypes(i,:) == Condition.PerformTaskB)
                        trialMOTResponseStart = GetSecs;
                        [~, MOToutput] = trial.GetResponse(finPos, MOTValidProbe(j));
                        trialMOTResponseEnd = GetSecs;
                    else
                        error('Invalid condition');
                    end
                    
                    obj.TestResults(i, j).Condition = obj.Config.TestConditionTypes(i,:);
                    obj.TestResults(i, j).TaskTypes = taskTypes;
                    obj.TestResults(i, j).TrialStart = trialStart;
                    obj.TestResults(i, j).TrialDisplayEnd = trialDisplayEnd;
                    obj.TestResults(i, j).trialMOTResponseStart = trialMOTResponseStart;
                    obj.TestResults(i, j).trialMOTResponseEnd = trialMOTResponseEnd;
                    obj.TestResults(i, j).trialVWMResponseStart = trialVWMResponseStart;
                    obj.TestResults(i, j).trialVWMResponseEnd = trialVWMResponseEnd;
                    obj.TestResults(i, j).VWMCorrect = VWMoutput.correct;
                    obj.TestResults(i, j).VWMValidProbe = VWMoutput.validProbe;
                    obj.TestResults(i, j).MOTNumCorrect = MOToutput.correct;
                    obj.TestResults(i, j).MOTNumIncorrect = MOToutput.incorrect;
                    obj.TestResults(i, j).MOTValidProbe = MOToutput.validProbe;
                    %obj.TestResults(i, j).MOTSelected = MOToutput.selected;
                    obj.TestResults(i, j).MissedFrames = missedFrames;
                    obj.TestResults(i, j).LayoutID = QuadrantLayout.GetLayoutID(layout);
                    obj.TestResults(i, j).Positions = pos;
                    obj.TestResults(i, j).Speed = speed;

                    obj.SaveResults(obj.TestResults);
                    % Retain the Window object to enable testing automation
                    obj.Win = trial.Window;
                    trialNum = trialNum + 1;
                end
            end            
            obj.SaveSession();
        end
        
        % %%%%%%%%%%%%%%%%%%%%%
        % Staircase/QUEST phase
        function [obj speed] = StartQuest(obj, taskTypes, initialSpeed)
            numTrials = obj.Config.NumQUESTTrials;
            oldTime = obj.Config.TimeTrialTotal;
            obj.Config.TimeTrialTotal = obj.Config.TrialTimeStaircase;
            speed = initialSpeed;
            testTarget = [];
            
            conditions = repmat([obj.Config.QUESTConditionTypes], numTrials/size(obj.Config.QUESTConditionTypes,1), 1);
            conditions(randperm(size(conditions,1)),:) = conditions;
            
            % First roughly estimate the speed using a 1-up 1-down staircase
            for j=1:numTrials
                if speed < obj.Config.MinSpeed
                    speed = obj.Config.MinSpeed;
                elseif speed > obj.Config.MaxSpeed
                    speed = obj.Config.MaxSpeed;
                end
                layout = obj.GetLayout(conditions(j,:));
                
                message = obj.GetInstructions(conditions(j,:), layout, speed);
                    message = ['Trial ' num2str(j) ' of ' num2str(numTrials) '\n\n'...
                               'Press any key to begin.\n\n' message];
                obj.Win.DisplayMessageAndWait(message);
                
                trial = MOT_Trial(obj.Config, obj.Win, taskTypes, speed, layout, []);
                trial.Condition = conditions(j,:);
                [pos] = trial.GeneratePositions();
                trial.Positions = pos;
                trial.ValidProbe = round(rand);

                % Display stimuli and get observer's response
                trialStart = GetSecs;
                [finPos missedFrames] = trial.DisplayTrial(0, 0, 1);
                trialDisplayEnd = GetSecs;
                testTarget = trial.DisplayProbe(finPos);
                [correct(1,j) MOToutput] = trial.GetResponse(finPos, testTarget);
                trialResponseEnd = GetSecs;
                testedSpeed(1,j) = speed;
                
                obj.QuestResults(j).Condition = conditions(j,:);
                obj.QuestResults(j).TaskTypes = taskTypes;
                obj.QuestResults(j).TrialDisplayEnd = trialDisplayEnd;
                obj.QuestResults(j).TrialResponseEnd = trialResponseEnd;
                obj.QuestResults(j).MOTNumCorrect = MOToutput.correct;
                obj.QuestResults(j).MOTNumIncorrect = MOToutput.incorrect;
                obj.QuestResults(j).MOTValidProbe = trial.ValidProbe;
                %obj.QuestResults(j).Selected = output.selected;
                obj.QuestResults(j).MissedFrames = missedFrames;
                obj.QuestResults(j).LayoutID = QuadrantLayout.GetLayoutID(layout);
                obj.QuestResults(j).Positions = pos;
                obj.QuestResults(j).Speed = speed;

                obj.SaveResults(obj.QuestResults);
                
                if correct(1,j) == 1
                    speed = speed * obj.Config.QUESTStepUp;
                else
                    speed = speed * obj.Config.QUESTStepDown;
                end
            end
            
            obj.Config.TimeTrialTotal = oldTime;
            
            [speed q] = obj.CalcThreshold(testedSpeed, correct, obj.Config.Threshold, obj.Config.Gamma);
            
                if speed < obj.Config.MinSpeed
                    speed = obj.Config.MinSpeed;
                elseif speed > obj.Config.MaxSpeed
                    speed = obj.Config.MaxSpeed;
                end
            
            if exist(obj.Config.SessionFN, 'file')
               save(obj.Config.SessionFN, '-APPEND', 'obj', 'speed', 'q');
            else
               save(obj.Config.SessionFN, 'obj', 'speed', 'q');
            end
        end
        
        function layout = GetLayout(obj, condition)
            if find(condition == Condition.FullField)
                layout = QuadrantLayout.All;
            elseif find(condition == Condition.Bilateral)
                if find(condition == Condition.Above)
                    layout = QuadrantLayout.BilateralAbove;
                elseif find(condition == Condition.Below)
                    layout = QuadrantLayout.BilateralBelow;
                else
                    error('Invalid condition');
                end
            elseif find(condition == Condition.Unilateral)
                if find(condition == Condition.Left)
                    layout = QuadrantLayout.UnilateralLeft;
                elseif find(condition == Condition.Right)
                    layout = QuadrantLayout.UnilateralRight;
                else
                    error('Invalid condition');
                end
            else
                error('Invalid condition');
            end            
        end
        
        function layoutList = GetLayouts(obj, numTrials)
            layoutList = QuadrantLayout.GetBilateralLayoutList(numTrials);
        end
            
        function targetQuad = GetTargetQuadrants(obj, condition, flipQuadTargets)
            if nargin < 3
                flipQuadTargets = 0;
            end
            
            % The quadrant containing targets is determined by the condition and by counterbalancing
            % according to session number (FlipConditionOrder). 
            targetQuads = {'top','bottom','left','right','both'};
            switch condition
                case Condition.MOTvMOT_1BA
                    targetQuadIndexes = [3 4];
                case Condition.MOTvMOT_1BB
                    targetQuadIndexes = [4 3];
                case Condition.MOTvMOT_1UL
                    targetQuadIndexes = [1 2];
                case Condition.MOTvMOT_1UR
                    targetQuadIndexes = [2 1];
                case {Condition.MOTvMOT_2BA Condition.MOTvMOT_2BB Condition.MOTvMOT_2UL Condition.MOTvMOT_2UR}
                    targetQuadIndexes = 5;
            end
           
            %if obj.Config.FlipConditionOrder == 1
            %    targetQuadIndexes = fliplr(targetQuadIndexes);
            %end
            if flipQuadTargets == 1 
               targetQuadIndexes = fliplr(targetQuadIndexes);
            end
            targetQuad = targetQuads{targetQuadIndexes(1)};
        end
        
        function isSingleTask = IsSingleTask(obj, condition)
            if find(condition == Condition.SingleTask)
                isSingleTask = 1;
            else
                isSingleTask = 0;
            end
        end
        
        function message = GetInstructions(obj, condition, layout, speed)
%             if find(condition == Condition.PerformTaskA)
%                 targetSet = 'white';
%             elseif find(condition == Condition.PerformTaskB)
%                 targetSet = 'black';
%             elseif find(condition == Condition.PerformBoth)
%                 targetSet = 'black and white';
%             else
%                 error('Invalid condition');
%             end
%             
%             message = ['Track the ' targetSet ' targets.'];
%             
%             if find(condition == Condition.DualTask)
%                 if find(condition == Condition.PriorityA)
%                     message = [message '\nPrioritise the white targets.'];
%                 elseif find(condition == Condition.PriorityB)
%                     message = [message '\nPrioritise the black targets.'];
%                 elseif find(condition == Condition.PriorityEqual)
%                     message = [message '\nGive equal priority to both.'];
%                 end
%             end

            message = '';
            if obj.Config.Debug == 1
                message = [message '\n\nLayout: ' QuadrantLayout.GetLayoutName(layout) '\nCondition:\n'];
                for i=1:size(condition,2)
                    message = [message Condition.GetName(condition(i)) '\n'];
                end
            end
            
            if nargin > 4 && obj.Config.Debug == 1
                message = [message '\n\nSpeed: ' num2str(speed)];
            end
        end
    end % methods
end % classdef