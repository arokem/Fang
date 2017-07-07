%Fang.m
%
%Cross-orientation post-adaptation detection paradigm
%Taken from Fang et al. (2005)
%
%Subjects view a pair of oriented gratings, thereafter a low-contrast
%oriented grating is presented in one of the two locations. Subjects
%perform a 2AFC on the location of the post-adaptation grating. Separate
%staircases are applied to each adaptation-detection orientation offset, to
%determine the Curve of Orientation Adaptation Tuning(CAT).
%
%102408 ASR wrote it, based on the SPOOF code base

clear all; close all;
Priority(0);
Screen('Preference', 'SkipSyncTests', 1);

%Initialize parameters and start the display:
params = Fang_params;


HideCursor;
params.gray=GrayIndex(params.displayParams.windowPtr);
params.white=WhiteIndex(params.displayParams.windowPtr);

%Set GL mode:
Screen('BlendFunction', params.displayParams.windowPtr,GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA);


Screen('FillRect',params.displayParams.windowPtr,params.gray);

params.CLUT=Screen('LoadNormalizedGammaTable', params.displayParams.windowPtr, params.displayParams.gammaTable );


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

mat_adapt = Fang_mkGabor(params.stimParams.SF,params.stimParams.SD,params.stimParams.stimSize.*[1 1]);
params.stim{1}=Screen('MakeTexture', params.displayParams.windowPtr, mat_adapt ,1 ,0 ,0);

%Initialize the struct where data will be recorded:
for condition=1:length(params.stimParams.testTilt)
    history{condition} = Fang_makeHistory(params);
    mat_stim = Fang_mkGabor(params.stimParams.SF,params.stimParams.SD*params.stimParams.testSDfactor,params.stimParams.stimSize.*[1 1]);
    params.stim{condition+1} = Screen('MakeTexture', params.displayParams.windowPtr, mat_stim ,1 ,0 ,0);
end

%Start some local variables used to control the staircase:
trialList=mod(randperm(params.numOfTrials),length(params.stimParams.testTilt))+1;
local_corr=[];
%First trial is a pre-adapt trial:
params.isPreAdapt = 1;

%Trial loop
for nTrial=1:params.numOfTrials
    %     %ListenChar(1)
    %     if nTrial==1
    %         Screen('TextSize', params.displayParams.windowPtr ,12);
    %         textToPut=['Press any key to start the next trial'];
    %         Screen('DrawText', params.displayParams.windowPtr,textToPut, params.displayParams.numPixels(1)/2, params.displayParams.numPixels(2)/2, params.white);
    %         Screen('Flip', params.displayParams.windowPtr);
    %         pause
    %         params.isPreAdapt = 1;
    %
    %     else
    if ~mod(nTrial-1,params.pauseAfterTrials) %Pause and give feedback about performance in the last block of trials
        Screen('TextSize', params.displayParams.windowPtr,32);
        text1=['Press any key to start the next trial'];
        Screen('DrawText', params.displayParams.windowPtr,text1, params.displayParams.numPixels(1)/2, params.displayParams.numPixels(2)/2, params.white);

        local_corr=nanmean(local_corr);
        if ~isnan(local_corr)
        text2=['You got: ' num2str(100*local_corr) '% correct'];
        Screen('DrawText', params.displayParams.windowPtr,text2, params.displayParams.numPixels(1)/2, params.displayParams.numPixels(2)/2+32, params.white);
        end
        Screen('Flip', params.displayParams.windowPtr);
        local_corr=[];
        local_RT=[];

        %Use getResponse in order to make sure that responses are
        %registered only from the numpad and not from the keyboard:
        %[dummyRT dummyCorrect]=Fang_getResponse(0, inf, params.HID.device);
        %Dummy variables are made, but don't mean anything.

        %Run the trial in which pre-adaptation does occur:
        %       ListenChar(2)
        pause
        params.isPreAdapt = 1;
        history = Fang_doTrial(params, history, trialList(nTrial));
        local_corr=[local_corr history{trialList(nTrial)}.correct(length(history{trialList(nTrial)}.correct))];
        params.isPreAdapt = 0;

    else
        history = Fang_doTrial(params, history, trialList(nTrial));
        params.isPreAdapt = 0;
        %Variables that are used only in order to give feedback between
        %blocks:
        local_corr=[local_corr history{trialList(nTrial)}.correct(length(history{trialList(nTrial)}))];

    end

end

%ListenChar(1)


%Save the history at the end of the trial loop
%File name includes the subject id and an index:

chdir('Fang_results');
fileList=dir;
fileCount=0;
for fileIndex=1:length(fileList)
    if strfind(fileList(fileIndex).name,params.subjectID)
        fileCount=fileCount+1;
    end
end

time=datestr(now);
fileName=[params.subjectID,'_',num2str(fileCount+1)];
save(fileName,'history', 'params','trialList','time');

chdir('..')

Screen('CloseAll');

