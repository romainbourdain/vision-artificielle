addpath("data/ex02/");

pts_2D = load("2dpts_1.txt");
pts_3D = load("3dpts.txt");

M = get_proj_mat(pts_3D, pts_2D);

[alpha_u, alpha_v, gamma, u_0, v_0] = get_intrinsic_parameters(M);

disp(M);
disp([ ...
    "alpha_u" alpha_u; ...
    "alpha_v" alpha_v; ...
    "gamma" gamma; ...
    "u_0" u_0; ...
    "v_0" v_0]);

rmpath("data/ex02/");