function testIt()
 disp('testing...');
 [dim, G1] = fractal(100, 100000, 0.5); 
 fprintf('Fractal dimension: %f\n', dim);
 fflush(stdout);
 G2 = simplifyMatrix(G1); 
 draw(G2);
end

