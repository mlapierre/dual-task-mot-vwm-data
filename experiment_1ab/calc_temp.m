ps = {'AS', 'AL', 'UB'};
%mot(:,1) = [0.74 0.79 0.78];
%vwm(:,1) = [0.73 0.63 0.60];
mot(:,1)    = [0.7438 0.7875 0.7844];
moterr(:,1) = [0.0479 0.0449 0.0451];
vwm(:,1)    = [0.7312 0.6344 0.6031];
vwmerr(:,1) = [0.0486 0.0529 0.0537];

mot(:,2)    = [0.7750 0.7750 0.7594];
moterr(:,2) = [0.0458 0.0458 0.0469];
vwm(:,2)    = [0.6969 0.5531 0.5938];
vwmerr(:,2) = [0.0504 0.0546 0.0539];

%mot(:,3) = [0.77 0.77 0.70];
%vwm(:,3) = [0.76 0.63 0.66];
mot(:,3)    = [0.7719 0.7719 0.7031];
moterr(:,3) = [0.0460 0.0460 0.0501];
vwm(:,3)    = [0.7594 0.6281 0.6563];
vwmerr(:,3) = [0.0469 0.0530 0.0521];


%%
figure('Name','MOT & VWM percent correct');

subplot(1,2,1);
x = [1 1 1; 2 2 2; 3 3 3];
y = mot';
%err = mot'.*(1-mot')./sqrt(size(mot,2));
%err = stm(y(1,:)).*1.96;
err = moterr;
bar(x,y, 'b');
hold all;
title('MOT');
legend(gca,{'S','MOT-1st', 'VWM-1st'}, 'Location', 'NorthEast');     
set(gca,'XTickLabel', ps);
set(gca,'YLim', [0.5 1]);
colours = [1 0 0; 0 1 0; 0 0 1; 0 0 0];
ch = get(gca, 'Children');
h = errorbar(gca,x(:,1)-0.225,mot(1,:), err(1,:));
set(h,'linestyle','none');
set(h, 'Color', colours(4,:));
set(ch(2), 'FaceColor', colours(3,:));
h = errorbar(gca,x(:,2),mot(2,:), err(2,:));
set(h,'linestyle','none');
set(h, 'Color', colours(4,:));
set(ch(1), 'FaceColor', colours(1,:));    
h = errorbar(gca,x(:,3)+0.225,mot(3,:), err(3,:));
set(h,'linestyle','none');
set(h, 'Color', colours(4,:));
set(ch(2), 'FaceColor', colours(2,:));    

subplot(1,2,2);
x = [1 1 1; 2 2 2; 3 3 3];
y = vwm';
%err = vwm'.*(1-vwm')./sqrt(size(vwm,2));
%err = stm(y).*1.96;
err = vwmerr;
bar(x,y, 'b');
hold all;
title('VWM');
legend(gca,{'S','MOT-1st', 'VWM-1st'}, 'Location', 'NorthEast');     
set(gca,'XTickLabel', ps);
set(gca,'YLim', [0.5 1]);
colours = [1 0 0; 0 1 0; 0 0 1; 0 0 0];
ch = get(gca, 'Children');
h = errorbar(gca,x(:,1)-0.225,vwm(1,:), err(1,:));
set(h,'linestyle','none');
set(h, 'Color', colours(4,:));
set(ch(2), 'FaceColor', colours(3,:));
h = errorbar(gca,x(:,2),vwm(2,:), err(2,:));
set(h,'linestyle','none');
set(h, 'Color', colours(4,:));
set(ch(1), 'FaceColor', colours(1,:));    
h = errorbar(gca,x(:,3)+0.225,vwm(3,:), err(3,:));
set(h,'linestyle','none');
set(h, 'Color', colours(4,:));
set(ch(2), 'FaceColor', colours(2,:));    

%%
figure('Name','MOT & VWM percent correct');

subplot(1,2,1);
x = 1:3;
y = mean(mot);
err = y.*(1-y)./sqrt(size(y,2));
bar(x,y, 'b');
hold all;
title('MOT');
set(gca,'XTickLabel', {'S','MOT', 'VWM'});
set(gca,'YLim', [0.5 1]);
h = errorbar(gca,x,y, err);
set(h,'linestyle','none');
set(h, 'Color', 'Black');

subplot(1,2,2);
x = 1:3;
y = mean(vwm);
err = y.*(1-y)./sqrt(size(y,2));
bar(x,y, 'b');
hold all;
title('VWM');
set(gca,'XTickLabel', {'S','MOT', 'VWM'});
set(gca,'YLim', [0.5 1]);
h = errorbar(gca,x,y, err);
set(h,'linestyle','none');
set(h, 'Color', 'Black');
%%
figure('Name','MOT & VWM percent correct');

subplot(1,2,1);
x = 1:3;
y = mean(mot,2);
err = mean(moterr,2);
bar(x,y);
hold all;
title('MOT');
set(gca,'XTickLabel', {'S','MOT', 'VWM'});
set(gca,'YLim', [0.5 1]);
h = errorbar(gca,x,y, err);
set(h,'linestyle','none');
set(h, 'Color', 'Black');

subplot(1,2,2);
x = 1:3;
y = mean(vwm,2);
err = mean(vwmerr,2);
bar(x,y);
hold all;
title('VWM');
set(gca,'XTickLabel', {'S','MOT', 'VWM'});
set(gca,'YLim', [0.5 1]);
h = errorbar(gca,x,y, err);
set(h,'linestyle','none');
set(h, 'Color', 'Black');

