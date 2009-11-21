union() {
    translate ([-4, -4, 0])
        cube([8, 8, 3]);
    translate ([-3, -3, 3])
        cube([6, 6, 1]);
    translate([0, 0, 4])
        cylinder(h=3, r1=3, r2=3);
    translate([0, 0, 7])
        sphere(1);
}
