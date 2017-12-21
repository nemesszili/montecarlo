function span = spanning(S)
  top = unique(S(1, :));
  bottom = unique(S(end, :));
  
  % If there are elements on the bottom and top rows
  % that make part of the same cluster, then the
  % system percolates
  inter = intersect(top, bottom);
  if ismember(0, inter)
    span = (length(inter) > 1);
  else
    span = (length(inter) > 0);
end