include <nuts.scad>;

eps = 0.01;

module opy_mount
    (l=42, d=5, wl=3.5, wr=2.5, wo=4.5, h=10, t=2, cw=10, ch=3, nut=m3)
{
    nh = nut [nut_height];
    sc = nut [screw_channel];
    tt = t + nh;
    ll = l+2*wo;
    hh = h + 2*d;
    translate ([0, 0, tt]) rotate ([0, 180, 0]) difference () {
        union () {
            cube ([ll, h, tt]);
            cube ([wl+wo, hh, tt]);
            translate ([ll-(wr+wo), 0, 0])
                cube ([wr+wo, hh, tt]);
        }
        translate ([wo, h+d, -eps]) {
            translate ([0, 0, -nh])
                cylinder (r = sc / 2, h = 5 * nh);
            nut_hole (nut, nh);
        }
        translate ([ll-wo, h+d, -eps]) {
            translate ([0, 0, -nh])
                cylinder (r = sc / 2, h = 5 * nh);
            nut_hole (nut, nh);
        }
        translate ([wl+wo, -eps, -tt])
            cube ([cw, ch, 3*tt]);
    }
}

opy_mount ($fa = 2, $fs = .5);
