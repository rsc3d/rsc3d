e = 0.1; // epsilon
$fn = 100;
include <nuts.scad>;

// Nut embedding:
//
//                         +--D
//                         |  |
//                         |  |
//   X---------------------A  |-------
//                         |  |
//                         |  | nr
//                         B--C
//                         nh
// X: center of circle
// We want some space between nut and outer diameter, x, so that the nut
// fits nicely into the gap between outer and inner diameter.
// Since we over-estimate that gap below and because we're using the 
// *long* width of the nut, we set x to 0 in the code
// below (x is the width of the gap not including the nut height).
// We want the radius of the outer circle ro
// z = XB, ri = XA (inner radius), nh = BC (nut height), nr = CD (nut radius)
// we have
// z² = (ri)² + (nr)²
// and approx. (we get a little more space, better)
// x = ro - z - nh
// solving for ro we get:
// ro = x + z + nh = x + sqrt (ri² + nr²) + nh
//


module knob_hollow (r1, r2, r3, r4, nut_end, nut_h, height, lift)
{
    // Enough material to block nut
    ro = max (r3, nut_end + nut_h);
    translate ([0, 0, lift])
    {
        difference () {
            cylinder (h = height, r = r2);
            translate ([0, 0, -e])
                cylinder (h = height + 2 * e, r = r1);
        }
        if (r4 - ro > 1) {
            difference () {
                cylinder (h = height, r = r4);
                translate ([0, 0, -e])
                    cylinder (h = height + 2 * e, r = ro);
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

module knob (knob_dia, axis_dia, axis_carve, conic, depth, hole_h, nut)
{
    top     = 1.8;
    hole_d  = depth - hole_h;
    ar      = axis_dia / 2;
    kr      = knob_dia / 2;
    nr      = nut [nut_diameter_high] / 2;
    nh      = nut [nut_height];
    hh      = nut [screw_head_height];
    r_i     = (axis_dia + 8) / 2;
    inner_r = sqrt (pow (nr, 2) + pow (nh + r_i, 2)) + 1;
    outer_r = sqrt (pow (inner_r, 2) + pow (nr, 2)) + nh;
    r_o     = (knob_dia - 2) / 2;
    ne      = min (inner_r + nh, kr - hh - nh);
    do_st   = inner_r + nh / 2 > ne;
    i_r     = do_st ? r_o : inner_r;
    ahr     = ar * 1.2;
    ho_o    = r_o > r_i + 3.5 * nh;
    do_ho   = r_o > ahr + 4.5 * nh;
    sl      = r_o - ahr;
    sw      = 1.5 * max (2 * nr, nut [screw_head_channel]);
    nutc_s  = ho_o ? r_i : ahr + nh;
    nutc_e  = do_st ? nutc_s + 1.5 * nh : ne;

    difference () {
        union () {
            difference () {
                knob_body   (knob_dia, axis_dia, axis_carve, conic, depth, top);
                knob_hollow (r_i, i_r, outer_r, r_o, ne, nh, depth, top);
            }
            if (do_st && do_ho) {
                translate ([0, sl / 2 + ahr, depth / 2])
                    cube ([sw, sl, depth], center = true);
            }
        }
        if (do_ho) {
            screw_hole  (kr + e, nutc_s, nutc_e, kr - hh, nut, hole_d);
            translate ([0, 0.75 * nh + nutc_s, -hole_d / 2 + depth + e])
                cube ([2 * nr, 1.5 * nh, hole_d + 2 * e], center = true);
        }
    }
}

knob (30, 4.5, 0, 0, 15, 7.5, m3);
