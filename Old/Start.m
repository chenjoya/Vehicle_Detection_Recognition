%to define a global data

addpath('testImage_Video/');
addpath('model/');
addpath('gui/')
global class_names cifar10NetRCNN AlexNet_New;
class_names=load('cars_meta.mat');
cifar10NetRCNN=load('cifar10NetRCNN.mat'); %for detect
AlexNet_New=load('AlexNet_New.mat');%for recognition

shibie;

