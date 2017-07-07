function params = Fang_params

subjectID= inputdlg('What is the subject ID?');
params.subjectID=subjectID{1};

%////Design F& Procedure Parameters\\\\\
dlg_prompt={'Enter the number of trials:'};
dlg_name='Number of trials';
dlg_numlines=1;
dlg_defaultanswer={'200'};
a=inputdlg(dlg_prompt,dlg_name,dlg_numlines,dlg_defaultanswer);
params.numOfTrials = str2num(a{1});

dlg_prompt={'Enter the number of trials between pauses:'};
dlg_name='Pause after';
dlg_numlines=1;
dlg_defaultanswer={'50'};
a=inputdlg(dlg_prompt,dlg_name,dlg_numlines,dlg_defaultanswer);
params.pauseAfterTrials = str2num(a{1});

isTraining= questdlg('Is this a training session?','Training','Y','N','N');
if isTraining == 'Y'
    disp('Running the training version!')
    params.numOfTrials = 40;
    params.stimParams.testTilt = [5];

else 
params.stimParams.testTilt = [0 5 10 15 45]; %Use integers only! Fang et al: [0 7.5 30 90]
end

displayChoice = 9; %getScannerDisplay 
params.displayParams=getScannerDisplay(displayChoice);

%////Stimulus Parameters\\\\\
%this is where we specify what we would like:
params.stimParams.X_ecc_angle = 2.5; %Fang et al: 4.5 
params.stimParams.Y_ecc_angle = 0;
%This does the computation from the display params:  
params.stimParams.x_ecc = Fang_ang2pix(params.stimParams.X_ecc_angle,params.displayParams);  %these are the ones going to the other functions
params.stimParams.y_ecc = Fang_ang2pix(params.stimParams.Y_ecc_angle,params.displayParams);     %eccentricity of the center of the meshgrid/the flower
%this is the one to modify spatial Freq [cycles/deg]: 
params.stimParams.SF_angles = 1.5; %Fang et al: 2.5 cycles/deg   
%This is a computation from the display params:
params.stimParams.SF = params.stimParams.SF_angles./Fang_ang2pix(1, params.displayParams);       
%this is where we specify what we would like (in degrees):
params.stimParams.SD_angles= 2; %Fang et al: 0.7                    
%This is a computation from the display params:
params.stimParams.SD=Fang_ang2pix(params.stimParams.SD_angles,params.displayParams); %space constant of the gabor = the width of the gaussian envelope [deg] this is the size of the gabor
params.stimParams.testSDfactor=0.6; %How much smaller is the test stimulus. Fang et al: 0.6
params.stimParams.stimSize = params.stimParams.SD *6; 

params.stimParams.fixSize=0.3;    %how large is the fixation cross
params.stimParams.adaptContrast=1; %(Lmax-Lmin)/(Lmax-Lmin)


%%%%% Adaptor tilt: obliques = 45,135 cardinals = 0,90

params.stimParams.adaptTilt=135; 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%
params.stimParams.frameWidth=0.05;
params.stimParams.frameColor = 0.6;% on a 0-1 scale

%////Auditory feedback Parameters\\\\\

params.feedback.cue = sin(1:1:100);
params.feedback.incorrect = sin(0.1:0.25:700);
params.feedback.correct = sin(1:0.5:100); 
params.feedback.eyeMotion=sin(0.1:0.25:700)+sin(0.1:0.5:1400)+sin(0.1:0.75:2100)+sin(0.1:0.125:350);

%////Timing Parameters\\\\\

milli=0.001;
params.timing.preAdaptDur = 20; %Fang et al: 20 sec
params.timing.topUpAdaptDur= 5; %Fang et al: 5 sec
params.timing.postAdaptInterval = 500*milli; % Fang et al: 500 msec
params.timing.stimDur = 200*milli;
params.timing.respDur = inf; %If you want to limit response duration

%////Human interface device (the button box/keyboard)\\\

params.HID.device=3; %1=The Targus numpad; 3=keyboard (but need to change stuff in the getResponse, if you use the keyboard!)

params.HID.deviceEyeMotion=6; %3 for keyboard; 0 for no eye motion monitoring

%////Quest params:\\\

params.questParams.QuestCGuess=0.25;
params.questParams.QuestCGuessSd=0.25;
params.questParams.maxC=1;

