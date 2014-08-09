include <nuts.scad>
use     <peg.scad>

module nutpeg (l, w, h, spring_d, spring_l, wire_dia, minw, nut)
{
    difference () {
        peg (l, w, h, spring_d, spring_l, wire_dia, minw, true);
        translate ([1, 0, -3.25 + 1.3])
        {
            nut_hole (nut, 6.5);
            cylinder (r = nut [screw_channel] / 2, h = 20, center = true);
        }
        translate ([1 + 18, 0, -3.25 + 1.3])
        {
            nut_hole (nut, 6.5);
            cylinder (r = nut [screw_channel] / 2, h = 20, center = true);
        }
    }
}

translate ([0, 6, 0])
    nutpeg (70, 10, 6.5, 6.5, 16.5, 1.5, 1, m3);
translate ([0, -6, 0])
    nutpeg (70, 10, 6.5, 6.5, 16.5, 1.5, 1, m3);
translate ([0, 18, 0])
    peg    (70, 10, 6.5, 6.5, 16.5, 1.5, 1, true);
translate ([0, -18, 0])
    peg    (70, 10, 6.5, 6.5, 16.5, 1.5, 1, true);
