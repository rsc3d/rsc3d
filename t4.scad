module rtcy (r, t) {
    translate(t)
        rotate(90, r)
            translate ([0, 0, -5])
                difference() {
                    cylinder(h=10, r1=15, r2=15);
                    cylinder(h=10, r1= 5, r2= 5);
                }
}

union() {
    translate ([-30, -30, 0])
        cube([60, 60, 30]);
    rtcy ([1, 0, 0], [  0,  25,  30]);
    rtcy ([1, 0, 0], [  0, -25,  30]);
    rtcy ([0, 1, 0], [ 25,   0,  30]);
    rtcy ([0, 1, 0], [-25,   0,  30]);
}
