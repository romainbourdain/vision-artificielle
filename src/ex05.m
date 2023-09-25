addpath("data/ex05/");

pts_2D_1 = load("2dpts_1.txt");
pts_2D_2 = load("2dpts_2.txt");
pts_3D = load("3dpts.txt");


% Question 1
M_1 = get_proj_mat(pts_3D, pts_2D_1);
M_2 = get_proj_mat(pts_3D, pts_2D_2);

disp(M_1);
disp(M_2);

% Question 2

rmpath("data/ex05/");