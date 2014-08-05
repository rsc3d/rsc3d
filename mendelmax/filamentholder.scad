include <nuts.scad>
$fn=50;
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
        }
        cylinder (r = hole_r + 0.5, h = 2 * d, center = true);
        translate ([h + h, 0, 0])
            cube (2 * h, center = true);
    }
}

holder (160, 20, 4.2, 25, 6);
