function varargout = MainWindow(varargin)
% MAINWINDOW MATLAB code for MainWindow.fig
%      MAINWINDOW, by itself, creates a new MAINWINDOW or raises the existing
%      singleton*.
%
%      H = MAINWINDOW returns the handle to a new MAINWINDOW or the handle to
%      the existing singleton*.
%
%      MAINWINDOW('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAINWINDOW.M with the given input arguments.
%
%      MAINWINDOW('Property','Value',...) creates a new MAINWINDOW or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before MainWindow_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to MainWindow_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help MainWindow

% Last Modified by GUIDE v2.5 24-Mar-2017 23:20:04

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @MainWindow_OpeningFcn, ...
                   'gui_OutputFcn',  @MainWindow_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
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



% --- Executes just before MainWindow is made visible.
function MainWindow_OpeningFcn(hObject, eventdata, handles, varargin)

% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to MainWindow (see VARARGIN)

% Choose default command line output for MainWindow
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

%设置识别阈值为50
set(handles.JudgeParamSilder,'Value',0.5);
global Predictor;
Predictor.Threshold=get(handles.JudgeParamSilder,'value');
% UIWAIT makes MainWindow wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = MainWindow_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

function LoadPicture_Callback(hObject, eventdata, handles)
global Predictor;
[filename, pathname] = uigetfile({'*.jpg';'*.png'},'读取图片文件'); %选择图片文件
if isequal(filename,0)   %判断是否选择
   msgbox('没有选择任何图片');
else
   pathfile=fullfile(pathname, filename);  %获得图片路径
   Mat_=imread(pathfile);
   Predictor.Mat=imresize(Mat_,[240 320]);
   Predictor.STATE=0;
   axes(handles.SrcPicture);
   imshow(Predictor.Mat);
end

% --- Executes on button press in LoadVideo.
function LoadVideo_Callback(hObject, eventdata, handles)
global Predictor;
[filename, pathname] = uigetfile({'*.avi';'*.mp4'},'读取视频文件');
if isequal(filename,0) 
   msgbox('没有选择任何视频');
else
   pathfile=fullfile(pathname, filename);
   Predictor.Video=VideoReader(pathfile); 
   Predictor.STATE=1; %set mode
   Predictor.Video.CurrentTime=339; % choose by your self...
   figure(1);
   while hasFrame(Predictor.Video)
   Predictor.Mat=readFrame(Predictor.Video);
   if (~Predictor.END)
       imshow(Predictor.Mat);
       pause(0.0001);
   else
       break;
   end
   end
end

% --- Executes on slider movement.
function JudgeParamSilder_Callback(hObject, eventdata, handles)
global Predictor;
param_0_1=get(handles.JudgeParamSilder,'value');
Predictor.Threshold=param_0_1;
set(handles.JudgeParam,'String',num2str(param_0_1*100));

% --- Executes during object creation, after setting all properties.
function JudgeParamSilder_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on button press in LoadRCNN.
function LoadRCNN_Callback(hObject, eventdata, handles)
global Predictor;
[filename, pathname] = uigetfile({'*.mat'},'读取RCNN');
if isequal(filename,0)   
   msgbox('没有选择任何模型，将默认选用系统设置');
else
   pathfile=fullfile(pathname, filename);  
   Predictor.LoadRCNN(pathfile);    
   msgbox('读入成功');
end

% --- Executes on button press in LoadClassification.
function LoadClassification_Callback(hObject, eventdata, handles)
global Predictor;
[filename, pathname] = uigetfile({'*.mat'},'读取分类模型');
if isequal(filename,0)
   msgbox('没有选择任何模型，将默认选用系统设置');
else
   pathfile=fullfile(pathname, filename); 
   Predictor.LoadClassifyModel(pathfile);    
   msgbox('读入成功');
end

% --- Executes on button press in ManualSelect.
function ManualSelect_Callback(hObject, eventdata, handles)
global Predictor;
if(isempty(Predictor.Mat))
    warndlg('请先载入图片,在原图像区域进行选取','警告','modal');
else
    msgbox('请在原图像区域进行选取','注意','modal');
    axes(handles.SrcPicture);
    Bbox=getPosition(imrect);
    Predictor.RealRegion=Bbox;
end

% --- Executes on button press in FinishSelect.
function FinishSelect_Callback(hObject, eventdata, handles)
global Predictor;
[rois,classes]=Predictor.classify;
DrawMat=draw_roi_class(Predictor.Mat,rois,classes);
axes(handles.Classification);
imshow(DrawMat);

% --- Executes on button press in RegionProposal.
function RegionProposal_Callback(hObject, eventdata, handles)
global Predictor;
if(Predictor.STATE==0)
[Proposals,Scores]=Predictor.selective_search;
HighScoreProposals=get_highscore_proposals(Proposals,Scores);
DrawMat=draw(Predictor.Mat,HighScoreProposals);
axes(handles.SelectiveSearch);
imshow(DrawMat);
end
if(Predictor.STATE==1)
    % Attention: through change 'END', terminate video.
   Predictor.END=true;
   Predictor.END=false;
   figure(1);
   while hasFrame(Predictor.Video)
       Predictor.Mat=readFrame(Predictor.Video);
       if (~Predictor.END)
       [Proposals,Scores]=Predictor.selective_search;
       HighScoreProposals=get_highscore_proposals(Proposals,Scores);
       DrawMat=Predictor.Mat;
       DrawMat=draw(DrawMat,HighScoreProposals);
       imshow(DrawMat);
       pause(0.00001);
       else
           break;
       end
   end
end

% --- Executes on button press in FinetuneROI.
function FinetuneROI_Callback(hObject, eventdata, handles)
global Predictor;
if(Predictor.STATE==0)
Predictor.RealRegion=Predictor.rcnn_forward;
DrawMat=Predictor.Mat;
DrawMat=draw(DrawMat,Predictor.RealRegion);
axes(handles.RealObject);
imshow(DrawMat);
end
   if(Predictor.STATE==1)
   % Attention: through change 'END', terminate video.
   Predictor.END=true;
   Predictor.END=false;
   figure(1);
   while hasFrame(Predictor.Video)
   Predictor.Mat=readFrame(Predictor.Video);
     if (~Predictor.END)
     Predictor.RealRegion=Predictor.rcnn_forward;
     DrawMat=Predictor.Mat;
     DrawMat=draw(DrawMat,Predictor.RealRegion);
     imshow(DrawMat);
     pause(0.00001);
     else
       break;    
     end
   end
   end

% --- Executes on button press in Classify.
function Classify_Callback(hObject, eventdata, handles)
global Predictor;
if(Predictor.STATE==0)
[rois,classes]=Predictor.classify;
DrawMat=draw_roi_class(Predictor.Mat,rois,classes);
axes(handles.Classification);
imshow(DrawMat);
end
if(Predictor.STATE==1)
    % Attention: through change 'END', terminate video.
   Predictor.END=true;
   Predictor.END=false;
   figure(1);
   while hasFrame(Predictor.Video)
   Predictor.Mat=readFrame(Predictor.Video);
     if (~Predictor.END)
     [rois,classes]=Predictor.understand;
     DrawMat=draw_roi_class(Predictor.Mat,rois,classes);
     imshow(DrawMat);
     pause(0.00001);
     else
         break;
     end
   end
   
end

% --- Executes on button press in UnderStand.
function UnderStand_Callback(hObject, eventdata, handles)
global Predictor;
[rois,classes]=Predictor.understand;
DrawMat=draw_roi_class(Predictor.Mat,rois,classes);
axes(handles.Classification);
imshow(DrawMat);


