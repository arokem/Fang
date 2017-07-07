%note: modify the number of subplots you want so all data is included in
%one figure, line 40.

close all; clear all

chdir ('Fang_results')
subjects = {'C-SMR','C-JHY','C-IR','C-BP','C-SPR','P-TJB','P-ZM','P-ZE','P-VG','P-BF'}; 

cd behavAdapt
figure %REO

for i = 1:numel(subjects)

 %figure %REO
    hold on
    
    load ([subjects{i} '_Adapt']) %_1
    if mod(params.stimParams.adaptTilt,45)
        color1 = 'r';
        color2 = 'b';
    else
        color2 = 'r';
        color1 = 'b';
    end

    toPlot = [];
    for k=1:numel(history)

        toPlot = [toPlot 10.^history{k}.t(length(history{k}.t))];
        

    end
    
%     toPlot = (toPlot-min(toPlot));
%     toPlot = toPlot./max(toPlot);

subplot(2,5,i) %REO     
plot(params.stimParams.testTilt,toPlot,color1)
axis([0 45 0 1]);  %added REO 4/10/09
title(subjects(i));  %REO
ylabel('contrast');
xlabel('angular difference')

%     load ([subjects{i} '_Adapt'])  %_2
%     
%     toPlot = [];
%     
%     for k=1:numel(history)
%         toPlot = [toPlot 10.^history{k}.t(length(history{k}.t))];
% 
%     end
% 
% %     toPlot = (toPlot-min(toPlot));
% %     toPlot = toPlot./max(toPlot);
%     plot(params.stimParams.testTilt,toPlot,color2)


end

chdir ('../..')