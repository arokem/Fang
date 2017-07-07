function history = Fang_doTrial(params, history, tilt)

%initialize some local variables:
RT = NaN;
%Randomly determine the location of the target
sideTarget = sign(randn);

%Determine the contrast in this trial, depending on the quest:

trialC=QuestQuantile(history{tilt}.q);
tTest=min(10^trialC,params.questParams.maxC);


%Put up the fixation and the stimulus boxes:

Fang_mkFix(params);

%If trial is the first in a 50 block: pre-adaptation
if params.isPreAdapt
    Fang_mkStim(params,-1,params.stim{1},1,params.stimParams.adaptTilt);
    Fang_mkStim(params,1,params.stim{1},1,params.stimParams.adaptTilt);
    Screen('Flip',params.displayParams.windowPtr);
    WaitSecs(params.timing.preAdaptDur);
    %Otherwise: top-up adaptation:
else
    Fang_mkStim(params,-1,params.stim{1},1,params.stimParams.adaptTilt);
    Fang_mkStim(params,1,params.stim{1},1,params.stimParams.adaptTilt);
    Screen('Flip',params.displayParams.windowPtr);
    WaitSecs(params.timing.topUpAdaptDur);
end

%Interstimulus interval
Fang_mkFix(params);
Screen('Flip',params.displayParams.windowPtr);
WaitSecs(params.timing.postAdaptInterval);

%Present target
Fang_mkFix(params);
Fang_mkStim(params,sideTarget,params.stim{tilt+1},tTest,params.stimParams.adaptTilt+(sign(randn)*params.stimParams.testTilt(tilt)));
Screen('Flip',params.displayParams.windowPtr);
sound(params.feedback.cue)

%Collect response
[RT correct] = Fang_getResponse(sideTarget, params.timing.stimDur, params.HID.device);

Fang_mkFix(params);
Screen('Flip',params.displayParams.windowPtr);

if isnan(RT)
    [RT correct] = Fang_getResponse(sideTarget, params.timing.respDur, params.HID.device);
    RT = RT + params.timing.stimDur;
end
%Give feedback
if isnan(correct)
    sound(params.feedback.incorrect)
elseif correct
    sound(params.feedback.correct)
else
    sound(params.feedback.incorrect)
end


%Check for eyemotion and update history

if params.HID.deviceEyeMotion

    eyeMotion=Fang_getResponseEyeMotion(params.HID.deviceEyeMotion);


    if eyeMotion==1

        history{tilt}.C = [history{tilt}.C NaN];
        history{tilt}.RT = [history{tilt}.RT NaN];
        history{tilt}.correct = [history{tilt}.correct NaN];
        history{tilt}.sideTarget = [history{tilt}.sideTarget sideTarget];

        sound(params.feedback.eyeMotion);

    else
        history{tilt}.C = [history{tilt}.C tTest];
        history{tilt}.RT = [history{tilt}.RT RT];
        history{tilt}.correct = [history{tilt}.correct correct];
        history{tilt}.sideTarget = [history{tilt}.sideTarget sideTarget];

    end

    history{tilt}.eyeMotion=[history{tilt}.eyeMotion eyeMotion];

else


    history{tilt}.C = [history{tilt}.C tTest];
    history{tilt}.RT = [history{tilt}.RT RT];
    history{tilt}.correct = [history{tilt}.correct correct];
    history{tilt}.sideTarget = [history{tilt}.sideTarget sideTarget];

end


%update Quest:

if ~isnan(correct)
    history{tilt}.q = QuestUpdate(history{tilt}.q,log10(tTest),correct);
    history{tilt}.t=[history{tilt}.t QuestMean(history{tilt}.q)];
    history{tilt}.sd=[history{tilt}.sd QuestSd(history{tilt}.q)];
end



