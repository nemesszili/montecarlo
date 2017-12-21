function F = fractal(N, iter)
  % Initializing grid
  F = zeros(N, N);
  F(N/2, N/2) = 1;
  R_max = 5;
  
  % Initialize the first random walker
  if ((N/2 + 3.0 * R_max) > N)
    printf("Cannot create any more random walkers\n");
    fflush(stdout);
    return
  end
  
  randwalk_R = R_max + 5.0;
  theta = 2*pi*rand();
  
  randwalk_x = N/2 + floor(randwalk_R * cos(theta));
  randwalk_y = N/2 + floor(randwalk_R * sin(theta));
  
  % Generate the fractal
  for i = 1:iter
    
    % Move the current random walker
    tempx = randwalk_x;
    tempy = randwalk_y;
    
    r = rand();
    
    % Check for direction
    % up
    if (r < 0.25)
      tempx--;
    % right
    elseif (r < 0.5)
      tempy++;
    % down
    elseif (r < 0.75)
      tempx++;
    % left
    else
      tempy--;
    end
    
    if (F(tempx, tempy) == 0)
      randwalk_x = tempx;
      randwalk_y = tempy;
    end
    
    % Check if the random walker is out of range
    dx = randwalk_x - N/2;
    dy = randwalk_y - N/2;
    
    if (dx*dx + dy*dy > 9*R_max*R_max) 
%      F(randwalk_x, randwalk_y) = 0;
      
      % Init a new random walker
      if ((N/2 + 3.0 * R_max) > N)
        printf("Cannot create any more random walkers\n");
        fflush(stdout);
        return
      end
      
      randwalk_R = R_max + 5.0;
      theta = 2*pi*rand();
      
      randwalk_x = N/2 + floor(randwalk_R * cos(theta));
      randwalk_y = N/2 + floor(randwalk_R * sin(theta));
    end
    
    % Check if the random walker sticks to the fractal
    if (F(randwalk_x + 1, randwalk_y) == 1 || ...
       F(randwalk_x - 1, randwalk_y) == 1 || ...
       F(randwalk_x, randwalk_y + 1) == 1 || ...
       F(randwalk_x, randwalk_y - 1) == 1)
    
      F(randwalk_x, randwalk_y) = 1;
      dx = randwalk_x - N/2;
      dy = randwalk_y - N/2;
      
      R_max_cand = dx*dx + dy*dy;
      
      if (R_max_cand > R_max*R_max)
          R_max = sqrt(R_max_cand);
      end
          
      % Init a new random walker
      if ((N/2 + 3.0 * R_max) > N)
        printf("Cannot create any more random walkers\n");
        fflush(stdout);
        return
      end
      
      randwalk_R = R_max + 5.0;
      theta = 2*pi*rand();
      
      randwalk_x = N/2 + floor(randwalk_R * cos(theta));
      randwalk_y = N/2 + floor(randwalk_R * sin(theta));      
    end
    
    if (mod(i, 1000) == 0)
      printf("iter = %d\n", i);
      fflush(stdout);
    end
  end
end