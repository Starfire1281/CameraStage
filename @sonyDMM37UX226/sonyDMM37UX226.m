classdef sonyDMM37UX226 < handle

    properties
    
        format = 'Y16 _1920x1080';
        videoObject
        videoSource
        exposureTime = 0.0001;
        framesPerTrigger = 1;
        dataImage=[];
    
    end
    
    methods
    
        function this = sonyDMM37UX226
        end
    
        function initialize(this)
    
            this.videoObject = videoinput('winvideo',1,this.format);
            this.videoSource = getselectedsource(this.videoObject);
            
            set(this.videoObject,'triggerRepeat',Inf);
            triggerconfig(this.videoObject,'manual');
            set(this.videoObject,'FramesPerTrigger',this.framesPerTrigger);
    
            set(this.videoSource,'FrameRate','5.0000');
            set(this.videoSource,'Exposure',this.exposureTime);
    
    
            start(this.videoObject);
    
            % we trigger and get an initial image so that Matlab can inherently
            % initialize the dataImage with the correct size. This makes
            % calls to grabImage much faster
            trigger(this.videoObject);
            this.dataImage = getdata(this.videoObject,1);
            
    
        end
    
    
        function uninitialize(this)
            stop(this.videoObject);
        end
    
        function grabImage(this)
    
            trigger(this.videoObject);
            this.dataImage = double(getdata(this.videoObject,1));
        end
    
        function grabsnapshot(this)
            this.dataImage = getsnapshot(this.videoObject);
        end
    
    end

end