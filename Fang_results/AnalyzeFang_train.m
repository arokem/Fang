function out = AnalyzeFang_train(subject, session)

load ([subject, '_' , num2str(session)])

th = [params.questParams.maxC*10^QuestQuantile(history{1}.q,0.5)];

ub = [params.questParams.maxC*10^QuestQuantile(history{1}.q,0.975)];

lb = [params.questParams.maxC*10^QuestQuantile(history{1}.q,0.025)];

out.th = th;
out.ub = ub;
out.lb = lb;

errorbar(params.stimParams.testTilt,th,[ub-lb]/2)