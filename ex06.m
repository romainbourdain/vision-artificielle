% Svd
p1 = load("2dpts_1.txt");
p2 = load("2dpts_2.txt");

F_SVD = get_fundamental_from_svd(p1, p2);

% Paramètres intrinsèques
A1 = load("A1.txt");
A2 = load("A2.txt");
R1 = load("R1.txt");
R2 = load("R2.txt");
t1 = load("t1.txt");
t2 = load("t2.txt");

F_PARAMS = get_fundamental_from_params(t1, t2, R1, R2, A1, A2);

% Epipoles
p1 = load("2dpts_1.txt");
p2 = load("2dpts_2.txt");
img1 = imread("castle.01.jpg");
img2 = imread("castle.02.jpg");

[~, ~, V] = svd(F_PARAMS);
e12 = reshape(V(:, end), 1, 3)';

[~, ~, V] = svd(F_PARAMS');
e21 = reshape(V(:, end), 1, 3)';

for i = 1:100
    img = insertShape(img1, "line", [p1(i, :) e12(1:2, :)']);
end

%imshow(img);

% Bruit
sigma = 0.5;
p1_noise = add_noise(p1, sigma);
p2_noise = add_noise(p2, sigma);

F_NOISE = get_fundamental_from_svd(p1_noise, p2_noise);
F_NOISE = get_closest_matrix(F_NOISE);

% Minimisation du critère
options = optimoptions(@lsqnonlin, 'Algorithm', 'levenberg-marquardt');
F_corrected = lsqnonlin(@(F) get_criterion(F, p1, p2), F_SVD, [], [], options);
F_corrected = get_closest_matrix(F_corrected);

function criterion = get_criterion(F, p1, p2)
    n = size(p1, 1);
    criterion = 0;

    for i = 1:n
        criterion = criterion + epipolar_distance(F, [p1(i, :) 1]', [p2(i, :) 1]') ^ 2;
    end

end

function [F] = get_fundamental_from_svd(p1, p2)
    n = size(p1, 1);

    B = zeros(n, 9);

    for i = 1:n
        B(i, :) = [
                   p1(i, 1) * p2(i, 1)
                   p1(i, 2) * p2(i, 1)
                   p2(i, 1)
                   p1(i, 1) * p2(i, 2)
                   p1(i, 2) * p2(i, 2)
                   p2(i, 2)
                   p1(i, 1)
                   p1(i, 2)
                   1
                   ];
    end

    [~, ~, V] = svd(B);
    V = V(:, end);

    F = reshape(V, 3, 3)';
    F = F / F(3, 3);
end

function [F] = get_fundamental_from_params(t1, t2, R1, R2, A1, A2)
    T1 = [R1 -R1 * t1; 0 0 0 1];
    T2 = [R2 -R2 * t2; 0 0 0 1];
    T12 = T2 / T1;
    R = T12(1:3, 1:3);
    t = -inv(R) * T12(1:3, 4);

    e21 = -A2 * R * t;

    e21_X = [
             0 -e21(3) e21(2);
             e21(3) 0 -e21(1);
             -e21(2) e21(1) 0
             ];

    F = e21_X * A2 * R / A1;

    F = F / F(3, 3);
end

function [d] = epipolar_distance(F, p1, p2)
    Fp1 = F * p1;
    d = (p2' * Fp1) / sqrt(Fp1(1)^2 + Fp1(2)^2);
  end

function [p_noise] = add_noise(p, sigma)
    u = p(:, 1);
    v = p(:, 2);
  
    u = u + sigma * randn(size(u));
    v = v + sigma * randn(size(v)); 
  
    p_noise = [u v];
end

function [F_closest] = get_closest_matrix(F)
    [U, D, V] = svd(F);
    D(3, 3) = 0;
    F_closest = U * D * V';
end
