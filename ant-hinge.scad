include <nuts.scad>
use <cabletubeholder.scad>

e = 0.01;

r_i = 12;   // Inner radius (determined by BNC)
t   =  3;   // Thickness of walls
dr  =  5;   // Distance of rim
dh  =  2;   // Distance between rim and clamp
wd  =  1.8; // Wire dia
bs  = 25;   // Space for BNC connector (height) including t
bd  =  9;   // BNC hole dia
r58 =  7.5; // RG-58 hole dia
nut = m3;


// clamp parameters
fs  =  1.5;               // free space between holder and body to allow turning
h_d = 2 * (r_i + t + fs); // dia of holder
h_s =  3.2;               // screw dia
h_l = h_d + 10;           // width in addition to hole
h_w = 13;                 // length of part with screw
h_t = 13;                 // thickness of clamp
h_r = 5.75/3;             // ratio of screw head to screw

up  = dr+t+dh+h_t+wd+h_t+nut[nut_diameter_high]/2+2*t; // upper part
// Use 2*dh for distance, RG-58 hole shouldn't get in the way of the
// clamp even if the cylinder is slightly lower
lp  = max (bs, dr+t+2*dh+h_t+r58);                     // lower part
h   = up + lp;                                         // Overall height

module antenna_hinge (r_i=r_i, h=h, t=t, dr=dr, h_t=h_t, dh=dh, wd=wd, nut=nut)
{
    r_o = r_i + t;
    hh  = h-dr-t-h_t-dh-wd-h_t-nut[nut_diameter_high]/2-2*t; // hollow height
    difference () {
        union () {
            cylinder (r=r_o, h=h);
            for (z= [dr, h-dr-t]) {
                translate ([0, 0, z])
                    cylinder (r=r_o + dr, h=t);
            }
        }
        // Hole for Antenna Wire
        translate ([0, 2*r_o, h-(wd/2+dr+t+dh+h_t)])
            rotate ([90, 0, 0])
                cylinder (r=wd/2, h=5*r_o);
        // Upper and lower Screw in filled part
        for (z= [h-dr-t-h_t/2, h-dr-t-h_t-dh-wd-h_t]) {
            translate ([-r_o+t, 0, z])
                rotate ([0, 90, 0])
                    countersunk_screw_hole (nut, h=3*r_o, h2=r_o);
            translate ([r_o/2, 0, z])
                rotate ([0, 90, 0])
                    nut_hole (nut, h=r_o);
        }
        // Hollow
        translate ([0, 0, t])
            cylinder (r=r_i, h=hh);
        // BNC hole
        translate ([0, 0, -t])
            cylinder (r=bd/2, h=3*t);
        // RG-58 hole
        translate ([0, 2*t, hh+t-r58/2])
            rotate ([-90, 0, 0])
                cylinder (r=r58/2, h=r_o);
    }
}

module visible_structure ()
{
    antenna_hinge ($fa=3, $fs=0.5);
    for (z= [dr+t+dh, h-(dr+t+dh)-13]) {
        translate ([0, 0, z])
            holder (h_d, h_s, h_l, h_w, h_t, h_r);
    }
}

module printable_structure ()
{
    difference () {
        translate ([2, 0, 0])
            rotate ([0, 90, 0])
                antenna_hinge ($fa=3, $fs=0.5);
        translate ([0, 0, -h])
            cube ([3*h, 2*h, 2*h], center=true);
    }

    difference () {
        translate ([-2, 0, 0])
            rotate ([0, -90, 0])
                antenna_hinge ($fa=3, $fs=0.5);
        translate ([0, 0, -h])
            cube ([3*h, 2*h, 2*h], center=true);
    }

    for (x= [-2*r_i, 2*r_i]) {
        translate ([x, 5*r_i, 0])
            holder (h_d, h_s, h_l, h_w, h_t, h_r);
    }
}

visible = false;

if (visible) {
    visible_structure ($fa=3, $fs=0.5);
} else {
    printable_structure ($fa=3, $fs=0.5);
}
