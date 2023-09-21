addpath("data/ex00/");

proj_mat = load('proj_mat1.txt');
pts = load('3dpts.txt');

[u, v] = project(proj_mat, pts);

plot(u, v, 'r*');

rmpath("data/ex00/");