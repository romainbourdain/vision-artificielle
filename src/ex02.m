addpath("data/ex02/");

pts_2D = load("2dpts_1.txt");
pts_3D = load("3dpts.txt");

B = get_B_matrix(pts_3D, pts_2D);

[U, D, V] = svd(B);

m = V(:, end);

rmpath("data/ex02/");