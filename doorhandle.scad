include <nuts.scad>
use     <lib/segment.scad>

module handle
    ( h = 66, h2 = 62.8
    , w = 18, w2 = 10.2
    , d1 = 5.1, d2 = 4.3, dd3 = 2.5, d4 = 1
    , hd = 8.5, nut = m5
    , k = 3.2
    , e = 20
    )
{
    hh = (h - h2) / 2;
    d3 = d2 - dd3;
    a  = 2 * d3 / sqrt (2);
    b  = 2 * (dd3 - d4) / sqrt (2);
    difference () {
        cube ([h, w, d1]);
        translate ([hh + hd, k + w2 / 2, d2 + 0.01])
            rotate ([180, 0, 0])
                countersunk_screw_hole (m4, 3 * d1, 3 * d1);
        translate ([h - hh - hd, k + w2 / 2, d2 + 0.01])
            rotate ([180, 0, 0])
                countersunk_screw_hole (m4, 3 * d1, 3 * d1);
    }
    translate ([h / 2, w - 0.01, 0])
        cylinder_segment (h, e, d1);
}

module hole_cover (nut, h)
{
    cylinder (r = nut [screw_head_channel] / 2, h = h);
}

module clip (w = 10, p)
{
    a = sqrt (2) * p / 2;
    difference () {
        rotate ([0, -45, 0])
            cube ([p, w, p]);
        translate ([-p, -w, a])
            cube ([3 * p, 3 * w, 3 * p]);
        translate ([-3 * p, -w, -p])
            cube ([3 * p, 3 * w, 3 * p]);
    }
}

module cover (h = 66, w = 10, d = 2, d2 = 1.5, h1 = 3, h2 = 1.5)
{
    p = 4 * d2 / sqrt (2);
    cube ([h, w, d]);
    cube ([d2, w, d + h1 + h2]);
    translate ([h - d2, 0, 0])
        cube ([d2, w, d + h1 + h2]);
    translate ([0, 0, -2 * d2 + h1 + h2 + d])
        clip (w, p);
    translate ([h, 0, -2 * d2 + h1 + h2 + d])
        mirror ([1, 0, 0]) clip (w, p);
}

translate ([10, -20, 0])
    hole_cover (m4, .8, $fa = 6, $fs = .5);
translate ([40, -20, 0])
    hole_cover (m4, .8, $fa = 6, $fs = .5);
d1 = 5.1;
translate ([0, 0, d1])
    mirror ([0, 0, 1]) handle (d1 = d1, $fa = 6, $fs = .5);
