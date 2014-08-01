e = 0.1;
$fn = 100;
module peg (l, h, w, spring_d, spring_l, wire_dia, minw, filled)
{
    angle = atan (w - 2 * minw / ((l - spring_d) / 2));
    hshift = l / 12 * 5 - w * 0.15;
    hrad   = w / 2.2;
    sshift = l / 12;
    s2     = 2 * sshift;
    bck    = 1.5 * w;
    minh   = minw / 2;
    union () {
        difference () {
            union () {
                difference () {
                    union () {
                        cube ([l / 6 * 5.2, h, w + e], center = true);
                        translate ([-(l / 6 * 5 + l / 6) / 2, 0, -(l / 6 - h)])
                            rotate ([90, 0, 0])
                                cylinder (r = l / 12, h = h, center = true);
                    }
                    if (!filled) {
                        translate ([hrad + minw, 0, minw])
                            cube ([2 * hshift, h - 2 * minw, w], center = true);
                    }
                }
                translate ([0, -minh - e, 0])
                    cube ([l / 6 * 5.2, minw, w], center = true);
                translate ([-sshift + spring_d / 5, 0, -w / 4])
                    cube ([minw, h - e, w / 2], center = true);
            }
            translate ([-hshift, 0, hrad])
                rotate ([90, 0, 0])
                    cylinder (r = hrad, h = h + e, center = true);
            translate ([-0.3 * l, 0, w / 2 + 0.1 * w / 4.5])
                rotate ([90, 0, 0])
                    cylinder (r = w / 4.5, h = h + e, center = true);
            translate ([-sshift, 0, w / 2 + 0.2 * spring_d])
                rotate ([90, 0, 0])
                    cylinder (r = spring_d / 2, h = h + e, center = true);
            translate ([-spring_l -l / 12, 0, -w / 2])
                rotate ([90, 0, 0])
                    cylinder (r = wire_dia / 2, h = h + e, center = true);
            translate ([0, 0, -l - w / 2])
                cube (2 * l, center = true);
            translate ([0, 0, l + w / 2])
                rotate ([0, -angle, 0])
                    cube (2 * l, center = true);
        }
        if (!filled) {
            translate ([-s2 - spring_d / 2, -minh - e, w / 2 + e])
                cube ([spring_d, minw, 2 * w - minw - e], center = true);
            translate ([-s2 - minh, -1.25 * minw - e, 0.375 * w + e])
                cube ([minw, 2.5 * minw, 1.5 * w - minw - e], center = true);
            translate ([-s2 - spring_d + minh, -1.25 * minw - e, 0.375 * w + e])
                cube ([minw, 2.5 * minw, 1.5 * w - minw - e], center = true);
        }
    }
}

peg (72, 9.2, 6.5, 6.5, 17.5, 1.5, 1, false);
