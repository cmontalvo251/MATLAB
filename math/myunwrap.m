function out = myunwrap(in)

out = in;
phase_jump = 0;
for ii = 1:length(in)-1
    diff_ = in(ii+1)-in(ii);
    if abs(diff_) >= 3
        phase_jump = -sign(diff_)*pi;
    end
    out(ii+1) = out(ii+1) + phase_jump;
end
% Copyright - Carlos Montalvo 2015
% You may freely distribute this file but please keep my name in here
% as the original owner
