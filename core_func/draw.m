        function DrawMat=draw(DrawMat,HighScoreProposals)
            %draw box
            size_=size(HighScoreProposals);
            length_=size_(1);
            for i=1:length_
                     SingleBox_=HighScoreProposals(i,:);
                     DrawMat=insertObjectAnnotation(DrawMat, 'rectangle', SingleBox_, '','LineWidth',1);
            end
        end
        
