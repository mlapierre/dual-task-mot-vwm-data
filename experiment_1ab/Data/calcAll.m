clear all;
participants = {'calcBS1_1','calcUB1_2','calcSL1_1','calcAM1_1','calcRM1_1','calcPDC1_2'};
pInitials = {'BS','UB','SL','AM','RM','PC'};
numGraphs = 16;
showGroupGraphs = 1;
showPerPGraphs = 0;

AllMOTOnlyComb = [];
AllMOTResFirstComb = [];
AllMOTVWMResFirstComb = [];
AllVWMOnly = [];
AllVWMMOTResFirstComb = [];
AllVWMVWMResFirstComb = [];
AllOnly16 = [];
AllMOTResFirst16 = [];
AllVWMResFirst16 = [];

for part=1:length(participants)
    fprintf('***************************  %s  ***************************\n',participants{part});
    eval(participants{part});
    
    AllRawOnly{:,1,part} = xMOT_Only;
    AllRawMOTResFirst{:,1,part} = xMOT_MOTResFirst;
    AllRawVWMResFirst{:,1,part} = xMOT_VWMResFirst;
    AllRawOnly{:,2,part} = xVWM_Only;
    AllRawMOTResFirst{:,2,part} = xVWM_MOTResFirst;
    AllRawVWMResFirst{:,2,part} = xVWM_VWMResFirst;
    
    analysisCount = 1;
    AllOnly{:,analysisCount,part} = xZM_MOT_Only;
    AllMOTResFirst{:,analysisCount,part} = xZM_MOT_MOTResFirst;
    AllVWMResFirst{:,analysisCount,part} = xZM_MOT_VWMResFirst;
    AllOnly16(:,analysisCount,part) = xZM_MOT_Only(1:16);
    AllMOTResFirst16(:,analysisCount,part) = xZM_MOT_MOTResFirst(1:16);
    AllVWMResFirst16(:,analysisCount,part) = xZM_MOT_VWMResFirst(1:16);
    
    analysisCount = analysisCount + 1; % 2
    AllOnly{:,analysisCount,part} = xZK_VWM_Only;
    AllMOTResFirst{:,analysisCount,part} = xZK_VWM_MOTResFirst;
    AllVWMResFirst{:,analysisCount,part} = xZK_VWM_VWMResFirst;
    AllOnly16(:,analysisCount,part) = xZK_VWM_Only(1:16);
    AllMOTResFirst16(:,analysisCount,part) = xZK_VWM_MOTResFirst(1:16);
    AllVWMResFirst16(:,analysisCount,part) = xZK_VWM_VWMResFirst(1:16);

    AllOnly{:,3,part} = xCK_MOT_Only;
    AllMOTResFirst{:,3,part} = xCK_MOT_MOTResFirst;
    AllVWMResFirst{:,3,part} = xCK_MOT_VWMResFirst;
    AllOnly{:,4,part} = xCK_VWM_Only;
    AllMOTResFirst{:,4,part} = xCK_VWM_MOTResFirst;
    AllVWMResFirst{:,4,part} = xCK_VWM_VWMResFirst;
    
    AllOnly{:,5,part} = dPrime.MOT_Only;
    AllMOTResFirst{:,5,part} = dPrime.MOT_MOTResFirst;
    AllVWMResFirst{:,5,part} = dPrime.MOT_VWMResFirst;
    AllOnly{:,6,part} = dPrime.VWM_Only;
    AllMOTResFirst{:,6,part} = dPrime.VWM_MOTResFirst;
    AllVWMResFirst{:,6,part} = dPrime.VWM_VWMResFirst;
    AllOnly{:,7,part} = APrime.MOT_Only;
    AllMOTResFirst{:,7,part} = APrime.MOT_MOTResFirst;
    AllVWMResFirst{:,7,part} = APrime.MOT_VWMResFirst;
    AllOnly{:,8,part} = APrime.VWM_Only;
    AllMOTResFirst{:,8,part} = APrime.VWM_MOTResFirst;
    AllVWMResFirst{:,8,part} = APrime.VWM_VWMResFirst;
    AllOnly{:,9,part} = Beta.MOT_Only;
    AllMOTResFirst{:,9,part} = Beta.MOT_MOTResFirst;
    AllVWMResFirst{:,9,part} = Beta.MOT_VWMResFirst;
    AllOnly{:,10,part} = Beta.VWM_Only;
    AllMOTResFirst{:,10,part} = Beta.VWM_MOTResFirst;
    AllVWMResFirst{:,10,part} = Beta.VWM_VWMResFirst;
    AllOnly{:,11,part} = BDoublePrime.MOT_Only;
    AllMOTResFirst{:,11,part} = BDoublePrime.MOT_MOTResFirst;
    AllVWMResFirst{:,11,part} = BDoublePrime.MOT_VWMResFirst;
    AllOnly{:,12,part} = BDoublePrime.VWM_Only;
    AllMOTResFirst{:,12,part} = BDoublePrime.VWM_MOTResFirst;
    AllVWMResFirst{:,12,part} = BDoublePrime.VWM_VWMResFirst;

    AllOnly{:,13,part} = C.MOT_Only;
    AllMOTResFirst{:,13,part} = C.MOT_MOTResFirst;
    AllVWMResFirst{:,13,part} = C.MOT_VWMResFirst;
    AllOnly{:,14,part} = C.VWM_Only;
    AllMOTResFirst{:,14,part} = C.VWM_MOTResFirst;
    AllVWMResFirst{:,14,part} = C.VWM_VWMResFirst;
    
    AllMOTOnlyComb = [AllMOTOnlyComb; xMOT_Only];
    AllMOTResFirstComb = [AllMOTResFirstComb; xMOT_MOTResFirst];
    AllMOTVWMResFirstComb = [AllMOTVWMResFirstComb; xMOT_VWMResFirst];
    AllVWMOnly = [AllVWMOnly; xVWM_Only];
    AllVWMMOTResFirstComb = [AllVWMMOTResFirstComb; xVWM_MOTResFirst];
    AllVWMVWMResFirstComb = [AllVWMVWMResFirstComb; xVWM_VWMResFirst];
end

for part=1:length(participants)
    AllMOTOnlyMean{part,1} = mean(AllRawOnly{:,1,part});
    AllMOTMOTResFirstMean{part,1} = mean(AllRawMOTResFirst{:,1,part});
    AllMOTVWMResFirstMean{part,1} = mean(AllRawVWMResFirst{:,1,part});
    AllVWMOnlyMean{part,1} = mean(AllRawOnly{:,2,part});
    AllVWMMOTResFirstMean{part,1} = mean(AllRawMOTResFirst{:,2,part});
    AllVWMVWMResFirstMean{part,1} = mean(AllRawVWMResFirst{:,2,part});

    % Zhang correction for guessing
    AllMOTOnlyMean{part,2} = mean(AllOnly{:,1,part});
    AllMOTMOTResFirstMean{part,2} = mean(AllMOTResFirst{:,1,part});
    AllMOTVWMResFirstMean{part,2} = mean(AllVWMResFirst{:,1,part});
    AllVWMOnlyMean{part,2} = mean(AllOnly{:,2,part});
    AllVWMMOTResFirstMean{part,2} = mean(AllMOTResFirst{:,2,part});
    AllVWMVWMResFirstMean{part,2} = mean(AllVWMResFirst{:,2,part});

    % Fougnie & Marois correction for guessing
    AllMOTOnlyMean{part,3} = mean(AllOnly{:,3,part});
    AllMOTMOTResFirstMean{part,3} = mean(AllMOTResFirst{:,3,part});
    AllMOTVWMResFirstMean{part,3} = mean(AllVWMResFirst{:,3,part});
    AllVWMOnlyMean{part,3} = mean(AllOnly{:,4,part});
    AllVWMMOTResFirstMean{part,3} = mean(AllMOTResFirst{:,4,part});
    AllVWMVWMResFirstMean{part,3} = mean(AllVWMResFirst{:,4,part});
end

if showGroupGraphs == 1
    graphNum = 1;
    dualBarGraphWSMorey('Mean percentage of targets tracked/remembered per condition',...
        [[AllMOTOnlyMean{:,graphNum}]' [AllMOTMOTResFirstMean{:,graphNum}]' [AllMOTVWMResFirstMean{:,graphNum}]' [AllVWMOnlyMean{:,graphNum}]' [AllVWMMOTResFirstMean{:,graphNum}]' [AllVWMVWMResFirstMean{:,graphNum}]'],...
        [0.5 1]);

    graphNum = 2;
    dualBarGraphWSMorey('Mean number of targets tracked/remembered per condition (as per Zhang et al.)',...
        [[AllMOTOnlyMean{:,graphNum}]' [AllMOTMOTResFirstMean{:,graphNum}]' [AllMOTVWMResFirstMean{:,graphNum}]' [AllVWMOnlyMean{:,graphNum}]' [AllVWMMOTResFirstMean{:,graphNum}]' [AllVWMVWMResFirstMean{:,graphNum}]'],...
        [0 4]);

    graphNum = 3;
    dualBarGraphWSMorey('Mean number of targets tracked/remembered per condition (as per Fougnie & Marois)',...
        [[AllMOTOnlyMean{:,graphNum}]' [AllMOTMOTResFirstMean{:,graphNum}]' [AllMOTVWMResFirstMean{:,graphNum}]' [AllVWMOnlyMean{:,graphNum}]' [AllVWMMOTResFirstMean{:,graphNum}]' [AllVWMVWMResFirstMean{:,graphNum}]'],...
        [0 4]);
end

% groups = {'MOT_Only','MOTRes1st','VWMRes1st'};
% [p,anovatab,stats] = anova1([AllOnly{:,1,part} AllMOTResFirst{:,1,part} AllVWMResFirst{:,1,part}], groups, 'off');
% anovatab

%[~, table] = anova_rm([mean(squeeze(AllOnly16(:,1,:)))' mean(squeeze(AllMOTResFirst16(:,1,:)))' mean(squeeze(AllVWMResFirst16(:,1,:)))'], 'off')

if showPerPGraphs == 1
    motTaskA = [1 0];
    motTaskB = [1 0 1 0 1 0 1 0 1 0 1 0 1 0];
    titlesA = {'Mean MOT accuracy (percentage)', 'Mean VWM accuracy (percentage)'};
    titlesB = {'Mean number tracked as per Zhang et al.','Mean number remembered as per Zhang et al.',...
        'Mean number tracked as per Fougnie & Marois', 'Mean number remembered as per Fougnie & Marois',...
        'Mean d''', 'Mean d''','Mean A''','Mean A''','Mean Beta','Mean Beta',...
        'Mean B''''','Mean B''''', 'Mean C', 'Mean C'};
    yLimsA = [0.5 1;0.5 1];
    legLocA = {'NorthEast','NorthEast'};
    legLocB = {'NorthEast','NorthEast','NorthEast','NorthEast','NorthEast','NorthEast',...
               'NorthEast','NorthEast','SouthEast','SouthEast','SouthEast','SouthEast','SouthEast','SouthEast'};
    yLimsB = [0 3.5;0 3;0 3;0 4;0 2.5;0 3.5;0.5 1;0.5 1;0 3;0 3;-0.5 0.5;-1 0.5;-0.5 1;-0.5 1];
    varNames = 'OnlyMean,OnlySTM,MOTResFirstMean,MOTResFirstSTM,VWMResFirstMean,VWMResFirstSTM';

    for graph=1:2
        fid = fopen('combined.csv','w');
        fprintf(fid,'%s\n',varNames);
        for part=1:6
            fprintf(fid,'%.3f,%.3f,%.3f,%.3f,%.3f,%.3f\n',mean(AllRawOnly{:,graph,part}),stm(AllRawOnly{:,graph,part})*1.96,mean(AllRawMOTResFirst{:,graph,part}),stm(AllRawMOTResFirst{:,graph,part})*1.96,mean(AllRawVWMResFirst{:,graph,part}),stm(AllRawVWMResFirst{:,graph,part})*1.96);
        end
        fclose(fid);
        currTitle = titlesA{graph};
        currTask = motTaskA(graph);
        currLegLoc = legLocA{graph};
        yLim = yLimsA(graph,:);
        graphAll;
    end
    for graph=1:numGraphs-2
        fid = fopen('combined.csv','w');
        fprintf(fid,'%s\n',varNames);
        for part=1:6
            fprintf(fid,'%.3f,%.3f,%.3f,%.3f,%.3f,%.3f\n',mean(AllOnly{:,graph,part}),stm(AllOnly{:,graph,part})*1.96,mean(AllMOTResFirst{:,graph,part}),stm(AllMOTResFirst{:,graph,part})*1.96,mean(AllVWMResFirst{:,graph,part}),stm(AllVWMResFirst{:,graph,part})*1.96);
        end
        fclose(fid);
        currTitle = titlesB{graph};
        currTask = motTaskB(graph);
        currLegLoc = legLocB{graph};
        yLim = yLimsB(graph,:);
        graphAll;
    end
end