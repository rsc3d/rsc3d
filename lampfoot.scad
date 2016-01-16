module lampfoot 
    ( h = 35, r = 20
    , ri = 5, rk = 6.5/2, hk = 14.25, hkb = 10
    , sr = 2.5 / 2, sd = 10, sc = 8.5 / 2
    )
{
    difference () {
        union () {
            cylinder (h = h, r = r);
            translate ([0, 0, h - 0.01])
                cylinder (h = h / 2, r1 = r, r2 = ri);
        }
        translate ([0, 0, hkb])
            cylinder (4 * h, r = ri);
        translate ([0, 0, hk])
            rotate ([90, 0, 0])
                cylinder (h = r * 1.5, r = rk);
        translate ([ sc, 0, -.01])
            cylinder (r = sr, h = sd);
        translate ([-sc, 0, -.01])
            cylinder (r = sr, h = sd);
    }
}

rotate ([-90, 0, 0])
    lampfoot ($fa = 6, $fs = .5);
