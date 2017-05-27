include <nuts.scad>;

module ear (l, h, d)
{
    v = l / 2;
    kr = (v*v + h*h) / (2 * h);
    difference () {
        translate ([0, -(kr - h), 0])
            cylinder (r = kr, h = d);
        translate ([-l, -2 * l, -d])
            cube ([2 * l, 2 * l, 3 * d]);
    }
}

module handle
    ( h = 66, h2 = 62.8
    , w = 18, w2 = 10.2
    , d1 = 6.3, d2 = 4.3, dd3 = 2.5, d4 = 1
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
        translate ([-h, k, d2])
            cube ([3*h, w2, d1]);
        translate ([-hh, k, -d1])
            cube ([2 * hh, w2, 3*d1]);
        translate ([-hh + h, k, -d1])
            cube ([2 * hh, w2, 3*d1]);
        translate ([hh + hd, k + w2 / 2, d2 + 0.01])
            rotate ([180, 0, 0])
                countersunk_screw_hole (m4, 3 * d1);
        translate ([h - hh - hd, k + w2 / 2, d2 + 0.01])
            rotate ([180, 0, 0])
                countersunk_screw_hole (m4, 3 * d1);
        translate ([-d3 + hh, k, 0])
            rotate ([0, 45, 0])
                cube ([a, w2, a]);
        translate ([h + d3 - hh, k, 0])
            mirror ([1, 0, 0]) rotate ([0, 45, 0])
                cube ([a, w2, a]);
        translate ([-(dd3 - d4) + hh, k, d2])
            rotate ([0, 45, 0])
                cube ([b, w2, b]);
        translate ([h + (dd3 - d4) - hh, k, d2])
            mirror ([1, 0, 0]) rotate ([0, 45, 0])
                cube ([b, w2, b]);
    }
    translate ([h / 2, w - 0.01, 0])
        ear (h, e, d1);
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

translate ([0, -20, 0])
    cover ($fa = 6, $fs = .5);
handle ($fa = 6, $fs = .5);
