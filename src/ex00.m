addpath("data/ex00/");

proj_mat = load('proj_mat1.txt');
pts_3d = load('3dpts.txt');

[u, v] = project(proj_mat, pts_3d);

plot(u, v, 'r*');

rmpath("data/ex00/");