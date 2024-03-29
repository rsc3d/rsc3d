// Refrigerator part
include <nuts.scad>;

module axis (r1, r2, r3, h1, h2, a3, a4, s, m)
{
    sup = 0.8;
    translate ([-sup / 2 + s * sin (a3), m + 0.8, -r3 - r1 - s * cos (a3) + .2])
        cube ([sup, h1 - m, r3]);
    rotate ([-90, 0, 0]) {
        rotate ([0, 0, -a3]) {
            translate ([0, s, 0]) {
                cylinder (r = r1, h = h1);
                difference () {
                    rotate ([0, 0, a4 - 180]) {
                        difference () {
                            cylinder (r = r3, h = h2);
                            translate ([0, 0, -h2])
                                cylinder (r = r2, h = 3 * h2);
                            translate ([r3, 0, 0])
                                cube (2 * r3, center = true);
                        }
                    }
                    translate ([r3, 0, 0])
                        cube (2 * r3, center = true);
                }
            }
        }
    }
}

module side (a1, a2, a3, a4, h1, h2, l, m, r1, r2, r3, s, hk, hs)
{
    rr = h1 / 2;
    hh = h2 - rr;
    w1 = hh / cos (a1);
    w2 = hh / cos (a2);
    bc = l + w2;
    sh = rr - rr * cos (a2);
    translate ([-hh * tan (a2), 0, 0]) {
        difference () {
            translate ([0, 0, hh]) {
                rotate ([0, -a1, 0])
                    translate ([-l, 0, -w1])
                        cube ([l, m, w1]);
                rotate ([0, -a2, 0])
                    translate ([-w2, 0, -w2])
                        cube ([w2, m, w2]);
                axis (r1, r2, r3, m + hk, m + hs, a3, a4, s, m);
            }
            translate ([bc + hh * tan (a2) - sh, 0, 0])
                cube (2 * bc, center = true);
        }
    }
}

module cut (l, w, m, h1, hu)
{
    dm = m * 2 / 3;
    dr = m - dm;
    ru = h1 / 2;
    dy = (w + hu) / 2;
    ri = 0.55 * h1 / 2;
    aa = 60;
    translate ([l - dm, w / 2, ru])
    {
        cube ([2 * ru, hu, 2 * ru], center = true);
        translate ([ru, -hu / 2, -ru])
            rotate ([0, -aa, 0])
                cube ([2 * ru, hu, 2 * ru]);
    }
    translate ([l - dm + ru, dy - hu / 2, 0.6 * h1 + ru - m])
        cube ([2.9 * ru, hu, 2 * ru], center = true);
    translate ([l + ri / 3, dy, dm])
        rotate ([90, 0, 0])
            cylinder (r = ri, h = hu);
}

module screw (r, m)
{
    m3w = m3 [screw_channel] / 2;
    m3h = m3 [screw_head_channel] / 2;
    cylinder (r = m3w, h = 2 * r + 4 * m, center = true);
    translate ([0, 0, -(r + 2 * m + 0.01)])
        cylinder (r = m3h, h = m3 [screw_head_height]);
    translate ([0, 0,  (r + 2 * m - m3 [nut_height] + 0.01)])
        rotate ([0, 0, 90])
            nut_hole (m3, 2 * m3 [nut_height]);
}

module fridge
    (l, w, h1, h2, m, r, a1, a2, a3, a4, r1, r2, r3, s, hk, hs, d1, d2)
{
    hm  = (d1 - 2 * d2);
    ha  = (w / 2 - m - d1 / 2 - hm - d2);
    difference () {
        union () {
            translate ([0, 0, -m]) {
                cube ([l, w, m]);
                translate ([0, 0, 0])
                    cube ([l, m, h1]);
                translate ([0, w - m, 0])
                    cube ([l, m, h1]);
                translate ([l, 0, h1 / 2])
                    rotate ([-90, 0, 0])
                        cylinder (r = h1 / 2, h = w);
            }
            translate ([l + h1 - (h1 / 2) * cos (a2), 0, h1 / 2 - m])
                side (a1, a2, a3, a4, h1, h2, l, m, r1, r2, r3, s, hk, hs);
            translate ([l + h1 - (h1 / 2) * cos (a2), w, h1 / 2 - m])
                mirror ([0, 1, 0])
                side (a1, a2, a3, a4, h1, h2, l, m, r1, r2, r3, s, hk, hs);
            rotate ([-90, 0, 0])
                cylinder (r = r + 2 * m, h = w);
        }
        rotate ([-90, 0, 0])
            translate ([0, 0, -w / 2])
                cylinder (r = r, h = 2 * w);
        translate ([0, 0, -2 * l - m])
            cube (4 * l, center = true);
        translate ([0, -(d1 + hm) / 2, 0])
            cut (l, w, m, h1, hm);
        translate ([0,  (d1 + hm) / 2, 0])
            cut (l, w, m, h1, hm);
        translate ([0,  ha / 2 - w / 2 + m, 0])
            cut (l, w, m, h1, ha);
        translate ([0, -ha / 2 + w / 2 - m, 0])
            cut (l, w, m, h1, ha);
        rotate ([0, 85, 0]) {
            translate ([0, w * 1 / 4, 0])
                screw (r, m);
            translate ([0, w * 3 / 4, 0])
                screw (r, m);
        }
    }
}

r2 = 8;
a4 = acos ((5 * 5 - r2 * r2 - r2 * r2) / (-2 * r2 * r2));
hk = 4.05 - 2.2;
hs = 5.5  - 3.5;
r  = 10.5;
h1 = 10;
l  = 68 - r - h1 / 2; // 54

fridge
    (l, 30, h1, 24, 3.3, r, 18, 40, -15, a4, 3.1, r2, 40, 7.5, hk, hs, 6, 0.9);
translate ([0, 35, 0])
fridge
    (l, 30, h1, 24, 3.3, r, 18, 40, -15, a4, 3.1, r2, 40, 7.5, hk, hs, 6, 0.9);
