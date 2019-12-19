function [y,t_vec] = record_my_voice(time,PLAYBACK,RUNFFT)
close all
%%%%record_my_voice(time)
%%%time = length of record in seconds
%%%PLAYBACK = 1 for play recording back to user, 0 for off
%%%RUNFFT = 1 to run FFT and 0 to do nothing

recObj = audiorecorder;
disp('Start Speaking')
recordblocking(recObj,time);
disp('Stop Speaking')

y = getaudiodata(recObj);

t = linspace(0,time,length(y));

figure()
plot(t,y)

%%%Play the sound back
if PLAYBACK
    linux_play(y,recObj.SampleRate)
end

%%%%Run an FFT on this
%%%Clip the left end
if RUNFFT
    left = find(abs(y)==max(abs(y)));
    tleft = t(left:end);
    yleft = y(left:end);
    yleftabs = abs(yleft);
    yavg = [];
    tavg = [];
    skip = 1000;
    for idx = 1:skip:length(tleft)-skip
        tavg = [tavg;tleft(idx)];
        yavg = [yavg;max(yleftabs(idx:(idx+skip)))];
    end
    a = log(yavg/yavg(1));
    tnoinf = tavg;
    tnoinf(abs(a)==Inf) = [];
    dt = tnoinf - tavg(1);
    a(abs(a)==Inf) = [];
    tau = -mean(a(2:end)./dt(2:end));
    yfit = yavg(1)*exp(-tau*(tleft-tleft(1)));
    right = find(yfit < 0.2*yfit(1),1);
    if ~isempty(right)
        tlr = tleft(1:right);
        ylr = yleft(1:right);
    else
        tlr = tleft;
        ylr = yleft;
    end
    pause
    myfft(ylr,tlr,1000,1,1)
end
