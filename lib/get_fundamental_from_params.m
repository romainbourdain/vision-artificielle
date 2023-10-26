function [F] = get_fundamental_from_params(t1, t2, R1, R2, A1, A2)
  T1 = [R1 -R1*t1; 0 0 0 1];
  T2 = [R2 -R2*t2; 0 0 0 1];
  T12 = T2 / T1;
  R = T12(1:3, 1:3);
  t = -inv(R)*T12(1:3, 4);
  
  e21 = -A2 * R * t;
  
  e21_X = [
      0 -e21(3) e21(2);
      e21(3) 0 -e21(1);
      -e21(2) e21(1) 0
  ];
  
  F = e21_X * A2 * R / A1;
  
  F = F / F(3, 3);
end