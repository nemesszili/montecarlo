% Fractal dimension calculation based on radius of gyration
function dim = fractalDim(M, mid_x, mid_y)
  dists = 0;
  N = 0;
  
  for i = 1:rows(M)
    for j = 1:columns(M)
      if (M(i, j) > 0)
        dists += sqrt((i - mid_x)^2 + (j - mid_y)^2);
        N++;
      end
    end
  end
  
  % Radius of gyration: the mean distance of each monomer
  % from the center of the fractal
  Rg = dists / N;
  
  % Rg ~ N ^ (1/D)
  % log(Rg) = log(N ^ (1/D))
  % log(Rg) = 1/D * log(N)
  % D = log(N) / log(Rg)
  
  dim =  log(N) / log(Rg);
end