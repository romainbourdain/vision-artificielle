addpath("lib/");

% Svd
p1 = load("data/2dpts_1.txt");
p2 = load("data/2dpts_2.txt");

F_SVD = get_fundamental_from_svd(p1, p2);

% Paramètres intrinsèques
A1 = load("data/A1.txt");
A2 = load("data/A2.txt");
R1 = load("data/R1.txt");
R2 = load("data/R2.txt");
t1 = load("data/t1.txt");
t2 = load("data/t2.txt");

F_PARAMS = get_fundamental_from_params(t1, t2, R1, R2, A1, A2);

% Epipoles
p1 = load("data/images/2dpts_1.txt");
p2 = load("data/images/2dpts_2.txt");
img1 = imread("data/images/castle.01.jpg");
img2 = imread("data/images/castle.02.jpg");

[~, ~, V] = svd(F_PARAMS);
e12 = reshape(V(:, end), 1, 3)';

[~, ~, V] = svd(F_PARAMS');
e21 = reshape(V(:, end), 1, 3)';

for i=1:100
    img = insertShape(img1, "line", [p1(i, :) e12(1:2, :)']);
end
%imshow(img);

% Bruit
sigma = 0.5;
p1_noise = add_noise(p1, sigma);
p2_noise = add_noise(p2, sigma);

F_NOISE = get_fundamental_from_svd(p1_noise, p2_noise);
F_NOISE = get_closest_matrix(F_NOISE);

function [p_noise] = add_noise(p, sigma)
    u = p(:, 1);
    v = p(:, 2);

    u = u + sigma * randn(size(u));
    v = v + sigma * randn(size(v)); 

    p_noise = [u v];
end

function [F_closest] = get_closest_matrix(F)
    [U, D, V] = svd(F);
    D(3, 3) = 0;
    F_closest = U*D*V';
end

rmpath("lib/")