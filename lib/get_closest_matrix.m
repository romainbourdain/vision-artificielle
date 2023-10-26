function [F_closest] = get_closest_matrix(F)
  [U, D, V] = svd(F);
  D(3, 3) = 0;
  F_closest = U*D*V';
end