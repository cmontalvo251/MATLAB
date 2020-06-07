function convertAVI2Frames(filename,FPS)

% You can do this in bash using
% mplayer -vo jpeg -endpos 4 myvideo.mp4

obj = mmreader(filename);
vid = read(obj);
frames = obj.NumberOfFrames;
time = 0;
for x = 1 : frames
    imwrite(vid(:,:,:,x),strcat('Frames/frame-',num2str(time),'.tif'));
    time = time + 1/FPS;
end
% Copyright - Carlos Montalvo 2015
% You may freely distribute this file but please keep my name in here
% as the original owner
