function [p_noise] = add_noise(p, sigma)
  u = p(:, 1);
  v = p(:, 2);

  u = u + sigma * randn(size(u));
  v = v + sigma * randn(size(v)); 

  p_noise = [u v];
end