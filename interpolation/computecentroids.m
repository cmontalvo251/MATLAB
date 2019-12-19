function centroidsxy = computecentroids(x,y,z)

[r,numpatches] = size(x);

centroids = zeros(3,numpatches);

for idx = 1:numpatches
    xc = sum(x(:,idx))/3;
    yc = sum(y(:,idx))/3;
    zc = sum(z(:,idx))/3;
    centroids(:,idx) = [xc;yc;zc];
end
centroidsxy = centroids(1:2,:);

% Copyright - Carlos Montalvo 2015
% You may freely distribute this file but please keep my name in here
% as the original owner
