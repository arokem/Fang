function Fang_mkAdapt(params)

%Make some local variables:
cenL=params.displayParams.numPixels(1)/2;
cenT=params.displayParams.numPixels(2)/2;
x_ecc=params.stimParams.x_ecc;
y_ecc=params.stimParams.y_ecc;
g=params.stimParams.SD;

%X coordinates:
%Right box:
X=[cenL+x_ecc+0.5*g];
%Left box:
X=[X cenL-(x_ecc+0.5*g)];

%Y coordinates
%left box:
Y=[cenT cenT];
%Right box:
Y=[Y cenT cenT];

for i=1:size(X)
    thisX = X(i);
    thisY = Y(i);

    locat1=thisX-params.stimParams.SD/2;
    locat2=thisY-params.stimParams.SD/2;
    locat3=thisX+params.stimParams.SD/2;
    locat4=thisY+params.stimParams.SD/2;

    Screen('DrawTexture', params.displayParams.windowPtr , params.stim{1}, [], [locat1 locat2 locat3 locat4],[],[],1.0);
end
