
clear
close all

% figure()
% axis([0 10 0 10])

% A = [[ones(1,2),zeros(1,8)];[ones(1,8),ones(1,2)];[ones(1,8),ones(1,2)]];

% for ii = 1:10
%   for jj = 1:10
%     if A(ii,jj) == 1
%       rectangle('Position',[jj,ii,1,1])
%     end
%   end
% end

figure()
axis equal
axis([0 12 0 12])
grid on
finish = 0;
letter = zeros(12,12);
while ~finish
  [x,y] = ginput(1);
  coordx = floor(x);
  coordy = floor(y);
  if coordx == 11 && coordy == 0
    finish = 1;
  else
    rectangle('Position',[coordx,coordy,1,1],'Facecolor','k','EdgeColor','none')
    try 
      if letter(coordy+1,coordx+1) == 1
	rectangle('Position',[coordx,coordy,1,1],'Facecolor',[1 1 1],'EdgeColor','none')
	letter(coordy+1,coordx+1) = 0;
      else
	letter(coordy+1,coordx+1) = 1;
      end
    catch
      disp('Null')
    end
  end
end
%%Flip letter
letter = letter(end:-1:1,:);
%%Now pad letter with zeros
letter = [letter,zeros(12,6)];
%%Now save left side into one variable
letterleft = letter(:,1:8)
letterright = letter(:,9:16)
%%Now convert every row to a hex number
hex = '';
for ii = 1:12
  binary = letterleft(ii,:);
  binstring = num2str(binary);
  binstring(binstring==' ')=[];
  hexleft = bin2hex(binstring);
  binary = letterright(ii,:);
  binstring = num2str(binary);
  binstring(binstring==' ')=[];
  hexright = bin2hex(binstring);
  hexrow = ['0x',hexleft,',','0x',hexright,','];
  hex = [hexrow,hex];
end
hex


