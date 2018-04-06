include <nuts.scad>

l   = 95.8; // length of board including connectors
w   = 62;   // width of board
hl  =  2;   // height of highest part on bottom of board
hb  =  1.8; // height (width) of board (pcb)
ha  =  1;   // additional height above nut (below pcb at floor)
h   = 15.5; // height of highest part on top of board
t   =  2.5; // thickness of walls of box
hx  =  6;   // X-coordinate of hole from first recess (negative)
h2h = 28;   // Y hole-to-hole (holes are equal distance from center)
sx  = 38;   // X-coordinate of support from hole
rxl = 27;   // Recess in pcb left  X
rxr = 27.5; // Recess in pcb right X
rw  =  6;   // Recess width
rr  = 35.3; // Recess-to-recess
rd  =  8.7; // Recess depth
ri  =  1.5; // Radius of inner rounding
ew  = 14.8; // width of ethernet
ep  =  6;   // position of ethernet
eh  =  3;   // ethernet from top (max height - eh)
uw  =  7.5; // width of usb
u1p = 23.5; // position of first usb
u2p = 33;   // position of second usb
pd  = 10;   // diameter of plug
pp  =  9.5; // position of plug
ph  =  6.5; // height of plug
ah  =  0;   // Additional depth of screw head on top
mu  =  0.3; // Top part: move from edge to fit top
rv  =  m3 [nut_diameter_low];          // additional reinforcement for nuts
rz  =  m3 [screw_head_channel] / 2;    // support at holes
ss  =  (m3 [screw_channel] - 0.5) / 2; // fit in board holes
hy  =  (w - h2h) / 2; // Y-coordinate of hole
ro  = ri + t;

// We need to have l = rxl + rw/2 + rr + rw/2 + rxr

// Bottom layer must be a little thicker than nut height, so t > nut height

module bottom
    ( l=l, w=w, hl=hl, hb=hb, ha=ha, h=h, t=t
    , hx=hx, hy=hy
    , rxl=rxl, rxr=rxr, rw=rw, rr=rr, rd=rd
    , ri=ri, ro=ro, rv=rv, rz=rz, ss=ss
    )
{
    difference () {
        union () {
            difference () {
                render () hull () {
                    for (x = [ro, l+2*t-ro]) {
                        for (y = [ro, w+2*t-ro]) {
                            translate ([x, y, ro])
                                sphere (ro);
                            translate ([x, y, ro])
                                cylinder (r=ro, h=t+hl+hb+ha+h - ro);
                        }
                    }
                }
                translate ([t, t, t])
                    render () hull () {
                        for (x = [ri, l-ri]) {
                            for (y = [ri, w-ri]) {
                                translate ([x, y, ri])
                                    sphere (ri);
                                translate ([x, y, ri])
                                    cylinder (r=ri, h=2*h);
                            }
                        }
                    }
            }
            translate ([t, t, 0]) {
                for (x = [rxl, l-rxr]) {
                    for (y = [rd-rw/2, w-(rd-rw/2)]) {
                        translate ([x, y, t/2])
                            cylinder (r=rw/2, h=t/2+hl+hb+ha+h/2);
                        translate ([x, y, t])
                            cylinder (r=rv, h=ha);
                    }
                    for (y = [(rd-rw/2)/2, w-(rd-rw/2)/2]) {
                        translate ([x, y, t+(hl+hb+ha+h/2)/2])
                            cube ([rw, rd-rw/2, hl+hb+ha+h/2], center=true);
                    }
                }
                for (y = [hy, w-hy]) {
                    translate ([rxl-hx, y, t-0.01]) {
                        cylinder (r=rv, h=ha);
                        cylinder (r=ss, h=ha+hb+hl);
                        cylinder (r=rz, h=ha+hl);
                    }
                }
                // Support position
                translate ([rxl-hx+sx, w/2, t-0.01])
                    cylinder (r=rz, h=ha+hl);
            }
        }
        translate ([t, t, 0]) {
            for (x = [rxl, l-rxr]) {
                for (y = [rd-rw/2, w-(rd-rw/2)]) {
                    translate ([x, y, -0.01]) {
                        rotate ([0, 0, 90])
                            nut_hole (m3, m3 [nut_height]);
                        cylinder (r=m3 [screw_channel]/2, h=2*h);
                    }
                }
            }
            // Remove part of support cylinder for SD-Card slot
            translate ([rxl-hx-rz-ss, hy, t + ha + rz])
                cube (2*rz, center=true);
            // Ethernet, USB1, USB2
            translate ([l-6*t, ep, t+ha+hl+hb+0.01])
                cube ([8*t, u2p+uw-ep, h]);
            // Plug
            translate ([l-2*t, w-pp, t+ha+hl+hb+ph])
                rotate ([0, 90, 0])
                    cylinder (r=pd/2, h=5*t);
        }
    }
}

module top
    ( l=l, w=w, hl=hl, hb=hb, ha=ha, h=h, t=t
    , hx=hx, hy=hy
    , rxl=rxl, rxr=rxr, rw=rw, rr=rr, rd=rd
    , ri=ri, ro=ro, rv=rv, rz=rz, ss=ss
    , mu=mu
    )
{
    difference () {
        union () {
            render () hull () {
                for (x = [ro, l+2*t-ro]) {
                    for (y = [ro, w+2*t-ro]) {
                        translate ([x, y, ro])
                            difference () {
                                sphere (ro);
                                translate ([0, 0, 2*ro])
                                    cube (4*ro, center=true);
                            }
                    }
                }
            }
            translate ([t, t, 0]) {
                for (x = [rxl, l-rxr]) {
                    for (y = [rd-rw/2, w-(rd-rw/2)]) {
                        translate ([x, y, ro-t/2])
                            cylinder (r=rw/2, h=t/2+h/2);
                    }
                    for (y = [(rd-rw/2-mu)/2+mu, w-(rd-rw/2-mu)/2-mu]) {
                        translate ([x, y, ro+(h/2)/2])
                            cube ([rw, rd-rw/2-mu, h/2], center=true);
                    }
                }
                for (y = [mu, w-t-mu]) {
                    translate ([rxl, y, ro-t/2])
                        cube ([rr + rw, t, (h+t)/2]);
                }
                translate ([mu, (w-rr)/2, ro-t/2])
                    cube ([2*t, rr, (h/2+t)/2]);
                for (y = [hy, w-hy]) {
                    translate ([rxl-hx, y, ro-0.01]) {
                        cylinder (r=rz, h=h);
                    }
                }
                translate ([rxl-hx-t/2, hy, ro-0.01])
                    cube ([t, w-2*hy, h-hl]);
                // Ethernet wall (above)
                translate ([l, w-(ew)-(ep+0.01), ro-0.01])
                    cube ([t, ew-0.02, eh]);
            }
        }
        translate ([t, t, 0]) {
            for (x = [rxl, l-rxr]) {
                for (y = [rd-rw/2, w-(rd-rw/2)]) {
                    translate ([x, y, -0.01]) {
                        cylinder (r=rz, h=m3[screw_head_height]+ah);
                        cylinder (r=m3 [screw_channel]/2, h=2*h);
                    }
                }
            }
        }
    }
}

rotate ([0, 0, 90]) {
    translate ([0,  5, 0])
        bottom ($fa=3, $fs=0.5);
    translate ([0, -(w+2*t), 0])
        top    ($fa=3, $fs=0.5);
}
