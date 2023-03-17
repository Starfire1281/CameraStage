formats = ["Y12p_1920x1080","Y12p_3840x2160","Y12p_4000x3000","Y12p_640x480","Y16 _1920x1080","Y16 _3840x2160","Y16 _4000x3000","Y16 _640x480","Y800_1920x1080","Y800_3840x2160","Y800_4000x3000","Y800_640x480"];

for i = 1:12
    try
        camera.videoObject = videoinput('winvideo','2',formats(i));
    catch 
        disp(formats(i));
        disp("does not work");
    end
end  