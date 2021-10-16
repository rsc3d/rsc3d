include <nuts.scad>;

eps  = 0.01;

l    = 42;    // Distance between holes of Orange-Pi
d    =  5;    // Distance above and below hole
wl   =  3.5;
wr   =  2.5;
wo   =  4.5;
h    = 10;
t    =  2;
cw   = 10;
ch   =  3;
nut  = m3;
nh   = nut [nut_height];
ft   =  3;
// This is used to either print the foot-part or the mount part.
// Use openscad -D option to chose.
foot = false;

module opi_mount
    ( l=l, d=d, wl=wl, wr=wr, wo=wo, wal=1, war=2, ha=6.5
    , h=h, t=t, cw=cw, ch=ch, nut=nut, nh=nh
    )
{
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
            cube ([wl+wo+wal, h + ha, tt]);
            translate ([ll-(wr+wo+war), 0, 0])
                cube ([wr+wo+war, h + ha, tt]);
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

module connector (a = 1.5 * (wl + wo), t=3*ft)
{
    r = sqrt (3) * a * a / 6 / a;
    h = a * sqrt (3) / 2;
    translate ([0, r - 2*h/3, 0.5*t])
    difference () {
        cube ([2*(wl+wo), 2*(wl+wo), t], center=true);
        for (n = [0:2]) {
            rotate ([0, 0, n*120])
                translate ([0, -1.5*(wl+wo)-r, 0])
                    cube ([3*(wl+wo), 3*(wl+wo), 3*t], center=true);
        }
    }
}

module opi_foot
    (l=l, fl=2*15, fw = 2*(wl+wo), wo=wo, bw=10, ft=ft, t=t, nh=nh)
{
    ll = l+2*wo+.5;
    tt = t+nh+.5;
    a2 = 1.5 * (wl + wo) - 1;
    difference () {
        union () {
            cube ([ll + fw, bw, ft]);
            translate ([0, bw/2-fl/2, 0])
                cube ([fw, fl, 3*ft]);
            translate ([ll, bw/2-fl/2, 0])
                cube ([fw, fl, 3*ft]);
            translate ([fw/2, 2*fl/3, 0])
                rotate ([0, 0, 180])
                    connector (a=a2, t=3*ft);
            translate ([ll+fw/2, 2*fl/3, 0])
                rotate ([0, 0, 180])
                    connector (a=a2, t=3*ft);
        }
        translate ([fw/2, (bw-tt)/2, ft])
            cube ([ll, tt, 3*ft]);
        translate ([fw/2, -fl/3, -ft])
            rotate ([0, 0, 180])
                connector (t=5*ft);
        translate ([ll+fw/2, -fl/3, -ft])
            rotate ([0, 0, 180])
                connector (t=5*ft);
    }
}

if (foot) {
    opi_foot ($fa = 2, $fs = .5);
    translate ([0, 40, 0])
        opi_foot ($fa = 2, $fs = .5);
} else {
    opi_mount ($fa = 2, $fs = .5);
    translate ([0, 25, 0])
        opi_mount ($fa = 2, $fs = .5);
}

