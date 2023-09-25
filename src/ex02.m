addpath("data/ex02/");

pts_2D = load("2dpts_1.txt");
pts_3D = load("3dpts.txt");

B = get_B_matrix(pts_3D, pts_2D);

[U, D, V] = svd(B);

m = V(:, end);
M_chapeau = reshape(m, 4, 3)';
M = M_chapeau / norm(M_chapeau(3, 1:3));

m_1 = M(1, 1:3)';
m_2 = M(2, 1:3)';


rmpath("data/ex02/");