function [error] = get_euclidian_error(estimated, real, dim)
  error = sqrt(sum((estimated - real).^2, dim));
  error = mean(error);
end