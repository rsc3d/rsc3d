union() {
    translate ([-5, -5, 0])
        cube([2, 2, 2]);
    translate ([-5, 3, 0])
        cube([2, 2, 2]);
    translate ([3, -5, 0])
        cube([2, 2, 2]);
    translate ([3, 3, 0])
        cube([2, 2, 2]);
    translate ([-4, -4, 0.5])
        cube([8, 8, 1]);
    translate([0, 0, 3.5])
        sphere(2);
}
