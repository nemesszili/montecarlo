function F = fractal(N, iter)
  %init figure
  figure;
  hold on;
  
  % Initializing grid
  F = zeros(N, N);
  F(N/2, N/2) = 1;
  R_max = 5;
  
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
    
    %Error handling: what happens if the walker is outside of the NxN
    %matrix?
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
          return;
      end
    end
    
    % Check if the random walker sticks to the fractal
    if ( ...
       (randwalk_x < N && F(randwalk_x + 1, randwalk_y) == 1) || ...
       (randwalk_x > 1 && F(randwalk_x - 1, randwalk_y) == 1) || ...
       (randwalk_y < N && F(randwalk_x, randwalk_y + 1) == 1) || ...
       (randwalk_y > 1 && F(randwalk_x, randwalk_y - 1) == 1))
 
      F(randwalk_x, randwalk_y) = 1;
      
      %display it
      draw(F);
      dx = randwalk_x - N/2;
      dy = randwalk_y - N/2;
      
      R_max_cand = dx*dx + dy*dy;
      
      if (R_max_cand > R_max*R_max)
          R_max = sqrt(R_max_cand);
      end
          
      % Init a new random walker
      [randwalk_x, randwalk_y, lost] = initRandomWalker(N, R_max);
      if (lost == 1)
          return;
      end    
    end
    
    if (mod(i, 1000) == 0)
      text = sprintf('iter = %d', i);
      disp(text);
    end
  end
end

