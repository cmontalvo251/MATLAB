function out = get_phi(time,wc)

[r,c] = size(time);

init = rand(r,c)-0.5;
init(1) = 0;

[tfilter,out] = LowPass(init,time,wc);

