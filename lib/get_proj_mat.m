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