function main(exo)
    addpath("src/");
    addpath("lib/");

    if ~exist('exo', 'var')
        return;
    end

    switch exo
        case 0
            ex00;
        case 1
            ex01;
        case 2
            ex02;
        case 3
            ex03;
        case 5
            ex05;
        otherwise
            disp("Cet exercice n'existe pas");
    end

end