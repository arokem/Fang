
function history=Fang_makeHistory (params)

history.RT = [];
history.correct=[];
history.eyeMotion=[];
history.C=[];
history.sideTarget = [];

%%%%%%QUEST%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

pThreshold = 0.82;
beta = 3.5; delta = 0.01; gamma = 0.5;
tGuess = log10(params.questParams.QuestCGuess/params.questParams.maxC);
tGuessSd= log10(params.questParams.QuestCGuessSd);

history.q=QuestCreate(tGuess,tGuessSd,pThreshold,beta,delta,gamma);
history.q.normalizePdf=1; %This is important for some reason.

history.t=[];
history.sd=[];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
