function Fang_mkStim(params,side,stim,C,rotation)

%Make some local variables:
cenL=params.displayParams.numPixels(1)/2;
cenT=params.displayParams.numPixels(2)/2;
x_ecc=params.stimParams.x_ecc;
y_ecc=params.stimParams.y_ecc;
g=params.stimParams.SD;

%X coordinates:
if side>0
    %Right box:
    X=cenL+x_ecc+1.5*g;
else
    %Left box:
    X=cenL-(x_ecc+1.5*g);
end

%Y coordinates
%left box:
Y=cenT;

thisX = X;
thisY = Y;

locat1=thisX-params.stimParams.SD/2;
locat2=thisY-params.stimParams.SD/2;
locat3=thisX+params.stimParams.SD/2;
locat4=thisY+params.stimParams.SD/2;

Screen('DrawTexture', params.displayParams.windowPtr , stim, [], [locat1 locat2 locat3 locat4],rotation,[],C);

