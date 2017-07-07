function Fang_mkFix(params)

%Make local variables which are more wieldy - 
%dimensions determining the box location and size in units of pixels: 

x=params.stimParams.x_ecc;  %How far from the center are things? 
y=params.stimParams.y_ecc;  %How far are they offset (0 for now) 
res=params.displayParams.numPixels; %The dimensions of the display
g=params.stimParams.SD;
cenL=res(1)/2;            %The horizontal center from left
cenT=res(2)/2;            %The vertical center from the top

wPtr = params.displayParams.windowPtr; 

%Draws the fixation: 
Screen('TextSize',wPtr,round(Fang_ang2pix(params.stimParams.fixSize, params.displayParams)));
Screen ('DrawText', wPtr, '+', cenL, cenT,  params.white); %displayParams.reservedColor(findName(params.displayParams.reservedColor,'white')).gunVal

%Draws the boxes surrounding the fixation: 
%First box - right:
c=[cenL+x cenT+g]; %Coordinates of bottom line
Screen('DrawLine', wPtr,[params.stimParams.frameColor*params.white params.stimParams.frameColor*params.white params.stimParams.frameColor*params.white], c(1), c(2), c(1)+3*g, c(2) ,Fang_ang2pix(params.stimParams.frameWidth, params.displayParams));
c=[cenL+x cenT-g]; %Coordinates of top line
Screen('DrawLine', wPtr,[params.stimParams.frameColor*params.white params.stimParams.frameColor*params.white params.stimParams.frameColor*params.white], c(1), c(2), c(1)+3*g, c(2) ,Fang_ang2pix(params.stimParams.frameWidth, params.displayParams));
c=[cenL+x cenT-g]; %Coordinates of left line
Screen('DrawLine', wPtr,[params.stimParams.frameColor*params.white params.stimParams.frameColor*params.white params.stimParams.frameColor*params.white], c(1), c(2), c(1), c(2)+2*g ,Fang_ang2pix(params.stimParams.frameWidth, params.displayParams));
c=[cenL+x+3*g cenT-g]; %Coordinates of right line
Screen('DrawLine', wPtr,[params.stimParams.frameColor*params.white params.stimParams.frameColor*params.white params.stimParams.frameColor*params.white], c(1), c(2), c(1), c(2)+2*g ,Fang_ang2pix(params.stimParams.frameWidth, params.displayParams));

%Second box - left: 
c=[cenL-(x+3*g) cenT+g]; %Coordinates of bottom line
Screen('DrawLine', wPtr,[params.stimParams.frameColor*params.white params.stimParams.frameColor*params.white params.stimParams.frameColor*params.white], c(1), c(2), c(1)+3*g, c(2) ,Fang_ang2pix(params.stimParams.frameWidth, params.displayParams));
c=[cenL-(x+3*g) cenT-g]; %Coordinates of top line
Screen('DrawLine', wPtr,[params.stimParams.frameColor*params.white params.stimParams.frameColor*params.white params.stimParams.frameColor*params.white], c(1), c(2), c(1)+3*g, c(2) ,Fang_ang2pix(params.stimParams.frameWidth, params.displayParams));
c=[cenL-(x+3*g) cenT-g]; %Coordinates of left line
Screen('DrawLine', wPtr,[params.stimParams.frameColor*params.white params.stimParams.frameColor*params.white params.stimParams.frameColor*params.white], c(1), c(2), c(1), c(2)+2*g ,Fang_ang2pix(params.stimParams.frameWidth, params.displayParams));
c=[cenL-x cenT-g]; %Coordinates of right line
Screen('DrawLine', wPtr,[params.stimParams.frameColor*params.white params.stimParams.frameColor*params.white params.stimParams.frameColor*params.white], c(1), c(2), c(1), c(2)+2*g ,Fang_ang2pix(params.stimParams.frameWidth, params.displayParams));

%Call to Screen('Flip') upon exiting this function should bring up the
%image! 