 function DrawMat=draw_roi_class(DrawMat,rois,classes)
            %draw box
            size_=size(rois);
            length_=size_(1);
            for i=1:length_
                     SingleBox_=rois(i,:);
                     DrawMat=insertObjectAnnotation(DrawMat, 'rectangle', SingleBox_, classes{i},'LineWidth',1);
            end
        end
