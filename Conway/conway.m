%%%%
%Conway's Game of Life

purge

%%%Random Seed
size_of_game = 100;
mylife = round(rand(size_of_game,size_of_game));
%mylife = [0 0 0 0 0;0 0 0 0 0;0 1 1 1 0;0 0 0 0 0;0 0 0 0 0];

%%%Plot
plottool(1,'Life',12);
while 1%for ll = 1:100
  axis([-size_of_game size_of_game -size_of_game size_of_game])
  cla;
  spy(mylife)
  grid on
  %Propagate
  newlife = mylife;
  for ii = 1:size_of_game
    si = ii-1;
    ei = ii+1;
    veci = si:ei;
    veci(veci==0)=size_of_game;
    veci(veci==size_of_game+1)=1;
    for jj = 1:size_of_game
      %%%This is overlap from each side
      sj = jj-1;
      ej = jj+1;
      vecj = sj:ej;
      vecj(vecj==0)=size_of_game;
      vecj(vecj==size_of_game+1)=1;
      num_neighbors = sum(sum(mylife(veci,vecj)))-mylife(ii,jj);
      if mylife(ii,jj)
          %Any live cell with fewer than two live neighbours dies, as if caused by under-population.
          if num_neighbors < 2
              newlife(ii,jj) = 0;
          end
          %Any live cell with two or three live neighbours lives on to the next generation.

          %Any live cell with more than three live neighbours dies, as if by overcrowding.
          if num_neighbors > 3
              newlife(ii,jj) = 0;
          end
      else
          %Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.
          if num_neighbors == 3
              newlife(ii,jj) = 1;
          end
      end
    end
  end
  drawnow
  pause(0.01)
  mylife = newlife;
end



