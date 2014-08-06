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
    translate ([h - cw / 2, t_y, (w + d) / 2 - e])
        difference () {
            cube ([cw, wcub, w], center = true);
            rotate ([0, 90, 0])
            {
                cylinder (r = rc, h = 2 * d, center = true);
                translate ([0, 0, -nh + d / 2 + e])
                    rotate ([0, 0, 90])
                        nut_hole (nut, nh);
            }
        }
}

module holder (h, w, d, angle, hole_r)
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
            endp (h, w, d, angle, m4);
            endp (h, w, d, -angle, m4);
        }
        cylinder (r = hole_r + 0.5, h = 2 * d, center = true);
        translate ([h + h, 0, 0])
            cube (2 * h, center = true);
    }
}

holder (160, 20, 4.3, 25, 6);
