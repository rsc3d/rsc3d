e  = 0.01;
h1 = 7.5;
l  = 45;
module lamppart
    (d1 = 17, h1 = h1, di = 8, l = l, t = 21, d2 = 9.5, lh = 28, d3 = 7)
{
    difference () {
        union () {
            cylinder (r = d1 / 2, h = h1);
            translate ([0, 0, h1])
                rotate ([0, 90, 0])
                    cylinder (r = h1, h = l);
        }
        cylinder (r = di / 2, h = h1 * 3, center = true);
        translate ([0, 0, h1])
            cylinder (r = d1 / 2, h = h1);
        translate ([t + 1, 0, h1])
            rotate ([0, 90, 0])
                cylinder (r = d2 / 2, h = l - t);
        translate ([lh, 0, h1])
            rotate ([-90, 0, 0])
                cylinder (r = d3 / 2, h = 2 * h1);
    }
}

difference () {
    union () {
        translate ([0, 0, -h1])
            lamppart ($fa = 6, $fs = .5);
        translate ([0, 3*h1, h1])
            rotate ([180, 0, 0])
                lamppart ($fa = 6, $fs = .5);
    }
    translate ([0, 0, -1.5*l+e])
        cube (3*l, center=true);
}
