function out = NN(weights,Nhidden,inputs)
%%Neural Network
%function out = NN(weights,Nhidden,inputs)
%weights = [h1_weights,h2_weights,...hn_weights,w_out_1,w_out_2,...w_out_N];

%Get the number of inputs
[num_in] = length(inputs);

[num_weights] = length(weights);

%Get the number of outputs
%%num_weights = (num_in+num_out)*Nhidden
num_out = (num_weights-num_in*Nhidden)/Nhidden;

%%Initialize variables
out = zeros(num_out,1);
hidden = zeros(Nhidden,1);

%%Generate Hidden layer
counter = 0;
for ii = 1:Nhidden
  for jj = 1:num_in
    counter = counter + 1;
    hidden(ii) = hidden(ii) + weights(counter)*inputs(jj);
  end
end

%%Generate Output
for ii = 1:num_out
  for jj = 1:Nhidden
    counter = counter + 1;
    %Linear
    %out(ii) = out(ii) + weights(counter)*hidden(jj);
    %Sigmoidal
    out(ii) = out(ii) + weights(counter)*(1/(1+exp(-hidden(jj))));
  end
end

% Copyright - Carlos Montalvo 2015
% You may freely distribute this file but please keep my name in here
% as the original owner
