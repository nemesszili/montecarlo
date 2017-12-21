function [maxCl, span] = percolation(L, p)
  % Fill matrix with uniform random x in [0, 1] 
  S = rand(L);

  % Matrix set to 0, 1 values
  SS = S < p;

  % Label cluesters - the second parameter sets the
  % number of neightbours to be checked
  % (4 or 8 in 2D)
  [lw, num] = bwlabel(SS, 4);

  % Find the size of the largest cluster
  s = regionprops(lw, 'Area');
  area = cat(1, s.Area);
  maxCl = 0;
  if (rows(area) > 0)
    maxCl = max(area);
  endif
    
  % Does it span?
  span = spanning(lw);
end