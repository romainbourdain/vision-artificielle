format long;
data = load("data.mat");

Fs = data.Fs;
A = data.A;
wij = ones(size(Fs, 3), size(Fs, 4));

C = mendonca_cipolla(A, Fs, wij);

disp(C);

function C = mendonca_cipolla(Ai, Fs, wij)
  sigma = zeros(2, size(Fs, 3), size(Fs, 4));
  for i = 1:size(Fs, 3)
    for j = 1:size(Fs, 4)
      Eij = Ai' * squeeze(Fs(:, :, i, j)) * Ai;
      singular_values = svd(Eij);
      sigma(:, i, j) = sort(singular_values(1:end-1), "descend");
    end
  end
  sigma = sort(sigma, 1, "descend");
  sum_wij = sum(wij(:));
  C = sum(wij(:) .* (sigma(1, :, :) - sigma(2, :, :)) ./ (sigma(1, :, :) + sigma(2, :, :))) / sum_wij;
end