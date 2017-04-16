module hole (r = 4 / 2, r2 = 7.4 / 2, hk = 2, h)
{
    translate ([0, 0, -h])
        cylinder (r = r, h = 20 * h);
    translate ([0, 0, h - hk + 0.01])
        cylinder (r1 = r, r2 = r2, h = hk);
    translate ([0, 0, h])
        cylinder (r = r2, h = 10 * h);
}

module base
    ( h = 6, w = 12, l = 80
    , r = 5, s = 0, s2 = 14, s3 = 15.5, s4 = 18
    , hy1 = 4.9, hy2 = 6.5, hr = 9.5, hl = 5.9
    , h1x = 1.5
    , h2x = 27, h2y = 2.5
    )
{
    lxh = s4 - r;
    lyh = s3 - s2;
    lwh = sqrt (lxh * lxh + lyh * lyh);
    a = atan (lyh / lxh);

    difference () {
        union () {
            cube ([l - r, w, h]);
            translate ([0, w - r + s, 0])
                difference () {
                    cylinder (h = h, r = r);
                    translate ([0, -2*h, -h])
                        cube (3 * h);
                }
            translate ([0, r - (s2 - w), 0])
                cylinder (h = h, r = r);
            translate ([-r, r - (s2 - w), 0])
                cube ([2 * r, (w - r + s) - (r - (s2 - w)), h]);
            translate ([0, w - s2, 0])
                rotate ([0, 0, -a])
                    cube ([lwh, lwh, h]);
            translate ([h1x, w, 0])
                hook1 ();
            translate ([h2x, h2y, 0])
                hook2 ();
        }
        translate ([l - r - hr, hy2, 0])
            hole (h = h);
        translate ([hl - r, hy1, 0])
            hole (h = h);
    }
}

module hook1 (h = 18, hh = 10.5, d = 5, w = 12, hw = 5, hd = 8)
{
    translate ([w, 0, 0])
        rotate ([0, 0, 180])
            difference () {
                cube ([w, d, h]);
                translate ([-1, -d, hh - hw / 2])
                    cube ([hd + 1, 3*d, hw]);
            }
}

module hook2
    ( h = 30.5, d = 7, w = 19, w2 = 17
    , hh = 19, hw = 7, hd = 11
    , s = 3, sh = 7.5
    )
{
    translate ([w, d, 0])
    rotate ([0, 0, 180])
    difference () {
        cube ([w, d, h]);
        translate ([-1, -d, hh])
            cube ([w - w2 + 1, 3*d, h]);
        translate ([-hw/2, -d, hh - hw / 2])
            cube ([hd, 3*d, hw]);
        translate ([hd - hw / 2, -d, hh])
            rotate ([-90, 0, 0])
                cylinder (h = 3*d, r=hw/2);
        translate ([0, 0, h - s])
            rotate ([45, 0 , 0])
                translate ([0, -w, 0])
                    cube (2 * w);
        translate ([0, -sqrt (2) * w + s, -sqrt (2) * w + sh])
            difference () {
                translate ([-w/2, 0, 0])
                rotate ([45, 0 , 0])
                    cube (2 * w);
                translate ([-w, -2*w, -4*w + sqrt (2) * w])
                    cube (4 * w);
            }
    }
}

translate ([0, 5, 0])
    rotate ([-90, 0, 0])
        base ($fa = 3, $fs = .5);
mirror ([0, 1, 0])
    rotate ([-90, 0, 0])
        base ($fa = 3, $fs = .5);
