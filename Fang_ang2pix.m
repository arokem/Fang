%function x_pix=Fang_ang2pix(x_ang,displayParams)
%Helper function to translate size of the stimulus from visual angles to
%display pixels
%
%102308 ASR wrote it, based on the SPOOF code base. 

function x_pix=Fang_ang2pix(x_ang,displayParams)

x_cm=2*displayParams.distance*tan(x_ang/180*pi);    %complicated transformation from deg to rad. So this is the size of the stimulus in cm

x_pix=mean(displayParams.numPixels)*(x_cm/mean(displayParams.dimensions));    %takes the cm into pixel (through angle)

