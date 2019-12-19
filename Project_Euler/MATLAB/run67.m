%%Find the optimal path down a triangle
tic

triangle = dlmread('triangle.txt')

pause;

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