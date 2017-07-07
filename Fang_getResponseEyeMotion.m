function eyeMotion=Fang_getResponseEyeMotion(device)

keyIsDown=0;

while keyIsDown==0

    [keyIsDown,secs,keyCode]=PsychHID('KbCheck',device);

end

keyPressed=KbName(keyCode);

if sum(keyCode)>1
    eyeMotion=0;
    return
end

if keyPressed=='q'
    sca;
end

if kbName(keyCode)=='1'
    eyeMotion=0;
else
    eyeMotion=1;
end



