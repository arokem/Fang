function m=Fang_mkGabor(sf, sc, res)

% function m=Fang_mkGabor(sf, sc, res)
% this function draws a 0 degree phase, 0 deg tilted gabor on a designated location within a meshgrid.
% The entire gabor is normalized to [0,1] 
% <sf> spatial frequency of the gabor (in cycles/res. That is - how many
% cycles are included in the whole patch!)
% <sc> is the space constant (in pixels!)
% <res> is a 1X2 vector with the size of the entire meshgrid containing the
% gabor (in pixels!)
% 
%10/5/07 ASR and ANL made it.
%102408 ASR mad it a lot simpler, added normalization. 

x=res(1)/2;
y=res(2)/2;
tilt=0;
[gab_x gab_y] = meshgrid(0:(res(1)-1), 0:(res(2)-1));

multConst=1/(sqrt(2*pi)*sc);
x_factor=-1*(gab_x-res(1)/2).^2;
y_factor=-1*(gab_y-res(2)/2).^2;
sinWave=sind(360*sf*gab_y);
varScale=2*sc^2;

m=(multConst*exp(x_factor/varScale+y_factor/varScale).*sinWave)';
%Normalize
m=m-min(min(m));
m=(m./max(max(m)));
m=m.* (127.5/(mean(mean(m))));