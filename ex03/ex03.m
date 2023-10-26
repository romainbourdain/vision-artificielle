pts_image = load("pts2dimage.txt");
pts_scene = load("pts2dscene.txt");
n = size(pts_image, 1)/2;

% estimation
pts_scene_estimation = pts_scene(1:n, :);
pts_image_estimation = pts_image(1:n, :);

H = get_homography(pts_scene_estimation, pts_image_estimation, n);

disp(H);

% verification
pts_scene_verification = pts_scene(n+1:end, :);
pts_image_verification = pts_image(n+1:end, :);

mat_scene_verification = [pts_scene_verification ones(n, 1)];
pts_image_estime = (H*mat_scene_verification')';
pts_image_estime = pts_image_estime./pts_image_estime(:, 3);
pts_image_estime = pts_image_estime(:, 1:2);

erreur = norm(pts_image_estime - pts_image_verification);

disp(['Erreur euclidienne : ', num2str(erreur)]);

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