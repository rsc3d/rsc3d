<tetrahedron.scad>

difference () {
    tetrahedron (80 / pow (2, 0.5));
    translate ([50, 0, 0])
        cube (100, center = true);
}
