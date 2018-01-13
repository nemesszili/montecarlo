function [M, start_x, start_y, len] = gsaw(N, attr, temp, draw)
  if draw
    figure;
    hold on;
  end
  
  % Map
  dim = sqrt(N)*10;
  M = zeros(dim);
  len = 0;
  
  dE = 0.347;
  
  % Initialize first monomer
  curr_x = round(dim/2);
  curr_y = round(dim/2);
  
  start_x = curr_x;
  start_y = curr_y;
  
  M(curr_x, curr_y) = 1;
  
  if draw
    plot(curr_x, curr_y, 'o');
  end
  
  % Random walk
  i = 1;
  while i <= N
    % Initialize random variable
    T = zeros(1, 4);
    
    % Check each available direction 
    if M(curr_x - 1, curr_y) == 0
      T(1) = 1;
    end
    
    if M(curr_x, curr_y + 1) == 0
      T(2) = 1;
    end
    
    if M(curr_x + 1, curr_y) == 0
      T(3) = 1;
    end
    
    if M(curr_x, curr_y - 1) == 0
      T(4) = 1;
    end
    
    % Neighbours of potential monomers
    
    Nb = zeros(1, 4);
    
    % top
    if T(1) > 0
      cddir = 0;
      if M(curr_x - 1, curr_y - 1) > 0
        cddir += 1;
      end
      
      if M(curr_x - 2, curr_y) > 0
        cddir += 1;
      end
     
      if M(curr_x - 1, curr_y + 1) > 0
        cddir += 1;
      end
      
      Nb(1) = cddir;
    end
    
    % right
    if T(2) > 0
      cddir = 0;
      if M(curr_x - 1, curr_y + 1) > 0
        cddir += 1;
      end
      
      if M(curr_x, curr_y + 2) > 0
        cddir += 1;
      end
     
      if M(curr_x + 1, curr_y + 1) > 0
        cddir += 1;
      end
      
      Nb(2) = cddir;
    end
    
    % bottom
    if T(3) > 0
      cddir = 0;
      if M(curr_x + 1, curr_y + 1) > 0
        cddir += 1;
      end
      
      if M(curr_x + 2, curr_y) > 0
        cddir += 1;
      end
     
      if M(curr_x + 1, curr_y - 1) > 0
        cddir += 1;
      end
      
      Nb(3) = cddir;
    end
    
    % left
    if T(4) > 0
      cddir = 0;
      if M(curr_x + 1, curr_y - 1) > 0
        cddir += 1;
      end
      
      if M(curr_x, curr_y - 2) > 0
        cddir += 1;
      end
     
      if M(curr_x - 1, curr_y - 1) > 0
        cddir += 1;
      end
      
      Nb(4) = cddir;
    end
    
    if 1 && all(T == 0)
%      disp('No more available steps! Stopping...');
      if draw
        plot(curr_y, curr_x, '*');
      end
      return
    end
    
    T  = T / sum(T);
    origT = T;
    
    % Calculate probabilities for each direction
    for j=1:4
      if T(j) > 0
        T(j) = exp(-(1 + attr * Nb(j) * dE)/temp);
      end
    end
    
    T /= sum(T);
    
    % Perform a Monte Carlo step
    % In order to avoid recalculating probabilities for
    % each direction, we'll retry until a successful step
    D = -1;
    while (D < 0)
      i++;
      if (i > N)
        break;
      end
      
      dir = randsample([1 2 3 4], 1, true, origT);
      
      if (rand() < T(dir))
        D = dir;
        break;
      end
    end
    
    if (D > 0)
      prev_x = curr_x;
      prev_y = curr_y;
      
      if D == 1
        curr_x--;
      elseif D == 2
        curr_y++;  
      elseif D == 3
        curr_x++;
      else
        curr_y--;
      end
      
      M(curr_x, curr_y) = 1;
      len++;
      
      if draw
        plot([prev_y curr_y], [prev_x curr_x], 'k');
      end
    end
  end
  
  if draw
    plot(curr_y, curr_x, '*');
  end
end