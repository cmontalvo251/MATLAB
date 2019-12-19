%%%Find the last ten digits of 1^1 + 2^2 + ... + 1000^1000


%%%%BRUTE FORCE METHOD%%%%%%%%%%%%%%%%%%

% global slength
% slength = 11;
% final = 10;
% 
% tic
% answer = num2str(zeros(1,slength));
% answer = answer(answer ~= ' ');
% num = answer;
% one = num;
% one(end) = '1';
% num = addition(num,one);
% exponent = num;
% for ii = 1:final
%     ii
%     if ~strcmp(num(end),'0')
%         for jj = 1:ii-1
%             num = multiplication(num,exponent);
%         end
%         answer = addition(answer,num);
%     end
%     num = exponent;
%     num = addition(num,one);
%     exponent = num;
% end
% answer
% toc

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%