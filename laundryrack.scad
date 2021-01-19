include <nuts.scad>

eps = 0.01;
h   = 47;
d   = 15;
w   =  4;
t   =  8;

module rackpart (h = h, d = d, w = w, t = t)
{
    sc  = m3 [screw_channel] / 2;
    shc = m3 [screw_head_channel] / 2;
    hh  = m3 [screw_head_height];
    nh  = m3 [nut_height];
    difference () {
        union () {
            cylinder (h = 2 * h + w, r = d / 2 + w);
            translate ([0, 0, h + w / 2])
                cube ([t, d + 2 * w + 2 * t, 2 * h + w], center = true);
        }
        translate ([0, 0, -eps])
            cylinder (h = h, r = d / 2);
        translate ([0, 0, h + w + eps])
            cylinder (h = h, r = d / 2);
        for (z = [h / 2, 2 * h + w - h / 2]) {
            for (y = [-1, 1]) {
                translate ([0, y * (d / 2 + w + t / 2), z]) {
                    rotate ([0, 90, 0]) {
                        translate ([0, 0, -2 * t])
                            cylinder (h = 4 * t, r = sc);
                        translate ([0, 0, t / 2 - hh])
                            cylinder (h = t, r = shc);
                        translate ([0, 0, -1.5 * t + nh])
                            nut_hole (m3, t);
                    }
                }
            }
        }
    }
}

module rack_left (h = h, d = d, w = w, t = t)
{
    difference () {
        translate ([-(2 * h + w), 3 * d, 0])
            rotate ([0, 90, 0])
                rackpart (h, d, w, t, $fa = 2, $fs = .5);
        translate ([-2 * h, 2 * h, -h / 2])
            cube ([5 * h, 5 * h, h], center = true);
    }
}

module rack_right (h = h, d = d, w = w, t = t)
{
    difference () {
        rotate ([0, -90, 0])
            rackpart (h, d, w, t, $fa = 2, $fs = .5);
        translate ([-2 * h, 2 * h, -h / 2])
            cube ([5 * h, 5 * h, h], center = true);
    }
}

rack_left ();
rack_right ();
