function StartSession(type, subjectName, num, debug, sessionFN, trialDataFN)

if nargin < 6
    trialDataFN = [];
end
if nargin < 5
    sessionFN = [];
end
if nargin < 4
    debug = 0;
end
if nargin < 3
    num = 1;
end
if nargin < 2
    subjectName = 'test';
end
if nargin < 1
    type = '';
end
disp('Adding dependency locations to the search path...');
cd Core
addpath(GetFullPath('.'));
cd ..

disp('Removing conflicting locations from the path...');
rmpath(GetFullPath('../MOT/HemifieldLearning'), GetFullPath('../MOT/Core'), GetFullPath('../MOT/Data'));

win = MOTWindow();
%win = MockWin();
startTime = GetSecs;

try
    if strcmp(type, 'MOT_VWM')
        conf = MOT_SessionConfig(win, subjectName, num, debug, sessionFN, trialDataFN);
        sess = MOT_Session(conf, win);
    else
        error('Not a valid session');
    end
    sess.StartSession();
    endTime = GetSecs;
    save(conf.SessionFN, '-APPEND', 'startTime', 'endTime');
    delete(win);
%     disp('Removing dependency locations from the path...');
%     rmpath(GetFullPath('HemifieldIndependence'), GetFullPath('TrajectoryLearning'));
%     cd Core
%     rmpath(GetFullPath('.'));
%     cd ..
catch
    delete(win);
    ple
%     disp('Removing dependency locations from the path...');
%     rmpath(GetFullPath('HemifieldIndependence'), GetFullPath('TrajectoryLearning'));
%     cd Core
%     rmpath(GetFullPath('.'));
%     cd ..
end
