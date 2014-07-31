include <nuts.scad>
module rod_holder ()
{
    hc = m3 [screw_head_channel] / 2;
    hh = m3 [screw_head_height];
    difference () {
        cube ([130, 18, 11.5], center = true);
        translate ([50, 0, 0])
            cylinder (r = 4.1, h = 30, center = true);
        translate ([50, 0, 0])
            rotate ([0, 0, 45])
                cube ([1, 14, 12], center = true);
        translate ([50, 0, 0])
            rotate ([0, 0, -45])
                cube ([1, 14, 12], center = true);
        translate ([-50, 0, 0])
            cylinder (r = 4.1, h = 30, center = true);
        translate ([-50, 0, 0])
            rotate ([0, 0, 45])
                cube ([1, 14, 12], center = true);
        translate ([-50, 0, 0])
            rotate ([0, 0, -45])
                cube ([1, 14, 12], center = true);
        translate ([60, 0, 0])
            cube ([20, 4, 12], center = true);
        translate ([-60, 0, 0])
            cube ([20, 4, 12], center = true);
        translate ([30, 0, 0])
            cylinder (r = 2.5, h = 30, center = true);
        translate ([-30, 0, 0])
            cylinder (r = 2.5, h = 30, center = true);
        translate ([-118 / 2, 0, 0])
            rotate ([90, 0, 0])
                cylinder (r = 3.5 / 2, h = 20, center = true);
        rotate ([90, 0, 0])
            translate ([-118 / 2, 0, 18 / 2 - m3 [nut_height] + e])
                nut_hole (m3, m3 [nut_height + e]);
        rotate ([-90, 0, 0])
            translate ([-118 / 2, 0, (18 / 2 - hh / 2 + e)])
                cylinder (h = hh, r = hc, center = true);
        translate ([118 / 2, 0, 0])
            rotate ([90, 0, 0])
                cylinder (r = 3.5 / 2, h = 20, center = true);
        rotate ([90, 0, 0])
            translate ([118 / 2, 0, 18 / 2 - m3 [nut_height] + e])
                nut_hole (m3, m3 [nut_height + e]);
        rotate ([-90, 0, 0])
            translate ([118 / 2, 0, (18 / 2 - hh / 2 + e)])
                cylinder (h = hh, r = hc, center = true);
    }
}

difference () {
    union () {
        translate ([0, 10, 18/2])
            rotate ([90, 0, 0])
                rod_holder ();
        translate ([0, -10, 18/2])
            rotate ([-90, 0, 0])
                rod_holder ();
    }
    translate ([0, 0, 100 + 18/2])
        cube (200, center = true);
}
