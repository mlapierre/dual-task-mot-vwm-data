% display all observers' performance in one graph
clear all;
obs = {'AS', 'BS', 'UB', 'AL','Group'};

%                MOT                   VWM      
%        Single MOT1st VWM1st  Single MOT1st VWM1st
acc(:,1)=[0.7438 0.7875 0.7844 0.7312 0.6344 0.6031];
err(:,1)=[0.0479 0.0449 0.0451 0.0486 0.0529 0.0537];
acc(:,2)=[0.8000 0.8187 0.7750 0.8250 0.7750 0.7562];
err(:,2)=[0.0439 0.0423 0.0458 0.0417 0.0458 0.0471];
acc(:,3)=[0.7719 0.7719 0.7031 0.7594 0.6281 0.6563];
err(:,3)=[0.0460 0.0460 0.0501 0.0469 0.0530 0.0521];
acc(:,4)=[0.7750 0.7750 0.7594 0.6969 0.5531 0.5938];
err(:,4)=[0.0458 0.0458 0.0469 0.0504 0.0546 0.0539];

% Group
acc(:,size(obs,2)) = mean(acc(:,1:size(obs,2)-1),2);
m = 6;
n = size(acc(:,1:size(obs,2)-1),2);
norm = (acc(:,1:size(obs,2)-1) - repmat(mean(acc(:,1:size(obs,2)-1)),m,1)) + mean(mean(acc(:,1:size(obs,2)-1)));
v = sqrt(std(norm,0,2));
sd = v.^2 *(m/(m-1));
sem = sd/sqrt(n);
err(:,size(obs,2)) = sem*1.96;

%%
fprintf('\nanova_rm(MOT [S M V])\n');
% observer_means = acc(:,1:3);
observer_means = acc(1:3,1:size(obs,2)-1)';
 [~,anovatab] = anova_rm(observer_means, 'off')
[~,p,~,stats] = ttest(observer_means(:,1), observer_means(:,2));
fprintf('single vs. mot 1st: t(%d)=%.4f, p=%.4f\n',stats.df,stats.tstat,p);
[~,p,~,stats] = ttest(observer_means(:,1), observer_means(:,3));
fprintf('single vs. vwm 1st: t(%d)=%.4f, p=%.4f\n',stats.df,stats.tstat,p);
[~,p,~,stats] = ttest(observer_means(:,2), observer_means(:,3));
fprintf('mot 1st vs. vwm 1st: t(%d)=%.4f, p=%.4f\n',stats.df,stats.tstat,p);

fprintf('\nanova_rm(VWM [S M V])\n');
%observer_means = acc(:,4:6);
observer_means = acc(4:6,1:size(obs,2)-1)';
 [~,anovatab] = anova_rm(observer_means, 'off')
[~,p,~,stats] = ttest(observer_means(:,1), observer_means(:,2));
fprintf('single vs. mot 1st: t(%d)=%.4f, p=%.4f\n',stats.df,stats.tstat,p);
[~,p,~,stats] = ttest(observer_means(:,1), observer_means(:,3));
fprintf('single vs. vwm 1st: t(%d)=%.4f, p=%.4f\n',stats.df,stats.tstat,p);
[~,p,~,stats] = ttest(observer_means(:,2), observer_means(:,3));
fprintf('mot 1st vs. vwm 1st: t(%d)=%.4f, p=%.4f\n',stats.df,stats.tstat,p);

%% 
figure('Color','white');
set(gcf, 'Position', [50 50 700 751])

subplot(2,1,1);
x = repmat(1:size(obs,2),m/2,1)';
y = acc';
%bar(x,y(:,1:3),'LineWidth',1.2);
bar(x,y(:,1:3));
set(gca,'FontName','Times New Roman');
set(gca,'FontSize',12);
%set(gca,'FontWeight','Bold');
set(gca,'Color','white');
box off;
hold all;
hL = legend(gca,{'Single Task','MOT Response 1st','VWM Response 1st'}, 'Location', 'NorthEast');     
%set(hL, 'position', [0.8 0.8 0.1 0.1]);
xlabel('Observers');
ylabel('Mean MOT accuracy (proportion correct)');
set(gca,'XTickLabel', obs);
set(gca,'YLim', [0.5 1]);
colours = [0.8 0 0; 0 0.8 0; 0 0 0.8; 0 0 0];
ch = get(gca, 'Children');
h = errorbar(gca,x(:,1)-0.225,y(:,1), err(1,:));
set(h,'linestyle','none');
%set(h,'LineWidth',1.2);
set(h, 'Color', colours(4,:));
set(ch(1), 'FaceColor', colours(3,:));
h = errorbar(gca,x(:,2),y(:,2), err(2,:));
set(h,'linestyle','none');
%set(h,'LineWidth',1.2);
set(h, 'Color', colours(4,:));
set(ch(2), 'FaceColor', colours(1,:));    
h = errorbar(gca,x(:,3)+0.225,y(:,3), err(3,:));
set(h,'linestyle','none');
%set(h,'LineWidth',1.2);
set(h, 'Color', colours(4,:));
set(ch(3), 'FaceColor', colours(2,:));    
t = title('MOT','position',[1 1]);

subplot(2,1,2);
%bar(x,y(:,4:6),'LineWidth',1.2);
bar(x,y(:,4:6));
set(gca,'FontName','Times New Roman');
set(gca,'FontSize',12);
%set(gca,'FontWeight','Bold');
set(gca,'Color','white');
box off;
hold all;
%hL = legend(gca,{'VWM-Only','VWM-MOT 1st','VWM-VWM 1st'}, 'Location', 'NorthEast');     
%set(hL, 'position', [0.8 0.8 0.1 0.1]);
xlabel('Observers');
ylabel('Mean VWM accuracy (proportion correct)');
set(gca,'XTickLabel', obs);
set(gca,'YLim', [0.5 1]);
ch = get(gca, 'Children');
h = errorbar(gca,x(:,1)-0.225,y(:,4), err(4,:));
set(h,'linestyle','none');
%set(h,'LineWidth',1.2);
set(h, 'Color', colours(4,:));
set(ch(1), 'FaceColor', colours(3,:));
h = errorbar(gca,x(:,2),y(:,5), err(5,:));
set(h,'linestyle','none');
%set(h,'LineWidth',1.2);
set(h, 'Color', colours(4,:));
set(ch(2), 'FaceColor', colours(1,:));    
h = errorbar(gca,x(:,3)+0.225,y(:,6), err(6,:));
set(h,'linestyle','none');
%set(h,'LineWidth',1.2);
set(h, 'Color', colours(4,:));
set(ch(3), 'FaceColor', colours(2,:));   
title('VWM','position',[1 1]);
%imwrite(applyhatch_pluscolor(gcf,'/-\',1,[],[],[],1,1),'test.png','png');
[im_hatch,~] = applyhatch_pluscolor(gcf,'\|/+.-',1,[],[],300,1.5,1);
imwrite(im_hatch,'fig13b.tif','tiff','Resolution',300,'Compression','lzw');
