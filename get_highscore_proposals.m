function HighScoreProposals=get_highscore_proposals(Proposals,Scores)
%score 归一化
 score_0_1_=mapminmax(Scores',0,1);
 
 %选择阈值
 score_more_index=find(score_0_1_>0.5);
 
 %得到得分高的proposals
 HighScoreProposals=Proposals(score_more_index,:);
end