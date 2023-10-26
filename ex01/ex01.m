u_0 = 256;
v_0 = 256;
alpha_u = 800;
alpha_v = 800;
gamma = 0;
R = load('R1.txt');
t = load('t1.txt');

% R est une rotation car R*R'=I et det(R)=1

A = [alpha_u gamma u_0; 0 alpha_v v_0; 0 0 1]; % get intrinsic matrix
proj_mat = A * [R -R*t]; % get proj mat

disp(proj_mat);