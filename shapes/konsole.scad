
union() {
    cube([20, 100, 50]);
    translate([0,0,50])
        cube([80, 100, 30]);

    translate ([20,40,20])
        difference () {
            cube([40, 20, 30]);
            rotate (45, [0, 1, 0])
                cube([80, 20, 80]);
        }
}
