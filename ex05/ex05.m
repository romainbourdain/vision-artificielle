pts_2D_1 = load("2dpts_1.txt");
pts_2D_2 = load("2dpts_2.txt");
pts_3D = load("3dpts.txt");


% Question 1
M_1 = get_proj_mat(pts_3D, pts_2D_1);
M_2 = get_proj_mat(pts_3D, pts_2D_2);

disp("M_1 :");
disp(M_1);
disp("M_2 : ");
disp(M_2);

% Question 2
scene_1 = load("2dpts-scene_1.txt");
scene_2 = load("2dpts-scene_2.txt");

scene = construct_3d_scene(M_1, scene_1, M_2, scene_2);

figure;
scatter3(scene(:, 1),scene(:, 2), scene(:, 3), 'r');

function [M] = get_proj_mat(pts_3D, pts_2D)
    B = get_B_matrix(pts_3D, pts_2D);
    
    [~, ~, V] = svd(B);

    m = V(:, end);
    M_chapeau = reshape(m, 4, 3)';
    M = M_chapeau / norm(M_chapeau(3, 1:3));
end

function [B] = get_B_matrix(pts_3D, pts_2D)
    Xi = pts_3D(:, 1);
    Yi = pts_3D(:, 2);
    Zi = pts_3D(:, 3);
    
    ui = pts_2D(:, 1);
    vi = pts_2D(:, 2);
    
    n = length(Xi);
    B = zeros(2*n, 12);
    
    for i = 1:n
        X = Xi(i);
        Y = Yi(i);
        Z = Zi(i);
        u = ui(i);
        v = vi(i);
    
        B(2*i-1, :) = [X, Y, Z, 1, 0, 0, 0, 0, -X*u, -Y*u, -Z*u, -u];
        B(2*i, :) = [0, 0, 0, 0, X, Y, Z, 1, -X*v, -Y*v, -Z*v, -v];
    end
end

function [scene] = construct_3d_scene(M_1, scene_1, M_2, scene_2)
    n_pts = size(scene_1, 1);
    scene = zeros(n_pts, 3);

    for i = 1:n_pts
        u_1 = scene_1(i, 1);
        v_1 = scene_1(i, 2);
        u_2 = scene_2(i, 1);
        v_2 = scene_2(i, 2);
    
        A = [
            M_1(1,1)-M_1(3,1)*u_1 M_1(1,2)-M_1(3,2)*u_1 M_1(1,3)-M_1(3,3)*u_1; 
            M_1(2,1)-M_1(3,1)*v_1 M_1(2,2)-M_1(3,2)*v_1 M_1(2,3)-M_1(3,3)*v_1;
            M_2(1,1)-M_2(3,1)*u_2 M_2(1,2)-M_2(3,2)*u_2 M_2(1,3)-M_2(3,3)*u_2; 
            M_2(2,1)-M_2(3,1)*v_2 M_2(2,2)-M_2(3,2)*v_2 M_2(2,3)-M_2(3,3)*v_2;
        ];
        b = [
            M_1(3,4)*u_1-M_1(1,4); 
            M_1(3,4)*v_1-M_1(2,4);
            M_2(3,4)*u_2-M_2(1,4);
            M_2(3,4)*v_2-M_2(2,4);
            ];
    
        scene(i,:)=(A\b)';
    end
end