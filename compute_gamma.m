% compute gamma function
close all; clear all;
cd('/Applications/MATLAB71/toolbox/matlab/michael_silver/OSX/gamma_calibration/');
%load('calib_table_582D.txt');
load('thom_calib_minor_404.txt')
gunColors = [1 0 0; 0 1 0; 0 0 1];
fbValues = calib_table_582D(:,1);
rawGammaValues(:,1) = calib_table_582D(:,2); %red
rawGammaValues(:,2) = calib_table_582D(:,3); %green
rawGammaValues(:,3) = calib_table_582D(:,4); %blue
%fbValues = thom_calib_minor_404(:,1);
%rawGammaValues(:,1) = thom_calib_minor_404(:,2); %red
%rawGammaValues(:,2) = thom_calib_minor_404(:,3); %green
%rawGammaValues(:,3) = thom_calib_minor_404(:,4); %blue

gammaValues = rawGammaValues-(ones(size(rawGammaValues,1),1)*min(rawGammaValues));
gammaValues = gammaValues * diag(1./max(gammaValues));
n = 256;
fb = [0:(n-1)]';
gamma = interp1(fbValues, gammaValues, fb);
gammaTable = zeros(n,3);
levels = ([0:(n-1)]/(n-1))';
gammaTable(:,1) = interp1(gamma(:,1), fb/(n-1), levels);
gammaTable(:,2) = interp1(gamma(:,2), fb/(n-1), levels);
gammaTable(:,3) = interp1(gamma(:,3), fb/(n-1), levels);

figure
colors = {'r','g','b'};
for colorcounter = 1:3
    subplot(1,3,1);
    hold on;
    plot(fbValues,rawGammaValues(:,colorcounter),colors{colorcounter});
    %title('Minor 582D - raw values');
    title('Minor 404 - raw values');
    subplot(1,3,2);
    hold on;
    plot(levels,gamma(:,colorcounter),colors{colorcounter});
    %title('Minor 582D - normalized values');
    title('Minor 404 - raw values');
    subplot(1,3,3);
    hold on;
    plot(levels,gammaTable(:,colorcounter),colors{colorcounter});
    %title('Minor 582D - gamma correction function');
    title('Minor 404 - raw values');
end
%cd('/Applications/MATLAB71/MRI/Displays/Minor_582D/');
cd('/Applications/MATLAB71/MRI/Displays/Minor_404/');
gammaFile = 'gamma';
save(gammaFile, 'gamma', 'rawGammaValues', 'fbValues', 'levels', 'gammaTable');