include <nuts.scad>;

l    = 50;   // length of inner
bl   = 26.8; // length of board
w    = 25.9; // width of board
t    = 2.5;  // thickness of wall
d    = 2.6;  // height of lead
tb   = 1.5;  // thickness of board
sd   = 4;    // distance of holes from side
plw  = 10.8; // width of plug
pll  = 15;   // length of plug with soldering
pp   = 9;    // plug position from quartz side
// cable diameter and width of cables coming out
cbld = 0.6;
cblw = 9;

ro   = 3;    // Radius of outer rounding

m3r = m3 [screw_channel] / 2;

module lower_part 
    ( l=l, bl=bl, w=w, t=t
    , d=d, sd=sd, tb=tb
    , pll=pll, plw=plw, plh=0.6, pp=pp
    , cbld=cbld, cblw=cblw
    )
{
    ps = pp + t;
    difference () {
        hull () {
            for (x = [ro, l+2*t-ro]) {
                for (y = [ro, w+2*t-ro]) {
                    translate ([x, y, ro])
                        sphere (ro);
                    translate ([x, y, ro])
                        cylinder (r=ro, h=t+d+tb - ro);
                }
            }
        }
        //#cube ([l+2*t, w+2*t, t+d+tb]);
        translate ([t, t, t+d])
            cube ([2*sd+t, w, 3*t]);
        translate ([2*sd+t, t, t])
            cube ([bl-2*sd, w, 3*t]);
        translate ([bl+t-1, ps, t+d+plh])
            cube ([pll+1, plw, 3*t]);
        translate ([l/2, ps+(plw-cblw)/2, t+d+tb-cbld])
            cube ([l, cblw, 3*t]);
        for (x = [sd+t, l-sd+t]) {
            for (y = [sd+t, w-sd+t]) {
                translate ([x, y, -t])
                    cylinder (r=m3r, h=5*t);
                translate ([x, y, -0.01])
                    nut_hole (m3, m3 [nut_height]);
            }
        }
    }
}

module upper_part
    ( l=l, bl=bl, w=w, t=t
    , d=d, sd=sd, tb=tb
    , pll=pll, plw=plw, plh=1.6, pp=pp
    , cbld=cbld, cblw=cblw
    , bh=4.2
    , usbw=8, usbd=11.5
    )
{
    shcr = m3 [screw_head_channel]/2;
    ps   = pp + t;
    difference () {
        //cube ([l+2*t, w+2*t, t+bh]);
        hull () {
            for (x = [ro, l+2*t-ro]) {
                for (y = [ro, w+2*t-ro]) {
                    translate ([x, y, ro])
                        sphere (ro);
                    translate ([x, y, ro])
                        cylinder (r=ro, h=t+bh - ro);
                }
            }
        }
        translate ([t+2*sd, t, t])
            cube ([bl-2*sd, w, 2*bh]);
        translate ([l/2, w+2*t-plw-ps+(plw-cblw)/2, t+bh-cbld])
            cube ([l, cblw, 3*t]);
        translate ([bl+t-1, w+2*t-plw-ps, t+bh-plh])
            cube ([pll+1, plw, 3*t]);
        for (x = [sd+t, l-sd+t]) {
            for (y = [sd+t, w-sd+t]) {
                translate ([x, y, -t])
                    cylinder (r=m3r, h=5*t);
                translate ([x, y, -0.01])
                    cylinder (r=shcr, h=m3 [screw_head_height]);
            }
        }
        translate ([t+usbd, -t, t+0.01])
            cube ([usbw, 3*t, bh]);
    }
}

translate ([0, -(w+4*t), 0])
    lower_part ($fa=3, $fs=0.5);
upper_part ($fa=3, $fs=0.5);
