%note: modify the number of subplots you want so all data is included in
%one figure, line 35.

close all; clear all

chdir ('Fang_results')

subjects = {'C-SMR','C-JHY','C-IR','C-BP','C-SPR','P-TJB','P-ZM','P-ZE','P-VG','P-BF'}; 
controls=5; %last control
patients=6; %first patient


cd behavAdapt
figure

Control_toPlot=[];
Patient_toPlot=[];  

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


    if i<patients
        Control_toPlot=[Control_toPlot; toPlot];
    else
        Patient_toPlot=[Patient_toPlot; toPlot];
    end

end


plot(params.stimParams.testTilt,mean(Control_toPlot),'b')
hold on
plot(params.stimParams.testTilt,mean(Patient_toPlot),'r')
axis([0 45 0 1]);  %added REO 4/10/09
title('OTbehave');  %REO
ylabel('contrast');
xlabel('angular difference')
legend('Controls','Patients')




chdir ('../..')