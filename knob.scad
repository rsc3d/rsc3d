e = 0.1; // epsilon

// Screws / Nuts
// described by a 5-Element vector, offsets defined as follows
nut_diameter       = 0;
nut_height         = 1;
screw_channel      = 2;
screw_head_channel = 3;
screw_head_height  = 4;
m3 = [6.5, 2.5, 3.5, 6.0, 2.5];
m4 = [8.0, 3.5, 4.5, 7.5, 3.0];

// Nut embedding:
//
// dw: nut_diameter
// rw: nut radius
//                         +--+
//                         |  |
//                         |  |
//   X---------------------A  |-------
//                         |  |
//                         |  | rw
//                         B--C
//                         wh
// X: center of circle
// We want at least 1mm between nut and outer diameter, x
// We want the radius of the outer circle ro
// z = XB, ri = XA (inner radius), wh = BC (nut height)
// we have
// z² = (ri)² + (rw)²
// and approx.
// x = ro - z - wh
// solving for ro we get:
// ro = x + z + wh = x + sqrt (ri² + rw²) + wh
//

module knob_hollow (outer_dia, inner_dia, height, lift, nut)
{
    wr = nut [nut_diameter] / 2;
    wh = nut [nut_height];
    inner_r = sqrt (pow (wr, 2) + pow (wh + inner_dia / 2, 2)) + 1;
    outer_r = 1 + sqrt (pow (inner_r, 2) + pow (wr, 2)) + wh;

    translate ([0, 0, lift])
    {
        difference () {
            cylinder (h = height, r = inner_r);
            translate ([0, 0, -e])
                cylinder (h = height + 2 * e, r = inner_dia / 2);
        }
        if (outer_dia / 2 - outer_r > 1) {
            difference () {
                cylinder (h = height, r = outer_dia / 2);
                translate ([0, 0, -e])
                    cylinder (h = height + 2 * e, r = outer_r);
            }
        }
    }
    echo (inner_dia / 2);
    echo (inner_r);
    echo (outer_r);
    echo (outer_dia / 2);
}

//module screw_hole ()
//{
//}

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

module knob (knob_dia, axis_dia, axis_carve, conic, depth)
{
    top = 2;
    difference () {
        knob_body   (knob_dia, axis_dia, axis_carve, conic, depth, top);
        knob_hollow (knob_dia - 2, axis_dia + 4, depth, top, m3);
    }
}

knob(30, 4.5, 0.25, 0, 15);
