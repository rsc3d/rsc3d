// Mount for Faraday coupling loop for magnetic antenna

include <nuts.scad>

e=0.01;
w=25;

module couplingmount (l=100, w=w, t=2.5, nut1=m4, nut2=m3)
{
    nd1 = nut1 [nut_diameter_high];
    nd2 = nut2 [nut_diameter_high];
    sc1 = nut1 [screw_channel];
    sc2 = nut2 [screw_channel];
    difference () {
        union () {
            translate ([l/2, 0, t/2])
                cube ([l, w, t], center=true);
            translate ([nd1, 0, (t + nut1 [nut_height])/2])
                cube ([2*nd1, w, t + nut1 [nut_height]], center=true);
        }
        translate ([nd1, 0, -t])
            cylinder (r=sc1/2, h=3*t);
        translate ([-(l-2*nd1-nd2-sc2/2)/2 + l-nd2, 0, 0])
            cube ([l-2*nd1-nd2-sc2/2, sc2, 3*t], center=true);
        for (x = [l-nd2, 2*nd1+sc2/2]) {
            translate ([x, 0, -2*t])
                cylinder (r=sc2/2, h=5*t);
        }
        translate ([nd1, 0, t+e])
            nut_hole (nut1, nut1 [nut_height]);
        translate ([2*nd1+sc2/2, 0, t+e])
            cylinder (r=nd2/2, h = nut1 [nut_height]);
    }
}

translate ([0, 0, 0])
    couplingmount ($fa=3, $fs=0.5);
translate ([0, w+2, 0])
    couplingmount ($fa=3, $fs=0.5);
