    pts_mire = load("mireXY.txt");
    
    n_img=10;
    n_pts=100;
    
    B=zeros(2*n_img, 6);
    
    for i=1:n_img
        pts_image = load("pts2D_" + i + ".txt")';
        H = get_homography(pts_mire, pts_image, n_pts);
    
        disp("Homography " + i + " : ");
        disp(H);
    
        B(2*i-1,:) = [
            H(1,1)^2-H(1,2)^2
            2*(H(1,1)*H(2,1)-H(1,2)*H(2,2))
            2*(H(1,1)*H(3,1)-H(1,2)*H(3,2))
            H(2,1)^2-H(2,2)^2
            2*(H(2,1)*H(3,1)-H(2,2)*H(3,2))
            H(3,1)^2-H(3,2)^2
            ];
    
        B(2*i,:) = [
            H(1,1)*H(1,2)
            H(1,2)*H(2,1) + H(1,1)*H(2,2)
            H(1,2)*H(3,1) + H(1,1)*H(3,2)
            H(2,1)*H(2,2)
            H(2,2)*H(3,1) + H(2,1)*H(3,2)
            H(3,1)*H(3,2)
            ];
    end
    
    [~, ~, V] = svd(B);
    
    V = V(:, end);
    
    Omega = [
        V(1) V(2) V(3);
        V(2) V(4) V(5);
        V(3) V(5) V(6);
    ];
    
    disp("Omega : ");
    disp(Omega);


    % Erreur sur cette ligne
    A = inv(chol(Omega, 'lower')');

    [R, t] = get_intrinsic_parameters(A, H);


    disp("R : ");
    disp(R);

    disp("t : ");
    disp(t);
    
    function [H] = get_homography(pts_scene, pts_image, n)
        B = zeros(2*n, 9);
    
        for i=1:n
            x = pts_scene(i, 1);
            y = pts_scene(i, 2);
            u = pts_image(i, 1);
            v = pts_image(i, 2);
        
            B(2*i-1, :) = [x y 1 0 0 0 -u*x -u*y -u];
            B(2*i, :) = [0 0 0 x y 1 -v*x -v*y -v];
        end
        
        [~, ~, V] = svd(B);
        
        H = reshape(V(:, end), 3, 3)';
    end

    function [R, t] = get_intrinsic_parameters(A, H)
        lambda = 1 / norm(A \ H(:, 1));
        r_1 = lambda * (A \ H(:, 1));
        r_2 = lambda * (A \ H(:, 2));
        R = [r_1 r_2 r_1*r_2];
        t_1 = lambda * (A \ H(:, 3));
        t = -R' * t_1;
    end