
load('cars_meta.mat');
load('cifar10NetRCNN.mat') %for detect
load('AlexNet_New.mat');%for recognition

VideoObject=VideoReader('Car1.mp4');
VideoObject.CurrentTime = 0;
currAxes = axes;

while hasFrame(VideoObject)
   frame = readFrame(VideoObject);
   %crop:
   frame=imresize(frame,[480 640]);
   outputImage=frame;
   % DetectRCNN(frame,cifar10NetRCNN);
   [bboxes, ~, ~] = detect(cifar10NetRCNN, frame);
   
   %crop:
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
   image(outputImage, 'Parent', currAxes);
   currAxes.Visible = 'off';
   pause(1/VideoObject.FrameRate);
end
