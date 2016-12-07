function varargout = shibie(varargin)
%SHIBIE MATLAB code file for shibie.fig
%      SHIBIE, by itself, creates a new SHIBIE or raises the existing
%      singleton*.
%
%      H = SHIBIE returns the handle to a new SHIBIE or the handle to
%      the existing singleton*.
%
%      SHIBIE('Property','Value',...) creates a new SHIBIE using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to shibie_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      SHIBIE('CALLBACK') and SHIBIE('CALLBACK',hObject,...) call the
%      local function named CALLBACK in SHIBIE.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help shibie

% Last Modified by GUIDE v2.5 23-Nov-2016 13:21:29

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @shibie_OpeningFcn, ...
                   'gui_OutputFcn',  @shibie_OutputFcn, ...
                   'gui_LayoutFcn',  [], ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
   gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before shibie is made visible.
function shibie_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)

% Choose default command line output for shibie
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes shibie wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
mainHandle=dh(); 
pause(3);
close(mainHandle); 

function varargout = shibie_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in load.
function load_Callback(hObject, eventdata, handles)
global class_names;
global cifar10NetRCNN;
global AlexNet_New;
axes(handles.axes4);

[filename,pathname]=uigetfile({'*.mp4';'*.avi';'*.rmvb'},'—°‘Ò ”∆µ');
if isequal(filename,0)
 disp('Users Selected Canceled');
else
str=[pathname filename];
end

VideoObject=VideoReader(str);
VideoObject.CurrentTime = 339;

while hasFrame(VideoObject)
   frame = readFrame(VideoObject);
   %crop:
   frame=imresize(frame,[480 640]);
   outputImage=frame;
   % DetectRCNN(frame,cifar10NetRCNN);
   [bboxes, score, ~] = detect(cifar10NetRCNN.cifar10NetRCNN, frame);
   
   if  ~isempty(bboxes)
   [~, idx] = max(score);
   box=bboxes(idx,:);
   frame_=imcrop(frame,box);
   frame_=imresize(frame_,[227 227]);
   type_num=classify(AlexNet_New.AlexNet_New,frame_);
   outputImage=insertObjectAnnotation(outputImage, 'rectangle', box, class_names.class_names{type_num},'LineWidth',3);
   end
   %crop:
%    if  ~isempty(bboxes)
%    size_array=size(bboxes);
%    length=size_array(1);
%    for i=1:length
%        box=bboxes(i,:);
%      frame_=imcrop(frame,box);
%      frame_=imresize(frame_,[227 227]);
%      type_num=classify(AlexNet_New.AlexNet_New,frame_);
%      outputImage=insertObjectAnnotation(outputImage, 'rectangle', box, class_names.class_names{type_num},'LineWidth',3);
%    end
%    end
   image(outputImage);
   pause(0.000001);
end



% --- Executes on button press in Distinguish.
function Distinguish_Callback(hObject, eventdata, handles)
disp('sssssss');
% hObject    handle to Distinguish (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on button press in exit.
function exit_Callback(hObject, eventdata, handles)
% hObject    handle to exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(gcf);


% --- Executes on button press in picture.
function picture_Callback(hObject, eventdata, handles)
global class_names;
global cifar10NetRCNN;
global AlexNet_New;
axes(handles.axes4);

[filename,pathname]=uigetfile({'*.jpg';'*.bmp';'*.gif'},'—°‘ÒÕº∆¨');
if isequal(filename,0)
 disp('Users Selected Canceled');
else
    
str=[pathname filename];
frame=imread(str);
frame=imresize(frame,[480 640]);
outputImage=frame;

   % DetectRCNN(frame,cifar10NetRCNN);
   [bboxes, ~, ~] = detect(cifar10NetRCNN.cifar10NetRCNN, frame);
   
   if  ~isempty(bboxes)
   size_array=size(bboxes);
   length=size_array(1);
   for i=1:length
       box=bboxes(i,:);
       frame_=imcrop(frame,box);
       frame_=imresize(frame_,[227 227]);
       type_num=classify(AlexNet_New.AlexNet_New,frame_);
       outputImage=insertObjectAnnotation(outputImage, 'rectangle', box, class_names.class_names{type_num},'LineWidth',3);
   end
   end
   imshow(outputImage);



end
