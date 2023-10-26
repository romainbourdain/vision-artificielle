addpath("lib/");

prega = imread("data/prega.pgm");
api = imread("data/t2.pgm");

pts_image = [0 0; 0 size(prega, 1); size(prega, 2) size(prega, 1); size(prega, 2) 0;];

pts_scene = [165 485; 232 452; 232 555; 165 646];
api = put_image(pts_scene, pts_image, api, prega);

pts_scene = [69 475; 165 487; 164 645; 65 621];
api = put_image(pts_scene, pts_image, api, prega);

pts_scene = [75 451; 230 454; 164 487; 69 476];
api = put_image(pts_scene, pts_image, api, prega);

pts_scene = [350 418; 438 422; 732 654; 236 671];
api = put_image(pts_scene, pts_image, api, prega);
imshow(api);

[x1 y1] = ginput(1);
[x2 y2] = ginput(1);
[x3 y3] = ginput(1);
[x4 y4] = ginput(1);
api = put_image([x1 y1; x2 y2; x3 y3; x4 y4], pts_image, api, prega);
imshow(api);

function [scene] = put_image(pts_scene, pts_image, scene, image)
  H = get_homography(pts_scene, pts_image);
  min_x = min(pts_scene(:, 1));
  min_y = min(pts_scene(:, 2));
  max_x = max(pts_scene(:, 1));
  max_y = max(pts_scene(:, 2));

  for i=min_x:max_x
    for j=min_y:max_y
      p = H * [i; j; 1];
      p = p / p(3);
      p = round(p);

      if p(1) < 1 || p(1) > size(image, 2) || p(2) < 1 || p(2) > size(image, 1)
        continue
      end

      scene(j, i) = image(p(1), p(2));
    end
  end
end