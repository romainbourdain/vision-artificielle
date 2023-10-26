function [F] = get_fundamental_from_svd(p1, p2)
  n = size(p1, 1);
  
  B = zeros(n, 9);
  
  for i=1:n
      B(i, :) = [
          p1(i, 1)*p2(i, 1)
          p1(i, 2)*p2(i, 1)
          p2(i, 1)
          p1(i, 1)*p2(i, 2)
          p1(i, 2)*p2(i, 2)
          p2(i, 2)
          p1(i, 1)
          p1(i, 2)
          1
          ];
  end
  
  [~, ~, V] = svd(B);
  V = V(:, end);
  
  F = reshape(V, 3, 3)';
  F = F / F(3, 3);
end