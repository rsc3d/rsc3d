e = 0.1; // epsilon
$fn = 100;
include <nuts.scad>;

// Nut embedding:
//
// dw: nut_diameter (high)
// rw: nut radius
//                         +--+
//                         |  |
//                         |  |
//   X---------------------A  |-------
//                         |  |
//                         |  | rw
//                         B--C
//                         nh
// X: center of circle
// We want at least 1mm between nut and outer diameter, x
// We want the radius of the outer circle ro
// z = XB, ri = XA (inner radius), nh = BC (nut height)
// we have
// z² = (ri)² + (rw)²
// and approx.
// x = ro - z - nh
// solving for ro we get:
// ro = x + z + nh = x + sqrt (ri² + rw²) + nh
//


module knob_hollow (r1, r2, r3, r4, height, lift)
{
    translate ([0, 0, lift])
    {
        difference () {
            cylinder (h = height, r = r2);
            translate ([0, 0, -e])
                cylinder (h = height + 2 * e, r = r1);
        }
        if (r4 - r3 > 1) {
            difference () {
                cylinder (h = height, r = r4);
                translate ([0, 0, -e])
                    cylinder (h = height + 2 * e, r = r3);
            }
        }
    }
}

module screw_hole (l, nut_start, nut_end, head_start, nut, height)
{
    translate ([0, 0, height]) rotate ([-90, 0, 0])
        union () {
            cylinder (h = l, r = nut [screw_channel] / 2);
            translate ([0, 0, head_start])
                cylinder (h = l - head_start, r = nut [screw_head_channel] / 2);
            translate ([0, 0, nut_start])
                nut_hole (nut, nut_end - nut_start);
        }
}

module knob_body (knob_dia, axis_dia, axis_carve, conic, depth, top)
{
    kr  = knob_dia / 2;
    ad  = axis_dia * 1.2; // Adjust for smooth insertion
    ar  = ad / 2;
    union () {
        difference () {
            cylinder (h = depth, r = kr);
            translate ([0, 0, top + e])
                cylinder (h = depth - top, r = ar);
        }
        translate ([0, (1-axis_carve) * ad, depth / 2])
            cube ([ad, ad, depth], center = true);
    }
}

module knob (knob_dia, axis_dia, axis_carve, conic, depth, nut)
{
    top     = 1.8;
    kr      = knob_dia / 2;
    nr      = nut [nut_diameter_high] / 2;
    nh      = nut [nut_height];
    r_i     = (axis_dia + 8) / 2;
    inner_r = sqrt (pow (nr, 2) + pow (nh + r_i, 2)) + 1;
    outer_r = 1 + sqrt (pow (inner_r, 2) + pow (nr, 2)) + nh;
    r_o     = (knob_dia - 2) / 2;

    difference () {
        knob_body   (knob_dia, axis_dia, axis_carve, conic, depth, top);
        union () {
            knob_hollow (r_i, inner_r, outer_r, r_o, depth, top);
            screw_hole  (kr, r_i + e, inner_r + nh, kr - nh, nut, depth / 2);
        }
    }
}

knob (30, 4.5, 0, 0, 15, m3);
