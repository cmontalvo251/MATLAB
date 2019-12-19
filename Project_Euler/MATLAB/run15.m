%%Problem 15
%%How many routes in an nxn grid

clear
clc

tic

for i = 1:20
   disp('N')
   n = i
   disp('Number of grids')
   numgrid = n^2
   disp('Number of Nodes')
   nodes = (n+1)^2
   disp('Length of One Path')
   pathlength = 2*n + 1
   disp('Number of Routes')
   BRANCH = 0;
   if BRANCH
   %%Create Branching Algorithm
   %%Start at 1,1
   finish = 0;
   locs = [1 1];
   while ~finish
      [r,c] = size(locs);
      locs;
      %%Can only move right or down
      %%Calculate Possible Moves
      %%Can I move to the right?
      for ll = 1:r
         if locs(ll,2) == n+1
            right = 0;
         else
            right = 1;
         end
         %%Can I move down?
         if locs(ll,1) == n+1
            down = 0;
         else
            down = 1;
         end
         move = 0;
         if right && down
            %%Split into two paths
            locs = [locs;locs(ll,:)];
            locs(ll,1) = locs(ll,1) + 1;
            locs(end,2) = locs(end,2) + 1;
            move = 1;
         end
         if right && ~move
            %%Move right
            locs(ll,2) = locs(ll,2) + 1;
         end
         if down && ~move
            %%move down
            locs(ll,1) = locs(ll,1) + 1;
         end
         if ~right && ~down
            %%I've reached the end
            finish = 1;
         end
      end
   end
   [r,c] = size(locs);
   routes = r
   end
   %%Calculate Paths using pascal's triangle
   paths = factorial(2*n)/(factorial(n)^2)
end

toc