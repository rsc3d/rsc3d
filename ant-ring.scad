dia    = 1.5;
height = 6.0;
thickn = 5;

module antenna_ring (t=thickn, h=height, wd=dia, cyd=30)
{
    d1 = 0.7;
    d2 = 1.2;
    hh = h / 2;
    alpha = atan (((d2 - d1) / 2 * wd) / hh);
    difference () {
        cylinder (r=cyd/2, h=height);
        translate ([0, 0, -height])
            cylinder (r=cyd/2 - t, h=3*height);
        translate ([-1.5*cyd, 0, h-hh])
            rotate ([0, 90, 0])
                cylinder (r=wd/2, h=3*cyd);
        for (p = [-alpha, alpha]) {
            translate ([0, 0, h-hh])
                rotate ([p, 0, 0])
                    translate ([0, 0, h])
                        cube ([2*cyd, wd*d1, 2*h], center=true);
        }
    }
}

antenna_ring ($fa = 2, $fs = .3);
