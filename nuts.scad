e = 0.1; // epsilon

// Screws / Nuts
// described by a K-Element vector, offsets defined as follows
nut_diameter_low   = 0;
nut_diameter_high  = 1;
nut_height         = 2;
screw_channel      = 3;
screw_head_channel = 4;
screw_head_height  = 5;
m3 = [ 5.6,  6.5, 2.5, 3.5,  6.0, 2.5];
m4 = [ 7.0,  8.0, 3.5, 4.5,  7.5, 3.0];
m5 = [ 8.0,  9.2, 3.7, 5.0,  9.2, 3.5];
m6 = [10.0, 11.2, 5.0, 6.0, 10.1, 4.0];

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

// A screw channel + cone for a sunk screw, with h2 it can be deeper
// h is the length of the screw, h2 is how far it is sunk in the cone
// height/width only depends on the given nut.
module countersunk_screw_hole (nut, h, h2 = 0)
{
    r2 = (nut [screw_channel] * 1.1) / 2;
    cylinder
        ( r1 = (nut [screw_head_channel] * 1.1) / 2
        , r2 = r2
        , h  = nut [screw_head_height]  * 1.05
        );
    cylinder (r = r2, h = h + nut [screw_head_height]);
    translate ([0, 0, -h2+e])
        cylinder (r = nut [screw_head_channel] * 1.1 / 2, h = h2);
}
//translate ([5, 0, 0])
//    countersunk_screw_hole (m5, 10, 10, $fa = 6, $fs = .5);

// A channel for a sideways embedded nut
// ehf is the factor for the embedded height for the hole of the nut, we
// make it a little wider than nut-height by default, but it can be
// overridden.
// ewf is the factor for the width of the hole (nut diameter * ewf)
module embedded_nut (nut, h, ehf=1.3, ewf=1)
{
    w = (nut [nut_diameter_low] + nut [nut_diameter_high]) / 2;
    union () {
        translate ([0, -w * ewf * 0.5, 0])
            cube ([nut [nut_height] * ehf, w * ewf, h]);
        rotate ([0, 90, 0]) rotate ([0, 0, 30])
            nut_hole (nut, nut [nut_height] * ehf);
    }
}
//embedded_nut (m3, 20);

