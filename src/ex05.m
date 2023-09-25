addpath("data/ex05/");

pts_2D_1 = load("2dpts_1.txt");
pts_2D_2 = load("2dpts_2.txt");
pts_3D = load("3dpts.txt");

B_1 = get_B_matrix(pts_3D, pts_2D_1);
B_2 = get_B_matrix(pts_3D, pts_2D_2);

rmpath("data/ex05/");