addpath("data/ex02/");
output_path = "output/ex02/";

pts_2D = load("2dpts_1.txt");
pts_3D = load("3dpts.txt");

M = get_proj_mat(pts_3D, pts_2D);

[alpha_u, alpha_v, gamma, u_0, v_0] = get_intrinsic_parameters(M);

save(output_path+"M.txt", "M", "-ascii");
save(output_path+"alpha_u.txt", "alpha_u", "-ascii");
save(output_path+"alpha_v.txt", "alpha_v", "-ascii");
save(output_path+"gamma.txt", "gamma", "-ascii");
save(output_path+"u_0.txt", "u_0", "-ascii");
save(output_path+"v_0.txt", "v_0", "-ascii");

rmpath("data/ex02/");