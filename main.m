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
    end

end