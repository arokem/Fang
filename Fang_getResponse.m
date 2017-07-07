function [respTime correct] = Fang_getResponse(side, respDur, device)

startTime=GetSecs; %getSecs is a built in function, startTime is a variable that tells us when getResponse is called


    two = '2';
    one = '1';

keyIsDown=0;

while keyIsDown==0 && GetSecs-startTime<respDur
    
[keyIsDown,secs,keyCode]=PsychHID('KbCheck',device);
    
end

respTime=secs-startTime;

if sum(keyCode)>1
    correct=0;
    return
end

if keyIsDown==0
keyCode=95; 
end

keyPressed=KbName(keyCode);

if keyPressed=='9'
    sca;
end

if keyPressed=='7'
    correct=NaN;
    respTime=NaN;
return
end
    
if side>0
    if keyPressed==two
        correct=1;
    else
        correct=0;
    end
else
    if keyPressed==one
        correct=1;
    else
        correct=0;

    end

end




