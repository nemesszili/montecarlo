function ret = randomWalkerLost(N, R_max)

ret = 0;
if ((N/2 + 3.0 * R_max) > N)
    disp('Cannot create any more random walkers');
    ret = 1;
end

end

