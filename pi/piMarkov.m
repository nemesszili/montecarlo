clc;
clear;
close all;
hold on;
rotate3d on;
pkg load statistics;

N = 100000;
inside = 0;

% Starting coordinates
x = 0;
y = 0;

% Max distance
d = 0.05;

% "Rock" history
H = [];

for i = 1:N
  move_x = d * cos(2*pi);
  move_y = d * sin(2*pi);
  
  if ((abs(x + move_x) < 1) && (abs(y + move_y) < 1))
    % Update coordinates, since we're still inside the square
    x = x + move_x;
    y = y + move_y;
    
    % Check if we're inside the circle
    if ((x^2 + y^2) < 1)
      ++inside;
    endif
    
  else  
    % GOOD REJECTION - we put down an additional rock
    if ((x^2 + y^2) < 1)
      ++inside;
    endif
    
    % BAD REJECTION - we skip putting down a rock
    % Comment above to see the effect!
  endif
  
  H = [x, y; H];
   
end

printf("Estimation of Pi: %f.4\n", 4*inside/N);

hist3(H);
grid on;
view(3);