// Mount for Faraday coupling loop for magnetic antenna

include <nuts.scad>

e=0.01;  // epsilon
l=100;   // length of plate
w=25;    // width of plate
t=2.5;   // thickness of plate
t2=13.5; // thickness of high part (half of it, each part gets half)

module couplingmount
    (l=l, w=w, t=t, t2=t2, nut1=m3, nut2=m3, nut3=m3, make_nut=true)
{
    nd1 = nut1 [nut_diameter_high];
    nd2 = nut2 [nut_diameter_high];
    sc1 = nut1 [screw_channel];
    sc2 = nut2 [screw_channel];
    difference () {
        union () {
            translate ([l/2, 0, t/2])
                cube ([l, w, t], center=true);
            translate ([nd1, 0, (t + t2/2)/2])
                cube ([2*nd1, w, t + t2/2], center=true);
        }
        translate ([-(l-2*nd1-nd2-sc2/2)/2 + l-nd2, 0, 0])
            cube ([l-2*nd1-nd2-sc2/2, sc2, 3*t], center=true);
        for (x = [l-nd2, 2*nd1+sc2/2]) {
            translate ([x, 0, -2*t])
                cylinder (r=sc2/2, h=5*t);
        }
        for (y = [nut1 [nut_diameter_high], -nut1 [nut_diameter_high]]) {
            translate ([0, y, 0]) {
                translate ([nd1, 0, -t])
                    cylinder (r=sc1/2, h=9*t);
                translate ([nd1, 0, -e]) {
                    if (make_nut) {
                        nut_hole (nut1, nut1 [nut_height]);
                    } else {
                        cylinder
                            ( r = nut1 [screw_head_channel]/2
                            , h = nut1 [screw_head_height]
                            );
                    }
                }
            }
        }
        translate ([-nd1, 0, t+t2/2]) {
            rotate ([0, 90, 0]) {
                cylinder (r = nut3 [screw_channel] / 2, h = 6*nd1);
            }
        }
    }
}

for (tr = [0, w+2]) {
    donut = tr == 0;
    translate ([0, tr, 0])
        couplingmount ($fa=3, $fs=0.5, make_nut=donut);
}
