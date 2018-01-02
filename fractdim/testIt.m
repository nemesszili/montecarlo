function testIt()
 disp('testing...');
 G1 = fractal(100, 100000, 0.4); 
 G2 = simplifyMatrix(G1); 
 draw(G2);
end

