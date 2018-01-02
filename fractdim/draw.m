function draw(G, from)
  if ~exist('from','var')
    from = 1;
  end

  figure;
  hold on;

  len = size(G);
  len = len(3);
  
  if (from > len)
    spy(sparse(G(:,:,end)));
    return;
  end
  
  for i = from:len
    clf;
    spy(sparse(G(:,:,i)));
    pause(0.03);
  end
end

