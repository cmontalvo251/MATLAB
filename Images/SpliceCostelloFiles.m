%%This will take a costello pdf and make it environmentally
%friendly
function SpliceCostelloFiles()

close all

system('~/Dropbox/BlackBox/converters/convertPDF2JPG');

files = dir;

%Import name of file
fid = fopen('filenames.log');
name = fscanf(fid,'%s');
system('rm filenames.log');

%Search for filenames
notfound = 1;
counter = -1;
while notfound
  notfound = 0;
  counter = counter + 1;
  curname = [name,'-',num2str(counter),'.jpg'];
  for ii = 1:length(files)
    if strcmp(curname,files(ii).name)
      %File found
      disp(['Page',num2str(counter+1),' imported'])
      ii = length(files)-1;
      notfound = 1;
      eval(['image',num2str(counter),'=imread(curname);']);
      eval(['system(''rm ',curname,''');']);
    end
  end
end
numpages = counter;
numecopages = ceil(numpages/2);
pagessaved = numpages-numecopages;
%%Check for odd number of pages
if mod(numpages,2)
  %%odd!
  eval(['page',num2str(numecopages),' = image',num2str(numpages-1),';'])
  numpages = numpages-1;
end



%%Consolidate Pages
counter = -1;
pagenumber = 0;
for ii = 1:2:numpages-1
  counter = counter + 2;
  pagenumber = pagenumber + 1;
  %%save left and right sides
  eval(['leftside = image',num2str(ii-1),';']);
  eval(['rightside = image',num2str(ii),';']);

  [rl,cl] = size(leftside);
  [rr,cr] = size(rightside);
  
  if (rr > rl)
    %%rightside has more pixels
    rightside = rightside(1:rl,:);
    r = rl;
  else
    %%leftside has more pixels
    leftside = leftside(1:rr,:);
    r = rr;
  end
  
  if (cr > cl)
    %%rightside has more pixels
    rightside = rightside(:,1:cl);
    c = cl;
  else
    %%leftside has more pixels
    leftside = leftside(:,1:cr);
    c = cr;
  end
  
  delta = 100;
  top = round(0.18*c);
  
  %%Splice Top
  topside = leftside(1:top,:);
  
  %Splice Leftside
  [r,c] = size(leftside);
  leftside(:,round(c/2)+delta:end) = [];
  leftside(1:top,:) = [];
  
  %Splice Rightside
  [r,c] = size(rightside);
  rightside(:,round(c/2)+delta:end) = [];
  rightside(1:top,:) = [];
  
  %%Recombine left and right
  totalbottom = [leftside rightside];
  
  %Pad Top with zeros
  [rtop,ctop] = size(topside);
  [r,c] = size(totalbottom);
  
  if c > ctop
    %pad with zeros
    topside = [topside 255.*ones(rtop,c-ctop)];
  else c < ctop
    %delete some
    topside(:,c+1:end) = [];
  end
  
  total = [topside;totalbottom];
  
  %Save file
  eval(['page',num2str(pagenumber),'=total;'])

  disp(['Page',num2str(counter),' and Page',num2str(counter+1),' combined'])
end

%%Output pages to jpgs
for ii = 1:numecopages
  filename = ['page',num2str(ii),'.jpg'];
  eval(['file = ',filename(1:end-4),';'])
  imwrite(file,filename,'jpg');
  disp(['Outputting ',filename(1:end-4)])
end

%%Combine all jpgs into a single PDF
disp('Combing Files to Final PDF');

system('convert *.jpg Eco.pdf');

%Remove all jpegs
disp('Cleaning Up')
system('rm *.jpg');

disp('Done')
disp(['Thank You for Saving ',num2str(pagessaved),' pages.'])


clear


	





% Copyright - Carlos Montalvo 2015
% You may freely distribute this file but please keep my name in here
% as the original owner
