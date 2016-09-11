function mot_correct_by_condition = Calc_And_Show_Results(fn)
    max_sessions = size(fn,1);
    max_trials = 40;
    num_conditions = 4;
    condition_names = {'MOT-Only','MOTResFirst','VWM-Only','VWMResFirst'};
    do_inf = 1;

    mot_correct = NaN(max_trials, num_conditions, max_sessions);
    vwm_correct = NaN(max_trials, num_conditions, max_sessions);
    conditions = NaN(max_trials, num_conditions, max_sessions);
    TrialTime = NaN(max_sessions,1);

    num_sessions = 1;
    temp_correctm1 = [];
    temp_correctm2 = [];
    temp_correctw1 = [];
    temp_correctw2 = [];
    for sess = 1:max_sessions
        if ~isempty(fn{sess})
            num_sessions = sess;
            load(fn{sess});
            TrialTime(sess) = (endTime-startTime)/60;
            blocksPerSession = size(obj.TestResults,1);
            trialsPerBlock = size(obj.TestResults,2);
            [MOT, VWM, block_conds] = getCorrectByCondition(obj.TestResults, blocksPerSession, trialsPerBlock);
            if blocksPerSession == 8
                for cond = 1:size(block_conds,2)/2
                    cond_index = find(strcmp(condition_names, block_conds{cond}));
                    temp_correctm1(:,cond_index) = MOT.Correct(:,cond);
                    temp_correctw1(:,cond_index) = VWM.Correct(:,cond);
                end
                for cond = 5:size(block_conds,2)
                    cond_index = find(strcmp(condition_names, block_conds{cond}));
                    temp_correctm2(:,cond_index) = MOT.Correct(:,cond);
                    temp_correctw2(:,cond_index) = VWM.Correct(:,cond);
                end
                mot_correct(:, :, sess) = [temp_correctm1; temp_correctm2];
                vwm_correct(:, :, sess) = [temp_correctw1; temp_correctw2];
            else
                for cond = 1:size(block_conds,2)
                    cond_index = find(strcmp(condition_names, block_conds{cond}));
                    cond_index
                    sess
                    cond
                    mot_correct(:,cond_index, sess) = MOT.Correct(:,cond);
                    vwm_correct(:,cond_index, sess) = VWM.Correct(:,cond);
                end
            end
            
%             sess_cond=[obj.TestResults.Condition];
%             sess_correct=[obj.TestResults.Correct];
%             sess_task_type = [obj.TestResults.TaskType];
%             correct(:, 1, sess) = sess_correct(sess_cond==Condition.PerformMOT);
%             correct(:, 2, sess) = sess_correct(sess_cond==Condition.PerformVWM);
%             correct(:, 3, sess) = sess_correct(sess_cond==Condition.PerformBoth & sess_task_type==TaskType.MOT);
%             correct(:, 4, sess) = sess_correct(sess_cond==Condition.PerformBoth & sess_task_type==TaskType.VWM);
        end
    end
    fprintf('Total time: %.2f (hours)\nAverage time: %.2f (mins)\n',sum(TrialTime(1:num_sessions))/60, mean(TrialTime(1:num_sessions)));
    fprintf('Sessions: %d\ntrials per condition per session: %d\ntotal trials per condition: %d\ntotal trials per session: %d\ntotal trials: %d\n',...
        max_sessions, max_trials, num_sessions*max_trials, max_trials*num_conditions, max_trials*num_conditions*num_sessions);
%     mot_means = mean(mot_correct); 
%     mot_errs = mot_means.*(1-mot_means)./4;
%     vwm_means = mean(vwm_correct); 
%     vwm_errs = vwm_means.*(1-vwm_means)./4;
%     mot_means_by_condition = mean(mot_means(:,:,1:num_sessions),3);
%     mot_errs_by_condition = mean(mot_errs(:,:,1:num_sessions),3);
%     vwm_means_by_condition = mean(vwm_means(:,:,1:num_sessions),3);
%     vwm_errs_by_condition = mean(vwm_errs(:,:,1:num_sessions),3);
    
    mot_correct_by_condition(:,1) = reshape(mot_correct(:,1,1:num_sessions), num_sessions*max_trials, 1);
    mot_correct_by_condition(:,2) = reshape(mot_correct(:,2,1:num_sessions), num_sessions*max_trials, 1);
    mot_correct_by_condition(:,3) = reshape(mot_correct(:,3,1:num_sessions), num_sessions*max_trials, 1);
    mot_correct_by_condition(:,4) = reshape(mot_correct(:,4,1:num_sessions), num_sessions*max_trials, 1);
    vwm_correct_by_condition(:,1) = reshape(vwm_correct(:,1,1:num_sessions), num_sessions*max_trials, 1);
    vwm_correct_by_condition(:,2) = reshape(vwm_correct(:,2,1:num_sessions), num_sessions*max_trials, 1);
    vwm_correct_by_condition(:,3) = reshape(vwm_correct(:,3,1:num_sessions), num_sessions*max_trials, 1);
    vwm_correct_by_condition(:,4) = reshape(vwm_correct(:,4,1:num_sessions), num_sessions*max_trials, 1);
    
    for i = 1:size(condition_names,2)
        mot_m(i) = mean(mot_correct_by_condition(1:num_sessions*max_trials,i));
        mot_e(i) = stm(mot_correct_by_condition(1:num_sessions*max_trials,i))*1.96;
        fprintf('%s: %.3f (%.3f)\n', condition_names{i}, mot_m(i), mot_e(i));
    end
    for i = 1:size(condition_names,2)
        vwm_m(i) = mean(vwm_correct_by_condition(1:num_sessions*max_trials,i));
        vwm_e(i) = stm(vwm_correct_by_condition(1:num_sessions*max_trials,i))*1.96;
        fprintf('%s: %.3f (%.3f)\n', condition_names{i}, vwm_m(i), vwm_e(i));
    end
    fprintf('acc(:,)=[%1.4f %1.4f %1.4f %1.4f %1.4f %1.4f];\n',mot_m(1),mot_m(2),mot_m(4),vwm_m(3),vwm_m(2),vwm_m(4));
    fprintf('err(:,)=[%1.4f %1.4f %1.4f %1.4f %1.4f %1.4f];\n',mot_e(1),mot_e(2),mot_e(4),vwm_e(3),vwm_e(2),vwm_e(4));
    
    if do_inf
        num_conditions = 3;
        
        fprintf('glmfit condition (single / MOT response 1st / VWM response 1st) on MOT accuracy (hit/miss)\n');
        condition_flags = reshape(ones(num_sessions*max_trials, 1)*[1 2 3],num_sessions*max_trials*num_conditions,1);
        y = reshape(mot_correct_by_condition(:,[1 2 4]), num_sessions*max_trials*num_conditions, 1);
        X = condition_flags;
        [~,~,stats] = glmfit(X, y, 'binomial');
        fprintf('B=%.3f, t(%d)=%.3f, p=%.3f\n',stats.beta(2),stats.dfe,stats.t(2),stats.p(2));
        [h,p,~,stats] = ttest2(mot_correct_by_condition(:,1), mot_correct_by_condition(:,2));
        fprintf('single vs. mot 1st: t(%d)=%.4f, p=%.4f\n',stats.df,stats.tstat,p);
        [h,p,~,stats] = ttest2(mot_correct_by_condition(:,1), mot_correct_by_condition(:,4));
        fprintf('single vs. vwm 1st: t(%d)=%.4f, p=%.4f\n',stats.df,stats.tstat,p);
        [h,p,~,stats] = ttest2(mot_correct_by_condition(:,2), mot_correct_by_condition(:,4));
        fprintf('mot 1st vs. vwm 1st: t(%d)=%.4f, p=%.4f\n',stats.df,stats.tstat,p);

        fprintf('glmfit condition (single / MOT response 1st / VWM response 1st) on VWM accuracy (hit/miss)\n');
        condition_flags = reshape(ones(num_sessions*max_trials, 1)*[1 2 3],num_sessions*max_trials*num_conditions,1);
        y = reshape(vwm_correct_by_condition(:,[3 2 4]), num_sessions*max_trials*num_conditions, 1);
        X = condition_flags;
        [~,~,stats] = glmfit(X, y, 'binomial');
        fprintf('B=%.3f, t(%d)=%.3f, p=%.3f\n',stats.beta(2),stats.dfe,stats.t(2),stats.p(2));
        [h,p,~,stats] = ttest2(vwm_correct_by_condition(:,3), vwm_correct_by_condition(:,2));
        fprintf('single vs. mot 1st: t(%d)=%.4f, p=%.4f\n',stats.df,stats.tstat,p);
        [h,p,~,stats] = ttest2(vwm_correct_by_condition(:,3), vwm_correct_by_condition(:,4));
        fprintf('single vs. vwm 1st: t(%d)=%.4f, p=%.4f\n',stats.df,stats.tstat,p);
        [h,p,~,stats] = ttest2(vwm_correct_by_condition(:,2), vwm_correct_by_condition(:,4));
        fprintf('mot 1st vs. vwm 1st: t(%d)=%.4f, p=%.4f\n',stats.df,stats.tstat,p);
    end
%     if num_sessions > 1
%         figure;
%         title('Percent correct by condition by session');
%         x = repmat(1:num_sessions,size(condition_names,1),1)';
%         means = squeeze(means(:,:,1:num_sessions))';
%         errs = squeeze(errs(:,:,1:num_sessions))';
%         bar(x,means);
%         hold all;
%         ax1 = gca;
%         legend(ax1,condition_names, 'Location', 'NorthEast'); 
%         set(ax1, 'YLim', [0 1]);       
%         ylimits = get(ax1,'YLim');
%         yinc = (ylimits(2)-ylimits(1))/5;
%         set(ax1, 'YTick',[ylimits(1):yinc:ylimits(2)]);
%         set(ax1, 'XTick',x(:,1));
%     end
%     colours = [1 0 0; 0 1 0; 0 0 1; 0 0 0];
%     ch = get(ax1, 'Children');
%     h = errorbar(ax1,x(:,1)-0.13,means(:,1), errs(:,1));
%     set(h,'linestyle','none');
%     set(h, 'Color', colours(1,:));
%     set(ch(2), 'FaceColor', colours(1,:));
%     h = errorbar(ax1,x(:,2)+0.13,means(:,2), errs(:,2));
%     set(h,'linestyle','none');
%     set(h, 'Color', colours(3,:));
%     set(ch(1), 'FaceColor', colours(3,:));   
    
%     figure;
%     title('Percent correct by condition');
%      x = 1:num_conditions*2;
%     bar(x,[mot_m vwm_m]);
%     hold all;
%     set(gca, 'YLim', [0.5 1]);       
%     set(gca,'XTickLabel',[condition_names condition_names]);
%     h = errorbar(gca,x,[mot_m vwm_m], [mot_e vwm_e]);
%     set(h,'linestyle','none');
%     set(h, 'Color', [0 0 0]);
end