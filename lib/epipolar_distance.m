function [d] = epipolar_distance(F, p1, p2)
  Fp1 = F * p1;
  d = (p2' * Fp1) / sqrt(Fp1(1)^2 + Fp1(2)^2);
end