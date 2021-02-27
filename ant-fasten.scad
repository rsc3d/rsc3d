include <nuts.scad>

e = 0.01;

h  =  7.5;
h2 =  4;
w  = 25;
l  = 50;
lz = 10;
wd =  1.8;
dc =  5;

module antenna_fastener_l (h=h, w=w, l=l, wd=wd, nut=m3)
{
    ss = nut [screw_channel]/2 * 1.1;
    translate ([l, 0, h]) {
        rotate ([0, 180, 0]) {
            difference () {
                cube ([l, w, h]);
                translate ([l/2, -w, h])
                    rotate ([-90, 0, 0])
                        cylinder (r=wd/2, h=3*w);
                for (x= [l/4, 3*l/4]) {
                    translate ([x, w/2, -e]) {
                        nut_hole (nut, h=h-2);
                        translate ([0, 0, -h])
                            cylinder (r = ss, h=3*h);
                    }
                }
                translate ([l/2, w/2, h-wd/2])
                    rotate ([180, 0, 0])
                        countersunk_screw_hole (nut, h=3*h, h2=h);
            }
        }
    }
}

module antenna_fastener_u (h2=h2, w=w, l=l, lz=lz, wd=wd, nut=m3)
{
    hc = nut [screw_head_channel]/2 * 1.1;
    hh = nut [nut_height];
    ss = nut [screw_channel]/2 * 1.1;
    difference () {
        cube ([l, w, h2]);
        translate ([l/2, -w, 0])
            rotate ([-90, 0, 0])
                cylinder (r=wd/2, h=3*w);
        for (x= [l/4, 3*l/4]) {
            translate ([x, w/2, 0]) {
                //countersunk_screw_hole (nut, h=3*h2);
                translate ([0, 0, -h2])
                    cylinder (r = nut [screw_channel]/2 * 1.1, h=3*h2);
                translate ([0, 0, h2 - hh + e])
                    cylinder (r = hc, h = hh);
            }
        }
    }
    translate ([-lz+e, 0, 0]) {
        difference () {
            cube ([lz, w, h2]);
            for (x= [lz/2, w - lz/2]) {
                translate ([lz/2, x, -e]) {
                    translate ([0, 0, -h2])
                        cylinder (r = ss, h = 3 * h2);
                    nut_hole (nut, h=nut [nut_height]);
                }
            }
        }
    }
}

module relief (h2=h2, w=w, lz=lz, dc=dc, yh=1.5, nut=m3)
{
    hd = h2 + dc;
    ss = nut [screw_channel]/2 * 1.1;
    translate ([lz, 0, hd]) {
        rotate ([0, 180, 0]) {
            difference () {
                cube ([lz, w, hd]);
                for (x= [lz/2, w - lz/2]) {
                    translate ([lz/2, x, -(hd)]) {
                        cylinder (r = ss, h = 3 * (hd));
                    }
                }
                hull () {
                    for (x= [0, dc+h2]) {
                        translate ([-lz, w/2, dc/2 - yh - x])
                            rotate ([0, 90, 0])
                                cylinder (r = dc/2, h=3*lz);
                    }
                }
            }
        }
    }
}

antenna_fastener_l ($fa=3, $fs=0.5);
translate ([0, 1.5*w, 0])
    antenna_fastener_u ($fa=3, $fs=0.5);
translate ([1.5 * (-lz+e), 0, 0])
    relief ($fa=3, $fs=0.5);
