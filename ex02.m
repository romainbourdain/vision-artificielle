addpath("lib/")

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