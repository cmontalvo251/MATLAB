function price = findprice()
price = 0;
%url = 'http://www.zbiddy.com/auctions/644214-100-Target-Card';
url = 'http://www.zbiddy.com/auctions/647133-The-New-Apple-iPad';
urlwrite(url,'url.txt');
fid = fopen('url.txt');
s = textscan(fid,'%s');
all = s{1};

for ii = 1:length(all)
   row = all{ii};
   l = length('main_auction_price');
   if length(row) >= l
      for jj = 1:length(row)-l
         section = row(jj:jj+l-1);
         if strcmp(section,'main_auction_price')
            if find(row == '$')
               idx = ii;
            end
         end
      end
   end
end
rowdx = all{idx};
s = find(rowdx == '$')+1;
e = find(rowdx == '<')-1;
price = str2num(rowdx(s:e));

