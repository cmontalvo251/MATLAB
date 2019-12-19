%%Find the optimal path down a triangle
tic

triangle = [
75 0  0   0  0 0  0  0  0  0  0  0  0  0  0;
95 64 0  0  0  0  0  0  0  0  0  0  0  0  0;
17 47 82  0 0  0  0  0  0  0  0  0  0  0  0;
18 35 87 10 0  0  0  0  0  0  0  0  0  0  0;
20 04 82 47 65 0  0  0  0  0  0  0  0  0  0;
19 01 23 75 03 34 0  0  0  0  0  0  0  0  0;
88 02 77 73 07 63 67 0  0  0  0  0  0  0  0;
99 65 04 28 06 16 70 92 0  0  0  0  0  0  0;
41 41 26 56 83 40 80 70 33 0   0 0  0  0  0;
41 48 72 33 47 32 37 16 94 29  0 0  0  0  0;
53 71 44 65 25 43 91 52 97 51 14 0  0  0  0;
70 11 33 28 77 73 17 78 39 68 17 57 0  0  0;
91 71 52 38 17 14 91 43 58 50 27 29 48 0  0;
63 66 04 68 89 53 67 30 73 16 69 87 40 31 0;
04 62 98 27 23 09 70 98 73 93 38 53 60 04 23];

[r,c] = size(triangle);

for ii = r:-1:2
  c = c-1;
  if c~=0
    for jj = 1:c
      if triangle(ii,jj) > triangle(ii,jj+1)
	triangle(ii-1,jj) = triangle(ii,jj) + triangle(ii-1,jj);
      else
	triangle(ii-1,jj) = triangle(ii,jj+1) + triangle(ii-1,jj);
      end
    end
    triangle = triangle(1:end-1,:)
    pause
  end
end

answer = sum(triangle)

toc