e = 0.1; // epsilon

// Screws / Nuts
// described by a K-Element vector, offsets defined as follows
nut_diameter_low   = 0;
nut_diameter_high  = 1;
nut_height         = 2;
screw_channel      = 3;
screw_head_channel = 4;
screw_head_height  = 5;
m3 = [5.6, 6.5, 2.5, 3.5, 6.0, 2.5];
m4 = [7.0, 8.0, 3.5, 4.5, 7.5, 3.0];

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

module nut_hole (nut, h)
{
    w = (nut [nut_diameter_low] + nut [nut_diameter_high]) / 2;
    translate ([0, 0, h / 2]) difference () {
        cube ([w, 2*w, h], center = true);
        rotate ([0, 0, 30])
            translate ([0, 1.5 * w, 0])
                cube ([2*w, 2*w, h+e], center = true);
        rotate ([0, 0, -30])
            translate ([0, 1.5 * w, 0])
                cube ([2*w, 2*w, h+e], center = true);
        rotate ([0, 0, 30])
            translate ([0, -1.5 * w, 0])
                cube ([2*w, 2*w, h+e], center = true);
        rotate ([0, 0, -30])
            translate ([0, -1.5 * w, 0])
                cube ([2*w, 2*w, h+e], center = true);
    }
}

module screw_hole (l, nut_start, nut_end, head_start, nut, height)
{
    translate ([0, 0, height]) rotate ([-90, 0, 0])
        union () {
            cylinder (h = l, r = nut [screw_channel] / 2);
            translate ([0, 0, head_start])
                cylinder (h = l - head_start, r = nut [screw_head_channel / 2]);
            translate ([0, 0, nut_start])
                nut_hole (nut, nut_end - nut_start);
        }
}

module knob_body (knob_dia, axis_dia, axis_carve, conic, depth, top)
{
    kr  = knob_dia / 2;
    ar  = axis_dia / 2;
    union () {
        difference () {
            cylinder (h = depth, r = kr);
            translate ([0, 0, top + e])
                cylinder (h = depth - top, r = ar);
        }
        translate ([0, (1-axis_carve) * axis_dia, depth / 2])
            cube ([axis_dia, axis_dia, depth], center = true);
    }
}

module knob (knob_dia, axis_dia, axis_carve, conic, depth, nut)
{
    top     = 1.8;
    kr      = knob_dia / 2;
    nr      = nut [nut_diameter_high] / 2;
    nh      = nut [nut_height];
    r_i     = (axis_dia + 3.2) / 2;
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

knob (30, 4.5, 0.25, 0, 15, m3);
