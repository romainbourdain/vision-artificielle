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