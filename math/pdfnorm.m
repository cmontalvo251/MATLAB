function y = pdfnorm(myu,stdev,x)
%%mean and standard deviation yields the normal gaussian
%distribution

y = (1/(sqrt(2*pi)*stdev)).*exp(-((x-myu).^2)./(2*stdev^2));

% Copyright - Carlos Montalvo 2015
% You may freely distribute this file but please keep my name in here
% as the original owner
