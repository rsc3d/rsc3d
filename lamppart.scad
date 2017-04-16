e = 0.001;
module lamppart
    (d1 = 17, h1 = 7.5, di = 8, l = 45, t = 21, d2 = 9.5, lh = 28, d3 = 7)
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

lamppart ($fa = 6, $fs = .5);
