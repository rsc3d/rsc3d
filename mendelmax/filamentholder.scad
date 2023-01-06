include <nuts.scad>
e = 0.1;
$fn=50;

module corner (h, w, d, ratio, angle, outer)
{
    corner_angle = atan (1 / ratio);
    omul = (outer ? -1 : 1);
    t_x = h / cos (-angle) + omul * (w / 2) * tan (angle)
        - (omul * angle > 0 ? 0 : omul * d * tan (angle));
    rotate (angle)
        translate ([t_x, omul * (w - d) / 2])
            rotate ([0, 0, 180])
                difference () {
                    translate ([0, -d / 2, d / 2 - e])
                        cube ([ratio * w, d, w]);
                    translate ([0, -d, w + d / 2])
                        rotate ([0, corner_angle, 0])
                            cube ([1.5 * ratio * w, 2 * d, 2 * w]);
                }
}

module endp (h, w, d, angle, nut)
{
    amul = (angle > 0 ? 1 : -1);
    wcub = w / cos (angle) - 2 * d * tan (abs (angle)) - e;
    t_y  = h * tan (angle);
    rc   = nut [screw_channel] / 2;
    cw   = d; // + nut [nut_height];
    nh   = nut [nut_height] / 2;
    translate ([h - cw / 2, t_y, (w + d) / 2])
        difference () {
            cube ([cw, wcub, w + e], center = true);
            rotate ([0, 90, 0])
            {
                cylinder (r = rc, h = 2 * d, center = true);
                translate ([0, 0, -d / 2 - e])
                    rotate ([0, 0, 90])
                        nut_hole (nut, nh);
            }
        }
}

module holder (h, w, d, angle, hole_r, nut)
{
    l = (h + w + 5) / cos (angle);
    difference () {
        union () {
            cylinder (r = hole_r + 12, h = d, center = true);
            rotate ([0, 0, angle])
                translate ([l / 2, 0, 0])
                    cube ([l, w, d], center = true);
            rotate ([0, 0, -angle])
                translate ([l / 2, 0, 0])
                    cube ([l, w, d], center = true);
            corner (h, w, d, 2, -angle, true);
            corner (h, w, d, 2, -angle, false);
            corner (h, w, d, 2,  angle, true);
            corner (h, w, d, 2,  angle, false);
            endp (h, w, d, angle, nut);
            endp (h, w, d, -angle, nut);
        }
        cylinder (r = hole_r + 0.5, h = 2 * d, center = true);
        translate ([-3 * hole_r, 0, 0])
            cube ([6 * hole_r, 2 * hole_r, 3 * d], center = true);
        translate ([h + h, 0, 0])
            cube (2 * h, center = true);
    }
}

module clip (d, bw, cw, nl)
{
    nh = 4;
    translate ([0, 0, d / 2]) {
        rotate ([30, 0, 0]) {
            translate ([0, bw / 2, 0]) {
                translate ([0, 0, -cw / 2])
                    cube ([cw, bw, cw], center = true);
                translate ([0, 2.5 - bw / 2 + nl, nh / 2 - e])
                    cube ([cw, 5, nh + e], center = true);
            }
        }
    }
}

module mount (h, w, d, angle, nut)
{
    a  = abs (angle);
    cw = w + d - e;
    lm = h * tan (a);
    sc = nut [screw_channel] / 2;
    l  = 2 * lm + w / cos (a);
    nl = 11.9;
    bw = nl + 5 + 7.5;
    //cd = 49.35;
    cd = 88 / 2;
    difference () {
        union () {
            cube ([cw, l, d], center = true);
            translate ([0,  cd, 0])
                rotate ([0, 0, 180])
                    clip (d, bw, cw, nl);
            translate ([0, -cd, 0])
                rotate ([0, 0,   0])
                    clip (d, bw, cw, nl);
        }
        translate ([-d / 2,  lm, 0])
            cylinder (r = sc, h = 2 * d, center = true);
        translate ([-d / 2, -lm, 0])
            cylinder (r = sc, h = 2 * d, center = true);
        translate ([0, 0, -15 -d / 2])
            cube ([2 * cw, l, 30], center = true);
    }
}

h      = 150;
w      = 20;
d      = 4.3;
angle  = 24.5;
hole_r = 6;
nut    = m4;

mount  = true;
test   = false;
holder = false;

// measured from frame
fangle = 30;

// This should be about 115mm:
// base = 2 * h * tan (angle) - w / cos (angle);
// echo (base);

if (holder || test) {
    holder (h, w, d, angle, hole_r, nut);
}
if (test) {
    translate ([h, 0, w / 2])
        rotate ([0, 90, 0])
            mount  (h, w, d, angle, nut);
}
if (mount) {
    translate ([-w, 0, 0])
        mount  (h, w, d, angle, nut);
    translate ([ w, 0, 0])
        mount  (h, w, d, angle, nut);
}
