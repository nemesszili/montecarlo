function [randwalk_x, randwalk_y, lost] = initRandomWalker(N, R_max)

randwalk_x = -1; % walker lost
randwalk_y = -1; % walker lost
lost = 0;
if (randomWalkerLost(N, R_max) == 1)
  lost = 1;
  return;
end

randwalk_R = R_max + 5.0;
theta = 2*pi*rand();

randwalk_x = N/2 + floor(randwalk_R * cos(theta));
randwalk_y = N/2 + floor(randwalk_R * sin(theta));

end

