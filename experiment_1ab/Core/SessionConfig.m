classdef SessionConfig
    properties (Constant = true)
        SF = 4.5;
        ScreenWidth = 52; %52 / 38.5
        ViewingDistance = 60; %68 / 60
        InitialImageWidth = 64;
        CueTime = 2;
        CueFreq = 0.33;
        TargetCueColour = [255 0 0]';
        TargetAColour = [255 255 255]';
        TargetBColour = [0 0 0]';
        DistractorAColour = [255 255 255]';
        DistractorBColour = [0 0 0]';
        ResponseColour = [0 255 255]';
        CorrectColour = [0 255 0]';
        InterQuadrantPaddingColour = [62 62 62];
    end
    
    properties (Abstract, Constant)
        ExperimentName
        ExperimentVersion
    end
    
    properties
        Debug;
        InitialSpeed = 5;
        doPractice = 1;
        doQuest = 1;
        doTest = 1;
        QUESTStepUp = 1.4;      
        QUESTStepDown = 0.8;
        MinSpeed = 3;
        MaxSpeed = 45;
        TimeTrialTest = 4;
        TestGapTime = 3.5;
        TrialTimePractice = 4;
        TrialTimeStaircase = 4; 
        FixationTime = 2;
        NumPracticeTrials 
        NumQUESTTrials 
        NumTestTrials
        SessionNum = 1;
        TimeTrialTotal;
        Threshold = 0.75;
        NumObjectsTotal = 16;
        NumTargetsTotal = 8;
        NumObjectsPerSet = 8;
        NumTargetsPerSet = 4;
        NumObjectsPerQuadrant = 8; % Under dual-task conditions
        NumTargetsPerQuadrant = 4; % Under dual-task conditions
        NumObjectsPerQuadrantPerSet = 4; % I.e., single-task conditions
        NumTargetsPerQuadrantPerSet = 2; % I.e., single-task conditions
        DotWidthScaleFactor = 1;
        MinSepScaleFactor = 2;
        Gamma
        InterFrameInterval
        NumFrames
        DegPerPixel
        SF2
        DotWidth
        ImageWidth
        MinSep
        SessionFN
        SavedTrialsFN
        BackupSavedTrialsFN
        ResultsFN
        Window
        BackupFolder = 'Backup';
        DataFolder = 'Data';
        MaskFileName
        ImgPath
        ImgFileList
        SubjectID
    end % properties

    methods
        function obj = set.TimeTrialTotal(obj,value)
           obj.TimeTrialTotal = value;
           obj.NumFrames = round(obj.TimeTrialTotal / obj.Window.InterFrameInterval);
        end
        
        function obj = SessionConfig(window, subjectName, num, debug, sessionFN, trialDataFN)
            if nargin < 2
                subjectName = 'test';
            end
            
            if ispc()
                slash = '\';
            elseif ismac()
                slash = '/';    
            end
            obj.BackupFolder = [obj.BackupFolder slash];
            obj.DataFolder = [obj.DataFolder slash];
            
            if nargin < 3
                num = 1;
            end
            obj.SessionNum = num;
            
            if nargin < 4
                debug = 0;
            end
            obj.Debug = debug;

            if nargin < 6 || isempty(trialDataFN)
                trialDataFN = [obj.DataFolder subjectName '_' obj.ExperimentName '_' obj.ExperimentVersion '_Session_' num2str(obj.SessionNum) '_trial_data.mat'];
            end
            if nargin < 5 || isempty(sessionFN)
                sessionFN = [obj.DataFolder subjectName '_' date '_' obj.ExperimentName '_' obj.ExperimentVersion '_Session_' num2str(obj.SessionNum) '.mat'];
                resFN = [obj.DataFolder subjectName '_' date '_' obj.ExperimentName '_' obj.ExperimentVersion '_Session_' num2str(obj.SessionNum) '_Results.mat'];
            end
                
            obj.Window = window;
            obj.SessionNum = num;
            obj.SubjectID = subjectName;
            obj.InterFrameInterval = window.InterFrameInterval;
            obj.DegPerPixel = 360/pi*atan(obj.ScreenWidth/(2*obj.ViewingDistance))/window.ScreenRes.width;
            obj.SF2 = 20/obj.DegPerPixel;
            obj.DotWidth = round(obj.DotWidthScaleFactor/obj.DegPerPixel);
            obj.ImageWidth = 1.3*obj.DotWidth;
            obj.MinSep = round(obj.MinSepScaleFactor/obj.DegPerPixel); 
            %obj.MinSep = round(sqrt(obj.ImageWidth*obj.ImageWidth*2));
            obj.TimeTrialTotal = obj.CueTime + obj.TimeTrialTest;
            obj.SessionFN = sessionFN;
            obj.SavedTrialsFN = trialDataFN;
            obj.ResultsFN = resFN;
            obj.BackupSavedTrialsFN = [obj.BackupFolder datestr(now,30) '_' subjectName '_' obj.ExperimentName '_' obj.ExperimentVersion '_trial_data.mat'];
            obj.MaskFileName = GetFullPath('Images\mask\mask.jpg');
            obj.ImgPath = GetFullPath('Images\64x64\');
            obj.ImgFileList = GetFullPath('Images\filelist_64x64.txt');
            %obj.Gamma = factorial(obj.NumTargetsPerQuadrant)/(factorial(obj.NumObjectsPerQuadrant)/factorial(obj.NumTargetsPerQuadrant));
            obj.Gamma = 0.5;
            if obj.Debug == 1
               obj.TimeTrialTest = 2;
               obj.TestGapTime = 0.5;
               obj.TrialTimePractice = 10;
               obj.TrialTimeStaircase = 2; 
               obj.NumPracticeTrials = 4; 
               obj.NumQUESTTrials = 4; 
            end
        end
        
        function obj = LoadUserConfig(obj, subjectID)
           fid = fopen([subjectID '.m'], 'r');
           if fid ~= -1
               while true
                   line = fgetl(fid);
                   if isnumeric(line) 
                       if line == -1
                           break
                       end
                   elseif length(line) < 2
                       break
                   else
                       execLine = line;
                       if strfind(line,'...')
                           execLine = line(1:length(line)-3);
                           line = fgetl(fid);
                           while ~isnumeric(line) & length(line) > 2 & strfind(line,'...')
                               execLine = [execLine line(1:length(line)-3)];
                               line = fgetl(fid);
                           end
                           execLine = [execLine line];
                       end
                   end
                   disp(execLine);
                   eval(execLine);
               end
               fclose(fid);
           end
        end
    end
end