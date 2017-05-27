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

module countersunk_screw_hole (nut, h)
{
    cylinder
        ( r1 = (nut [screw_head_channel] * 1.1) / 2
        , r2 = (nut [screw_channel]      * 1.1) / 2
        , h  = nut [screw_head_height]  * 1.05
        );
    cylinder (r = nut [screw_channel] / 2, h = h + nut [screw_head_height]);
}

//countersunk_screw_hole (m5, 10, $fa = 6, $fs = .5);
