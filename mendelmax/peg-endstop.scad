include <nuts.scad>
use     <peg.scad>

// Endstop holder using a peg
// nut_t is nut translation in x-direction starting from the hole where
// the rod will fit. This has been adjusted to be compatible with
// another popular endstop-holder design.
// sd is screw distance
// sj is the distance of the soldering joint on the endstop for which
// we leave space.
module nutpeg (l, w, h, sp_d, sp_l, wire_dia, minw, nut_t, sd, sj, nut)
{
    hshift = l / 12 * 5 - h * 0.15;
    difference () {
        peg (l, w, h, sp_d, sp_l, wire_dia, minw, true);
        translate ([-hshift + nut_t, 0, -h / 2 + 1.3])
        {
            nut_hole (nut, 6.5);
            cylinder (r = nut [screw_channel] / 2, h = 20, center = true);
        }
        translate ([-hshift + nut_t + sd, 0, -h / 2 + 1.3])
        {
            nut_hole (nut, 6.5);
            cylinder (r = nut [screw_channel] / 2, h = 20, center = true);
        }
        translate ([-hshift + nut_t + sd + sj, 0, -h / 2 - 0.001])
        {
            cylinder (r1 = 4.5 / 2, r2 = 1 / 2, h = 3);
        }
    }
}

translate ([0, 6, 0])
    nutpeg (70, 10.5, 6.5, 6.75, 21,   1.5, 1, 11.5, 19, 12.5, m3);
translate ([0, 18, 0])
    peg    (70, 10.5, 6.5, 6.75, 21,   1.5, 1, true);
translate ([0, -6, 0])
    nutpeg (70, 10,   6.5, 6.6,  21.5, 1.5, 1, 11.5, 19, 12.5, m3);
translate ([0, -18, 0])
    peg    (70, 10,   6.5, 6.6,  21.5, 1.5, 1, true);
