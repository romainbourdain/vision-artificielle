pts_2D = load("data/2dpts_1.txt");
pts_3D = load("data/3dpts.txt");

M = get_proj_mat(pts_3D, pts_2D);

[alpha_u, alpha_v, gamma, u_0, v_0] = get_intrinsic_parameters(M);

disp(M);
disp([ ...
    "alpha_u: "+ alpha_u, ...
    "alpha_v: "+ alpha_v, ...
    "gamma: "+ gamma, ...
    "u_0: "+ u_0, ...
    "v_0: "+ v_0
    ]);

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

function [alpha_u, alpha_v, gamma, u_0, v_0] = get_intrinsic_parameters(M)
    m_1 = M(1, 1:3)';
    m_2 = M(2, 1:3)';
    m_3 = M(3, 1:3)';
    
    u_0 = m_1' * m_3;
    v_0 = m_2' * m_3;
    alpha_v = sqrt(m_2' * m_2 - v_0^2);
    gamma = (m_1' * m_2 - u_0*v_0)/alpha_v;
    alpha_u = sqrt(m_1' * m_1 - gamma^2 - u_0^2);
end