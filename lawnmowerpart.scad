$fn = 50;
module lmpart (h, h2, d_i, d_o, hl, hw, ns, w, nw, nl)
{
    r_o = d_o / 2;
    nhl = hl  - ns;
    lsc = nhl - d_o;
    hsc = hw  - nl;
    a   = atan (hsc / lsc);
    difference () {
        union () {
            cylinder (r = r_o, h = h);
            translate ([-nhl, 0, 0]) cube ([hl, hw, h2]);
            translate ([-nhl, -nl + nw / 2, 0]) cube ([nw, nl, h2]);
            translate ([-nhl + nw / 2, -nl + nw / 2, 0])
                cylinder (r = nw / 2, h = h2);
        }
        translate ([0, 0, -h])
            cylinder (r = d_i / 2, h = 3 * h);
        translate ([-nhl, nl , 0])
            rotate (a)
                #cube (2 * lsc);
    }
}

lmpart (15.5, 7, 11.1, 16.7, 49.5, 14, 4, 2, 4.6, 6);
