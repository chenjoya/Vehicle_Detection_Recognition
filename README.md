-----------------------------------------------------------------------------------------------------

## UPDATE!!!

We redesigned the GUI, and the program was optimized.

Have a look:

1、4 steps for pic recognition:
![](http://img.blog.csdn.net/20170331082108445?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvTXJfQ3Vycnk=/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)
![](http://img.blog.csdn.net/20170331082231677?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvTXJfQ3Vycnk=/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)
![](http://img.blog.csdn.net/20170331082302743?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvTXJfQ3Vycnk=/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)
![](http://img.blog.csdn.net/20170331082358054?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvTXJfQ3Vycnk=/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)

2、You can select bounding-box by yourself:
![](http://img.blog.csdn.net/20170331082605869?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvTXJfQ3Vycnk=/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)

3、Video:
![](http://img.blog.csdn.net/20170331082818917?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvTXJfQ3Vycnk=/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)

4、Load your own model:
![](http://img.blog.csdn.net/20170331082922125?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvTXJfQ3Vycnk=/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)

-----------------------------------------------------------------------------------------------------

# Vehicle_Detection_Recognition
This is a Matlab lesson design for vehicle detection and recognition.  Using cifar-10Net to training a RCNN, and finetune AlexNet to classify. Thanks to Cars Dataset : http://ai.stanford.edu/~jkrause/cars/car_dataset.html

## Software

Matlab R2016b

## Doadload

cars_meta.mat : http://pan.baidu.com/s/1mi6nvr6

cifar10NetRCNN.mat : (for Car position detection)  http://pan.baidu.com/s/1geLa1V1

AlexNet_New.mat : (for Car type classify) http://pan.baidu.com/s/1bEzcYE

## Code 

You can use it to finish your task for single picture or video. Make sure your picture or video frame has 3 channels (colorful)

## Citation

3D Object Representations for Fine-Grained Categorization
       Jonathan Krause, Michael Stark, Jia Deng, Li Fei-Fei
       4th IEEE Workshop on 3D Representation and Recognition, at ICCV 2013 (3dRR-13). Sydney, Australia. Dec. 8, 2013.
       
DataSet : http://ai.stanford.edu/~jkrause/cars/car_dataset.html

## Effect

![](http://img.blog.csdn.net/20161122152409064)
![](http://img.blog.csdn.net/20161122152440557)
![](http://img.blog.csdn.net/20161122152449448)
![](http://img.blog.csdn.net/20161122152457760)
![](https://github.com/Prof-Stephencurry/Vehicle_Detection_Recognition/blob/master/pic.gif)
![](https://github.com/Prof-Stephencurry/Vehicle_Detection_Recognition/blob/master/video.gif)

Actually, The running speed of the program is a bit of slow... Hope you can try Faster-Rcnn or yolo (you only look once).




