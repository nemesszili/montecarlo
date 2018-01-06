function M = gsaw(N, attr)
  figure;
  hold on;
  % Map
  dim = N^2;
  M = zeros(dim);
  
  % Initialize first monomer
  curr_x = round(dim/2);
  curr_y = round(dim/2);
  
  M(curr_x, curr_y) = 1;
  plot(curr_x, curr_y, 'o');
  
  % Random walk
  for i = 1:N-1
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
    
    % Random variable of neighbours of potential monomers
    
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
      
      if cddir == 3
        T(1) = 0;
      else      
        Nb(1) = cddir;
      end
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
      
      if cddir == 3
        T(2) = 0;
      else      
        Nb(2) = cddir;
      end
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
      
      if cddir == 3
        T(3) = 0;
      else      
        Nb(3) = cddir;
      end
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
      
      if cddir == 3
        T(4) = 0;
      else      
        Nb(4) = cddir;
      end
    end
    
    T
    
    if 1 && all(T == 0)
      disp('No more available steps! Stopping...');
      plot(curr_y, curr_x, '*');
      return
    end
    
    T  = T / sum(T);
    
    ddir = sum(Nb);
    
    % Calculate final random variable with attraction
    if (ddir > 0) && (attr < 0)
      mini = 3;
      for i = 1:4
        if T(i) > 0 && Nb(i) < mini
          mini = Nb(i);
        end
      end
      
      count = 0;
      for i = 1:4
        if T(i) > 0 && Nb(i) == mini
          count++;
        end
      end
      
      for i = 1:4
        if T(i) > 0 && Nb(i) == mini
          Nb(i) = 1/count;
        else
          Nb(i) = 0;
        end
      end
    end
    
    Nb /= ddir;
    
    if (ddir > 0) && (attr != 0)
      T = T * (1 - abs(attr)) + Nb * abs(attr);
    end
    
    % Select next monomer
    D = randsample([1 2 3 4], 1, true, T);
    
    prev_x = curr_x;
    prev_y = curr_y;
    
    if D == 1
      curr_x--;
      disp("bottom");
    elseif D == 2
      curr_y++;  
      disp("right");
    elseif D == 3
      curr_x++;
      disp("top");
    else
      curr_y--;
      disp("left");
    end
    
    M(curr_x, curr_y) = 1;
    
    plot([prev_y curr_y], [prev_x curr_x], 'k');
  end
  
  plot(curr_y, curr_x, '*');
end
