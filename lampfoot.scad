h = 35;

module lampfoot 
    ( h = h, r = 20
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
        translate ([0, -ri, hk+rk]) {
            rotate ([-45, 0, 0]) translate ([0, 0, -1.5*rk]) {
                cylinder (h=3*rk, r=rk);
            }
        }
        translate ([0, -ri+rk-sqrt(2)*rk, sqrt(2)*rk/2+hk]) {
            difference () {
                cube ([2*rk, 3*rk, sqrt(2)*rk], center=true);
                rotate ([45, 0, 0]) translate ([0, 0, 3*rk])
                    cube ([6*rk, 9*rk, 6*rk], center=true);
            }
        }
        translate ([ sc, 0, -.01])
            cylinder (r = sr, h = sd);
        translate ([-sc, 0, -.01])
            cylinder (r = sr, h = sd);
    }
}

difference () {
    union () {
        translate ([ 2,0,0]) rotate ([0, 90, 0])
            lampfoot ($fa = 6, $fs = .5);
        translate ([-2,0,0]) rotate ([0, -90, 0])
            lampfoot ($fa = 6, $fs = .5);
    }
    translate ([0, 0, -h/2])
        cube ([5*h, 5*h, h], center=true);
}
