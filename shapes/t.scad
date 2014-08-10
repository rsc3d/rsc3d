union() {
    translate([-4, -4, 0])
    difference() {
        translate ([0, 0, 0])
            cube([8, 8, 1]);
        union() {
            translate ([0, 0, 0])
                cube([1, 1, 1]);
            translate ([7, 0, 0])
                cube([1, 1, 1]);
            translate ([0, 7, 0])
                cube([1, 1, 1]);
            translate ([7, 7, 0])
                cube([1, 1, 1]);
        }
    }
    translate ([0, 0, 1])
        cylinder(h=1, r1=3, r2=3);
    translate([0, 0, 2])
        cylinder(h=3, r1=1, r2=0);
}
