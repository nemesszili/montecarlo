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
d = 0.5;

% "Rock" history
H = [];

for i = 1:N
  move_x = unifrnd(-d, d);
  move_y = unifrnd(-d, d);
  
  if ((abs(x + move_x) < 1) && (abs(y + move_y) < 1))
    % Update coordinates, since we're still inside the square
    x = x + move_x;
    y = y + move_y;
    
    % Check if we're inside the circle
    if ((x^2 + y^2) < 1)
      ++inside;
    endif
    
  else  
    % REJECTION
    if ((x^2 + y^2) < 1)
      ++inside;
    endif
  endif
  
  H = [x, y; H];
   
end

printf("Estimation of Pi: %f.4\n", 4*inside/N);

hist3(H);
grid on;
view(3);