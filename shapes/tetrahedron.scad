module tetrahedron (diag) {
    polyhedron
    ( points =
        [ [ diag/2,  diag/2,  diag/2]
        , [-diag/2, -diag/2,  diag/2]
        , [-diag/2,  diag/2, -diag/2]
        , [ diag/2, -diag/2, -diag/2]
        ]
    , triangles =
        [ [0, 1, 2]
        , [0, 3, 1]
        , [0, 2, 3]
        , [1, 3, 2]
        ]
    );
}

//tetrahedron (80 / pow (2, 0.5));
