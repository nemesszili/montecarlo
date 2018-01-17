function [dim, G] = fractal(N, iter, stickProbability)

  if ~exist('stickProbability','var')
    stickProbability = 1;
  end

  % Initializing grid
  G = zeros(N, N, 0);
  F = zeros(N, N);
  F(N/2, N/2) = 1;
  R_max = 5;
  
  dists = 0;
  
  % Initialize the first random walker
  [randwalk_x, randwalk_y, lost] = initRandomWalker(N, R_max);
  if (lost == 1)
      return;
  end
  
  % Generate the fractal
  for i = 1:iter
    
    % Move the current random walker
    tempx = randwalk_x;
    tempy = randwalk_y;
    
    r = rand();
    
    % Check for direction
    % up
    if (r < 0.25)
      tempx = tempx - 1;
    % right
    elseif (r < 0.5)
      tempy = tempy + 1;
    % down
    elseif (r < 0.75)
      tempx = tempx + 1;
    % left
    else
      tempy = tempy - 1;
    end
    
    if (tempx == 0) tempx = tempx + 1; end
    if (tempx > N) tempx = tempx - 1; end
    if (tempy == 0) tempy = tempy + 1; end
    if (tempy > N) tempy = tempy - 1; end
    
    
    if (F(tempx, tempy) == 0)
      randwalk_x = tempx;
      randwalk_y = tempy;
    end
    
    % Check if the random walker is out of range
    dx = randwalk_x - N/2;
    dy = randwalk_y - N/2;
    
    if (dx*dx + dy*dy > 9*R_max*R_max) 
      % Init a new random walker
      [randwalk_x, randwalk_y, lost] = initRandomWalker(N, R_max);
      if (lost == 1)
          dim = log(N) / log(dists / N);
          return;
      end
    end
    
    % Check if the random walker sticks to the fractal
    if ( ...
       (randwalk_x < N && F(randwalk_x + 1, randwalk_y) == 1) || ...
       (randwalk_x > 1 && F(randwalk_x - 1, randwalk_y) == 1) || ...
       (randwalk_y < N && F(randwalk_x, randwalk_y + 1) == 1) || ...
       (randwalk_y > 1 && F(randwalk_x, randwalk_y - 1) == 1))
      
      if (rand() < stickProbability)
        F(randwalk_x, randwalk_y) = 1;
        dists += sqrt((randwalk_x - N/2)^2 + (randwalk_y - N/2)^2);
      else
        continue;
      end
      
      %save it
      G(:, :, end+1) = F;
      dx = randwalk_x - N/2;
      dy = randwalk_y - N/2;
      
      R_max_cand = dx*dx + dy*dy;
      
      if (R_max_cand > R_max*R_max)
          R_max = sqrt(R_max_cand);
      end
          
      % Init a new random walker
      [randwalk_x, randwalk_y, lost] = initRandomWalker(N, R_max);
      if (lost == 1)
          dim = log(N) / log(dists / N);
          return;
      end    
    end
    
    if (mod(i, 1000) == 0)
      fprintf('iter = %d\n', i);
      fflush(stdout);
    end
  end
  
  % Fractal dimension calculation with radius of gyration (Rg)
  dim = log(N) / log(dists / N);
end

