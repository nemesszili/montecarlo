function G = simplifyMatrix(F)

s = size(F);
N = s(1);
e = s(3);

%top -> down
i = 1;
top = 1;
while (sum(F(i,:,e)) == 0)
  i = i + 1;
  top = top + 1;
end

%bottom -> top
i = N;
bottom = N;
while (sum(F(i,:,e)) == 0)
  i = i - 1;
  bottom = bottom - 1;
end

%left -> right
i = 1;
left = 1;
while (sum(F(i,:,e)) == 0)
  i = i + 1;
  left = left + 1;
end

%right -> left
i = N;
right = N;
while (sum(F(i,:,e)) == 0)
  i = i - 1;
  right = right - 1;
end


G = zeros(bottom-top+1, right-left+1, e);
for i = 1:e
  G(:,:,i) = F(top:bottom, left:right, i);
end

end

