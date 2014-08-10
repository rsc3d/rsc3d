include <nuts.scad>
use     <yplane.scad>

module rod_holder (support)
{
    hc = m3 [screw_head_channel] / 2;
    hh = m3 [screw_head_height];
    s1 = (11.5 - 0.5) / 2;
    s2 = 11.5 / 4;
    difference () {
        union () {
            if (support) {
                for (s = [-s1, -s2, 0, s2, s1]) {
                    translate ([-118 / 2, 0, s])
                        cube ([130 - 118, 10, 0.5], center = true);
                    translate ([ 118 / 2, 0, s])
                        cube ([130 - 118, 10, 0.5], center = true);
                }
            }
            difference () {
                cube ([130, 18, 11.5], center = true);
                translate ([60, 0, 0])
                    cube ([20, 4, 12], center = true);
                translate ([-60, 0, 0])
                    cube ([20, 4, 12], center = true);
                translate ([30, 0, 0])
                    cylinder (r = 2.6, h = 30, center = true);
                translate ([-30, 0, 0])
                    cylinder (r = 2.6, h = 30, center = true);
            }
        }
        translate ([118 / 2, 0, 0])
            rotate ([90, 0, 0])
                cylinder (r = 3.5 / 2, h = 20, center = true);
        rotate ([90, 0, 0])
            translate ([118 / 2, 0, 18 / 2 - m3 [nut_height] + e])
                nut_hole (m3, m3 [nut_height + e]);
        translate ([-118 / 2, 0, 0])
            rotate ([90, 0, 0])
                cylinder (r = 3.5 / 2, h = 20, center = true);
        rotate ([90, 0, 0])
            translate ([-118 / 2, 0, 18 / 2 - m3 [nut_height] + e])
                nut_hole (m3, m3 [nut_height + e]);
        rotate ([-90, 0, 0])
            translate ([-118 / 2, 0, (18 / 2 - hh / 2 + e)])
                cylinder (h = hh, r = hc, center = true);
        rotate ([-90, 0, 0])
            translate ([118 / 2, 0, (18 / 2 - hh / 2 + e)])
                cylinder (h = hh, r = hc, center = true);
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
    }
}

module rod_holder_halves ()
{
    difference () {
        union () {
            translate ([0, 10, 18/2])
                rotate ([90, 0, 0])
                    rod_holder (support = false);
            translate ([0, -10, 18/2])
                rotate ([-90, 0, 0])
                    rod_holder (support = false);
        }
        translate ([0, 0, 100 + 18/2])
            cube (200, center = true);
    }
}

// Allow to mount the rod holders some cm lower -- see also yplane.scad
// This tries to be printable in one piece, either cut out the support
// parts or use some force when fastening the rods.
module rod_holder_new (md1, md2)
{
    w  = 30;
    d  = abs (md2 - md1);
    h  = d ;
    difference () {
        union () {
            rotate ([-90, 0, 0])
                rod_holder (support = true);
            translate ([w / 2 + 30 / 2, 0, d])
            {
                difference () {
                    cube ([w, 11.5, h], center = true);
                    translate ([0, 0, 0])
                        rotate ([90, 0, 0])
                            cylinder (r = 2.6, h = 12, center = true);
                    translate ([w / 2, 0, -9 + 2 * d / 3])
                        rotate ([90, 0, 0])
                            cylinder (r = d / 3, h = 12, center = true);
                    translate ([w / 2 - d / 6 + e, 0, 10])
                        cube ([d / 3 + e, 12, 20], center = true);
                }
            }
        }
        translate ([-130 / 2 + 30 / 2 + d / 3, 0, 0])
            cube (130, center = true);
    }
}

// FIXME: md is from yplane.scad, should be a parameter
md1 = min (38 - 25, 70 / 2 - 20 - 9 / 2);
md2 = 22 - 25;

module test_rod_holder_new ()
{
    rotate ([90, 0, 0])
        y_plane (130, 70, 4.3);
    translate ([0, -11.5 / 2, -md1])
        rod_holder_new (md1, md2);
    translate ([0, -11.5 / 2, -md2])
        rotate ([0, 180, 0])
            rod_holder_new (md1, md2);
}

render = true;
test   = false;

if (render) {
    translate ([0, 22, 0])
        rod_holder_new (md1, md2);
    translate ([0, 8, 0])
        rod_holder_new (md1, md2);
    translate ([0, -8, 0])
        rod_holder_new (md1, md2);
    translate ([0, -22, 0])
        rod_holder_new (md1, md2);
}

if (test) {
    test_rod_holder_new ();
}
