
%for pic
load('cars_meta.mat');
load('cifar10NetRCNN.mat') %for detect
load('AlexNet_New.mat');%for recognition

frame=imread('2.jpg');
   %crop:
frame=imresize(frame,[480 640]);
outputImage=frame;
   % DetectRCNN(frame,cifar10NetRCNN);
   [bboxes, ~, ~] = detect(cifar10NetRCNN, frame);
   
   if  ~isempty(bboxes)
   size_array=size(bboxes);
   length=size_array(1);
   for i=1:length
       box=bboxes(i,:);
       frame_=imcrop(frame,box);
       frame_=imresize(frame_,[227 227]);
       type_num=classify(AlexNet_New,frame_);
       outputImage=insertObjectAnnotation(outputImage, 'rectangle', box, class_names{type_num},'LineWidth',3);
   end
   end
   imshow(outputImage);
