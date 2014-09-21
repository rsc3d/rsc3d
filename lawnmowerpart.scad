$fa = 3;
module lmpart (h, h2, d_i, d_o, hl, hw, ns, w, nw, nl)
{
    r_o = d_o / 2;
    nhl = hl  - ns;
    lsc = nhl - r_o;
    hsc = hw  - nl;
    a   = atan (hsc / lsc);
    difference () {
        union () {
            cylinder (r = r_o, h = h);
            rotate ([0, 0, 90 + 45]) cube ([r_o, r_o, h2]);
            translate ([-nhl, 0, 0]) cube ([hl, hw, h2]);
            translate ([ns - w, ns, 0]) cube ([3.5 * ns, hw, h]);
            translate ([-w, hw + nw - w, 0]) cube ([4.9 * ns + w, w, h]);
            translate ([-nhl, -nl + nw / 2, 0]) cube ([nw, nl, h2]);
            translate ([-nhl + nw / 2, -nl + nw / 2, 0])
                cylinder (r = nw / 2, h = h2, $fn = 20);
        }
        translate ([0, 0, -h])
            cylinder (r = d_i / 2, h = 3 * h);
        translate ([-nhl, nl , -2])
            rotate (a)
                cube (1.2 * lsc);
    }
}

module bow (r_o, l1, l2, h, ang)
{
    r1  = r_o;
    rx  = r_o + 5;
    difference () {
        render (convexity = 4) minkowski () {
            union () {
                difference () {
                    rotate ([0, 0, -ang]) union () {
                        difference () {
                            cylinder (r = r1 + 0.5, h = 1);
                            cylinder (r = r1 - 0.5, h = 4, center = true);
                            translate ([-r_o, -2 * rx, -2]) cube (2 * rx);
                        }
                        translate ([r1 - 0.5, -l2, 0]) cube ([1, l2, 1]);
                    }
                    translate ([-2 * rx, -r_o, -2]) cube (2 * rx);
                }
                translate ([-l1, r1 - 0.5, 0]) cube ([l1, 1, 1]);
            }
            sphere (r = h / 2);
        }
    }
}

module bows (r_o, l1, l2, h, d, ang)
{
    ll1 = l1 - h / 2;
    ll2 = l2 - h / 2;
    difference () {
        bow (r_o,     ll1, ll2, h, ang);
        bow (r_o + d,  l1,  l2, h, ang);
    }
}

module lawnmower_part
    (h, h2, d_i, d_o, hl, hw, ns, w, nw, nl, l1, l2, hwh, rh, dw, ang)
{
    r_o = d_o / 2;
    difference () {
        union () {
            lmpart (h, h2, d_i, d_o, hl, hw, ns, w, nw, nl);
            rotate ([0, 0, 20])
                translate ([l1 + 2, -rh + hwh / 2 - 2, h / 2])
                    bows (rh, l1, l2, hwh, dw, ang);
            rotate ([0, 0, -45]) cube ([r_o, 3.25 * r_o, h]);
        }
        translate ([0, 0, -h])
            cylinder (r = d_i / 2, h = 3 * h);
    }
}

rotate ([0, 0, -20]) lawnmower_part
    (15.5, 7, 11.1, 16.7, 49.5, 14, 4, 2, 4.6, 6, 25, 50, 23.5, 75, 13, 20);


