%%Test

tic

spiral = 1001;

answer = 1;
num = 1;
for ii = 1:2:spiral-2
  inc = ii + 1;
  for jj = 1:4
    num = num + inc;
    answer = answer + num;
  end
end

answer

toc