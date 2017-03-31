classdef  CarProphet
    properties(Access = 'public')
       % Object for recognize 
       Mat;
       Video;
       %%
       STATE=-1;% Attention: STATE is the program's status. 0 represents image, 1 represents video.
       %%
       END=false;% Attention: END is an instruction to play or stop the video
       %%
       RealRegion; % [x y width height] or a matrix of it.
       %%
       Threshold=0.5; % judge the bbox by this value. (is car or not??)
    end
    
    %%
    % our model :RCNNModel, ClassifyModel. "class_array" is the index of car type. 
    properties(Access = 'private')
       RCNNModel;
       ClassifyModel;
       class_array;
    end
    %%
    methods(Access = 'public')
        % Constructor of the class
        function Predictor = CarProphet(RCNNModelRoad,ClassifyModelRoad,ClassNameRoad)
                Predictor.RCNNModel=load(RCNNModelRoad);
                Predictor.ClassifyModel=load(ClassifyModelRoad);
                Predictor.class_array=load(ClassNameRoad);
        end
        % Function of load model
        function LoadRCNN(Predictor,RCNNModelRoad)
            Predictor.RCNNModel=load(RCNNModelRoad);
        end
        
        function LoadClassifyModel(Predictor,ClassifyModelRoad)
            Predictor.ClassifyModel=load(ClassifyModelRoad);
        end
        %%
        % 4 steps:load pic->selective_search(proposal)-> rcnn_forward -> classify
        % Attention: selective_search and rcnn_forward are not directly
        % linked here because a large number of proposals, but you can find
        % a way to link it in draw.m 
        
        function [Proposal,Scores]=selective_search(Predictor)
            [Proposal,Scores]=Predictor.RCNNModel.cifar10NetRCNN.RegionProposalFcn(Predictor.Mat);
        end
        
        
        function RealRegion=rcnn_forward(Predictor)
           [bboxes, scores, ~]= Predictor.RCNNModel.cifar10NetRCNN.detect(Predictor.Mat);
           CarScores=scores(:,1);
           HighProbROI_Index=find(CarScores>Predictor.Threshold);
           RealRegion=bboxes(HighProbROI_Index,:);
        end
        
        
        function [rois,classes]=classify(Predictor)
            size_=size(Predictor.RealRegion);
            length_=size_(1);
            img_batch4d=zeros(227,227,3,length_);
            for i=1:length_
              crop_roi=Predictor.RealRegion(i,:);
              img_single=imcrop(Predictor.Mat,crop_roi);
              img_single=imresize(img_single,[227 227]);
              img_batch4d(:,:,:,i)=img_single; % Constructing 4d-array images
            end
              if(~isempty(img_batch4d))
                  label_nums=Predictor.ClassifyModel.AlexNet_New.classify(img_batch4d);
                  %draw labels in picture
                  classes=Predictor.class_array.class_names(label_nums);
                  rois=Predictor.RealRegion;
              end
        end
        
        
        function [rois,classes]=understand(Predictor)
            Predictor.RealRegion=Predictor.rcnn_forward;
            [rois,classes]=Predictor.classify;
        end
        
        
    end
end