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