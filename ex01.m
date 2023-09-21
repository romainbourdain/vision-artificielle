u_0 = 256;
v_0 = 256;
alpha_u = 800;
alpha_v = 800;
gamma = 0;
R = load('R1.txt');
t = load('t1.txt');

A = get_intrinsic_matrix(alpha_u, alpha_v, gamma, u_0, v_0);
proj_mat = get_proj_mat(A, R, t);