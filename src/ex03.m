addpath("data/ex03/");

pts_image = load("pts2dimage.txt");
pts_scene = load("pts2dscene.txt");

% estimation
x = pts_image(1:50, 1);
y = pts_image(1:50, 2);

u = pts_scene(1:50, 1);
v = pts_scene(1:50, 2);

B = zeros(100, 9);

for i=1:50
    B(2*i-1, :) = [x(i) y(i) 1 0 0 0 -u(i)*x(i) -u(i)*y(i) -u(i)];
    B(2*i, :) = [0 0 0 x(i) y(i) 1 -v(i)*x(i) -v(i)*y(i) -v(i)];
end

[~, ~, V] = svd(B);

H = reshape(V(:, end), 3, 3);

% verification
x = pts_image(51:100, 1);
y = pts_image(51:100, 2);

u = pts_scene(51:100, 1);
v = pts_scene(51:100, 2);

rmpath("data/ex03/");