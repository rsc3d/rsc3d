e = 0.1;
$fn = 100;
module peg (l, w, h, spring_d, spring_l, wire_dia, minw, filled)
{
    hshift = l / 12 * 5 - h * 0.15;
    hrad   = h / 2.2;
    sshift = l / 12;
    s2     = 2 * sshift;
    bck    = 1.5 * h;
    minh   = minw / 2;
    ashift = sshift - spring_d / 2;
    cube_l = l / 6 * 5.2;
    angle  = atan ((h - 2 * minw) / (cube_l / 2 + ashift));
    union () {
        difference () {
            union () {
                difference () {
                    union () {
                        cube ([cube_l, w, h + e], center = true);
                        translate ([-(l / 6 * 5 + l / 6) / 2, 0, -(l / 6 - w)])
                            rotate ([90, 0, 0])
                                cylinder (r = l / 12, h = w, center = true);
                    }
                    if (!filled) {
                        translate ([hrad + minw, 0, minw])
                            cube ([2 * hshift, w - 2 * minw, h], center = true);
                    }
                }
                translate ([0, -minh - e, 0])
                    cube ([l / 6 * 5.2, minw, h], center = true);
                translate ([-sshift + spring_d / 5, 0, -h / 4])
                    cube ([minw, w - e, h / 2], center = true);
            }
            translate ([-hshift, 0, hrad])
                rotate ([90, 0, 0])
                    cylinder (r = hrad, h = w + e, center = true);
            translate ([-0.3 * l, 0, h / 2 + 0.1 * h / 4.5])
                rotate ([90, 0, 0])
                    cylinder (r = h / 4.5, h = w + e, center = true);
            translate ([-sshift, 0, h / 2 + 0.2 * spring_d])
                rotate ([90, 0, 0])
                    cylinder (r = spring_d / 2, h = w + e, center = true);
            translate ([-spring_l -l / 12, 0, -h / 2])
                rotate ([90, 0, 0])
                    cylinder (r = wire_dia / 2, h = w + e, center = true);
            translate ([0, 0, -l - h / 2])
                cube (2 * l, center = true);
            difference () {
                translate ([cube_l / 4 - ashift / 2, 0, l / cos (angle)])
                    rotate ([0, angle, 0])
                        cube (2 * l, center = true);
                translate ([-1.5 * l - sshift, 0, 0])
                    cube (3 * l, center = true);
                }
        }
        if (!filled) {
            translate ([-s2 - spring_d / 2, -minh - e, h / 2 + e])
                cube ([spring_d, minw, 2 * h - minw - e], center = true);
            translate ([-s2 - minh, -1.25 * minw - e, 0.375 * h + e])
                cube ([minw, 2.5 * minw, 1.5 * h - minw - e], center = true);
            translate ([-s2 - spring_d + minh, -1.25 * minw - e, 0.375 * h+ e])
                cube ([minw, 2.5 * minw, 1.5 * h - minw - e], center = true);
        }
        //translate ([cube_l / 4 - ashift / 2, 0, w + 2 * minw])
        //    cube (minw, center = true);
        //translate ([cube_l / 4 - ashift / 2, 0, h])
        //    cube ([cube_l / 2 + ashift, w, h], center = true);
    }
}

translate ([0, 18, 0])
    peg (72, 9.2, 6.5, 6.5, 16.5, 1.5, 1, true);
translate ([0, 6, 0])
    peg (72, 9.2, 6.5, 6.5, 16.5, 1.5, 1, false);
translate ([0, -6, 0])
    peg (72, 9.2, 6.5, 6.5, 16.5, 1.5, 1, false);
translate ([0, -18, 0])
    peg (72, 9.2, 6.5, 6.5, 16.5, 1.5, 1, true);
