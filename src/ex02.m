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
m_3 = M(3, 1:3)';

u_0 = m_1' * m_3;
v_0 = m_2' * m_3;
alpha_v = sqrt(m_2' * m_2 - v_0^2);
gamma = (m_1' * m_2 - u_0*v_0)/alpha_v;
alpha_u = sqrt(m_1' * m_1 - gamma^2 - u_0^2);



rmpath("data/ex02/");