classdef MOT_SessionConfig < SessionConfig
    properties (Constant = true)
        StimuliType = StimuliType.Dot;
        ExperimentName = 'MOT_VWM_FF_1';
        ExperimentVersion = '0.0.2';
        TaskTypes = [TaskType.MOT TaskType.VWM];
        ResponseType = ResponseType.ClickAll;
    end
    
    properties
        TestConditionTypes = [...
            Condition.MOTvVWM Condition.FullField Condition.DualTask Condition.PerformTaskA Condition.VWMTask1st Condition.NA;...
            Condition.MOTvVWM Condition.FullField Condition.DualTask Condition.PerformTaskB Condition.VWMTask1st Condition.NA;...
            Condition.MOTvVWM Condition.FullField Condition.DualTask Condition.PerformBoth Condition.VWMTask1st Condition.VWMResponse1st;...
            Condition.MOTvVWM Condition.FullField Condition.DualTask Condition.PerformBoth Condition.VWMTask1st Condition.MOTResponse1st;...
        ];
        PracticeConditionTypes = [...
            Condition.MOTvVWM Condition.FullField Condition.DualTask Condition.PerformTaskA Condition.VWMTask1st Condition.NA;...
            Condition.MOTvVWM Condition.FullField Condition.DualTask Condition.PerformTaskB Condition.VWMTask1st Condition.NA;...
            Condition.MOTvVWM Condition.FullField Condition.DualTask Condition.PerformBoth Condition.VWMTask1st Condition.VWMResponse1st;...
            Condition.MOTvVWM Condition.FullField Condition.DualTask Condition.PerformBoth Condition.VWMTask1st Condition.MOTResponse1st;...
            ];
        % Single task performance will be greater than dual-task so we'll use single-task conditions 
        % in the staircase to avoid ceiling effects
        QUESTConditionTypes = [
            Condition.MOTvVWM Condition.SingleTask Condition.FullField Condition.NA Condition.PerformTaskB Condition.PriorityNA;
        ];
        
        NumTestBlocks = 1; 
        NumTrialsPerCondition = 20;
        NumTrialsPerTestBlock;
        NumPracticeTrialsPerCondition = 10;
        InterQuadrantPadding;
        QuadrantWidthInDegrees = 15.3;
        QuadrantHeightInDegrees = 11.5;
        FlipConditionOrder;
        NumVWMObjects = 4;
        NumVWMObjectPositions = 10;
        VWMObjectDistanceFactor = 2.9;
        VWMObjectDistance
        VWMObjectDisplayTime = 0.5;
        VWMObjectColours = [255 0 0; 0 255 0; 255 255 0; 0 0 255; 0 255 255; 128 64 0; 255 0 255; 128 0 255; 255 128 0; 128 0 64]';
        %VWMObjectColours = [255 0 0; 0 255 0; 255 255 0; 0 0 255; 0 255 255; 128 64 0; 255 0 255]';
        VWMStimArraySize = [4 3];
        MOTProbeTime = 1.5;
        PostVWMISI = 1.2;
        ShowFixation = 1;
        ProvideMOTFeedback = 0;
        ProvideVWMFeedback = 0;
    end % properties

    methods
        function obj = MOT_SessionConfig(window, subjectName, num, debug, sessionFN, trialDataFN)
            super_args{1} = window;
            if nargin >= 2
                super_args{2} = subjectName;
                super_args{3} = num;
                super_args{4} = debug;
                super_args{5} = sessionFN;
                super_args{6} = trialDataFN;
            end
            
            obj = obj@SessionConfig(super_args{:});
            
            obj.InterQuadrantPadding = obj.DotWidth/2;
            obj.Threshold = 0.75;
            obj.Gamma = 0.5;

            if obj.Debug == 1
                obj.NumTrialsPerCondition = 2;
                obj.NumPracticeTrialsPerCondition = 2; 
                obj.NumQUESTTrials = 4; 
                obj.TrialTimePractice = 2;
                obj.TimeTrialTest = 2;
            else
                obj.NumQUESTTrials = 40; 
            end
            obj.NumTrialsPerTestBlock = obj.NumTrialsPerCondition * length(obj.TestConditionTypes);
            obj.FlipConditionOrder = ~mod(num, 2);
            % Load and override observer-specfic settings
            obj = obj.LoadUserConfig(obj.SubjectID);

            obj.VWMObjectDistance = round(obj.VWMObjectDistanceFactor/obj.DegPerPixel);
            
            
            if mod(obj.NumPracticeTrialsPerCondition,2) == 1
                error('NumPracticeTrialsPerCondition must be even');
            elseif mod(obj.NumTrialsPerCondition,2) == 1
                error('NumTrialsPerCondition must be even');
            end
        end
    end
end