function out = Fang_analyze_training(subject, session) 

load (['Fang_results/' subject, '_train_' num2str(session) '.mat']) 
out.lb = params.questParams.maxC*10^QuestQuantile(history{1}.q,0.025);
out.ub =params.questParams.maxC*10^QuestQuantile(history{1}.q,0.975);

out.th =params.questParams.maxC*10^QuestQuantile(history{1}.q,0.5);

out.ci_size = (out.ub-out.lb)*100; 

