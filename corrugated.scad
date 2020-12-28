// Fixation of currugated sheet

use <lib/segment.scad>

chord = 41;
h     = 17.3;
w     = 2;
wl    = 24.3;
d1l   = 8;
eps   = 0.01;
ud    = 26;

module lower_part (chord = chord, h = h, w = wl, d1 = d1l, d2 = 2, hf = w)
{
    difference () {
        union () {
            rotate ([90, 0, 0])
                cylinder_segment (chord = chord, h = h, th = w);
            translate ([0, d1/2, 0])
                cylinder (r = d1, h = hf);
            translate ([0, -d1/2, hf/2])
                cube ([2*d1, 2*d1, hf], center = true);
        }
        translate ([0, -w/2, -h/3])
            cylinder (r = d1/2, h = 2 * h);
        translate ([0, d1, -hf])
            cylinder (r = d2/2, h=3*hf);
    }
}

module uppper_part
    (c = chord, h = h, w = w, d1 = 6.5, d2 = 12, hc = 5.5, d = ud)
{
    ch = 3 * hc;
    translate ([0, 0, ch])
    rotate ([180, 0, 0])
    difference () {
        translate ([0, 0, ch/2])
            cube ([d, d, ch], center = true);
        translate ([0, d, -(h + w) + .85 * hc])
            rotate ([90, 0, 0])
                cylinder_segment (chord = c + 2*w, h = h + w, th=2*d);
        cylinder (h = 2 * ch, r = d1/2);
        translate ([0, 0, ch - hc + eps])
            cylinder (h = hc, r1 = d1/2, r2 = d2/2);
    }
}

do_lower = true;

//lower_part ($fa = 2, $fs = .5);
if (do_lower) {
    for (y = [0, ud + 5]) {
        for (x = [0, ud + 5]) {
            translate ([x, y, 0])
                uppper_part ($fa = 2, $fs = .5);
        }
    }
} else {
    for (y = [0, wl + d1l + 5]) {
        for (x = [0, chord + 5]) {
            translate ([x, y, 0])
                lower_part ($fa = 2, $fs = .5);
        }
    }
}

