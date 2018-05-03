include <nuts.scad>
use     <lib/funcs.scad>

e   = 0.001; // Epsilon
l   = 146;   // length of board excluding connectors
w   = 58.5;  // width of board
hl  =  4.5;  // height of highest part on bottom of board
hb  =  1.4;  // height (width) of board (pcb)
h   = 14.4;  // height of highest part on top of board
ri  =  1.5;  // Radius of inner rounding
t   =  2.5;  // thickness of walls of box
pd  = 11;    // diameter of plug-hole
ph  =  6.5;  // height of plug
pdet = 18.5; // Position of DET plug
pdut = 16.5; // Position of DUT plug
wusb = 11;   // width  of usb plug
husb =  8;   // height of usb plug
usbx = 39;   // X-Pos of Pluhole middle
usbz = 3.5;  // Z-Pos (height above board) of usb
huy  = 5.5;  // Upper hole Y
hly  = 7.5;  // Lower hole Y
hulx = 7.5;  // Upper left hole X
hllx = 9;    // Lower left hole X
hrx  = 6;    // Right hole X
mr   = 4;    // Mount radius
wdb = 60.3;  // width of display board
wd  = 40;    // width of display
ldb = 98.3;  // length of display board
ld  = 97.3;  // length of display
hld =  8;    // height of highest part on bottom of display-board
hbd =  1.7;  // height (width) of display-board (pcb)
hd  =  2;    // height of highest part on top of display-board
d   = 0.5;   // A small delta for fitting parts
m3r = 9/2;   // Enough space for an m3 nut hole
hdh = 2.5;   // hole distance of screw-hole of display (x+y all holes)
rot = 3.7;   // hole for rotary encoder
dx   = hllx+mr+m3r/2; // Display pos from left (right on upside-down top-module)
ro   = ri + t;
wdif = (wdb-w) / 2;

module bottom
    ( l=l, w=w, wdb=wdb, hl=hl, hb=hb, h=h, t=t, wdif=wdif
    , ri=ri, ro=ro
    , huy=huy, hly=hly, hulx=hulx, hllx=hllx, hrx=hrx, mr=mr
    , pd=pd, ph=ph, pdet=pdet, pdut=pdut
    , wusb=wusb, husb=husb, usbx=usbx, usbz=usbz
    )
{
    echo ("h-bottom:", hl+hb+h+t);
    difference () {
        union () {
            difference () {
                translate ([t, t, 0]) {
                    render () hull () {
                        for (x = [0, l]) {
                            for (y = [0, wdb]) {
                                translate ([x, y, ro])
                                    sphere (ro);
                                translate ([x, y, ro])
                                    cylinder (r=ro, h=t+hl+hb+h - ro);
                            }
                        }
                    }
                }
                translate ([t, t, t]) {
                    render () hull () {
                        for (x = [0, l]) {
                            for (y = [wdif, wdif+w]) {
                                translate ([x, y, ri])
                                    sphere (ri);
                                translate ([x, y, ri])
                                    cylinder (r=ri, h=2*h);
                            }
                        }
                    }
                }
            }
            // mounting
            translate ([t, t, t]) {
                for (xy = [ [0, wdif+w,  hulx, -huy]
                          , [l, wdif+w, -hrx,  -huy]
                          , [0, 0,       hllx,  hly]
                          , [l, 0,      -hrx,   hly]
                          ])
                {
                    translate ([xy [0] + xy [2], xy [1] + xy [3], -e])
                        cylinder (r=mr, h=hl);
                    translate ( [ ( xy [0] + xy [2]
                                  - ( sgn (xy [2])
                                    * ((abs (xy [2]) + mr) / 2 - mr)
                                    )
                                  - sgn (xy [2]) * ri / 2
                                  )
                                , xy [1] + xy [3] / 2 - sgn (xy [3]) * ri / 2
                                , hl/2-e
                                ]
                              )
                        cube ( [abs (xy [2])+mr+ri, abs (xy [3])+ri, hl]
                             , center=true
                             );
                    translate ( [ xy [0] + xy [2] / 2 - sgn (xy [2]) * ri / 2
                                , ( xy [1] + xy [3]
                                  - ( sgn (xy [3])
                                    * ((abs (xy [3]) + mr) / 2 - mr)
                                    )
                                  - sgn (xy [3]) * ri / 2
                                  )
                                , hl/2-e
                                ]
                              )
                        cube ( [abs (xy [2])+ri, abs (xy [3])+mr+ri, hl]
                             , center=true
                             );
                }
            }
        }
        // Screws
        translate ([t, t, 0]) {
            for (xy = [ [0, wdif+w,  hulx, -huy]
                      , [l, wdif+w, -hrx,  -huy]
                      , [0, 0,       hllx,  hly]
                      , [l, 0,      -hrx,   hly]
                      ])
            {
                translate ([xy [0] + xy [2], xy [1] + xy [3], -e]) {
                    cylinder (r=m3 [screw_channel]/2, h=hl+t+h);
                    nut_hole (m3, m3 [nut_height]);
                }
            }
        }
        // Connectors DET, DUT
        for (y = [t + pdet, t + wdif + w - pdut]) {
            translate ([l, y, t + hl + hb + ph])
                rotate ([0, 90, 0])
                    cylinder (r=pd/2, h=3*t);
        }
        // USB w. support material
        // that would be the full-width hole:
        //translate ([t + usbx, t, husb / 2 + t + hl + hb + usbz])
        //    cube ([wusb, 3 * t, husb], center = true);
        translate ([t + usbx, t, husb / 2 + t + hl + hb + usbz])
            cube ([wusb/3-.8, 5 * t, husb], center = true);
        translate ([t + usbx + wusb/3, t, husb / 2 + t + hl + hb + usbz])
            cube ([wusb/3, 5 * t, husb], center = true);
        translate ([t + usbx - wusb/3, t, husb / 2 + t + hl + hb + usbz])
            cube ([wusb/3, 5 * t, husb], center = true);
    }
}

module top
    ( l=l, wdb=wdb, hld=hld, hbd=hbd, hd=hd, t=t, wdif=wdif, h=h
    , ri=ri, ro=ro
    )
{
    htop   = t+hld+hbd+hd;
    hmount = hld+hbd+hd+h;
    echo ("h-top:", htop);
    difference () {
        union () {
            difference () {
                translate ([t, t, 0]) {
                    render () hull () {
                        for (x = [0, l]) {
                            for (y = [0, wdb]) {
                                translate ([x, y, ro])
                                    sphere (ro);
                                translate ([x, y, ro])
                                    cylinder (r=ro, h=htop - ro);
                            }
                        }
                    }
                }
                translate ([t, t, t]) {
                    render () hull () {
                        for (x = [0, l]) {
                            for (y = [0, wdb]) {
                                translate ([x, y, ri])
                                    sphere (ri);
                                translate ([x, y, ri])
                                    cylinder (r=ri, h=3*h);
                            }
                        }
                    }
                }
            }
            // mounting
            translate ([t, t, t]) {
                for (xy = [ [0, wdb,  hrx,  -huy-wdif]
                          , [l, wdb, -hulx, -huy-wdif]
                          , [0, 0,    hrx,   hly]
                          , [l, 0,   -hllx,  hly]
                          ])
                {
                    translate ([xy [0] + xy [2], xy [1] + xy [3], -e])
                        cylinder (r=mr, h=hmount);
                    translate ( [ ( xy [0] + xy [2]
                                  - ( sgn (xy [2])
                                    * ((abs (xy [2]) + mr) / 2 - mr)
                                    )
                                  - sgn (xy [2]) * ri / 2
                                  )
                                , xy [1] + xy [3] / 2 - sgn (xy [3]) * ri / 2
                                , hmount/2-e
                                ]
                              )
                        cube ( [abs (xy [2])+mr+ri, abs (xy [3])+ri, hmount]
                             , center=true
                             );
                    translate ( [ xy [0] + xy [2] / 2 - sgn (xy [2]) * ri / 2
                                , ( xy [1] + xy [3]
                                  - ( sgn (xy [3])
                                    * ((abs (xy [3]) + mr) / 2 - mr)
                                    )
                                  - sgn (xy [3]) * ri / 2
                                  )
                                , hmount/2-e
                                ]
                              )
                        cube ( [abs (xy [2])+ri, abs (xy [3])+mr+ri, hmount]
                             , center=true
                             );
                }
            }
            // mounting display
            translate ([t+l-ldb-dx, t, t]) {
                for (x = [hdh, ldb-hdh]) {
                    for (y = [hdh, wdb-hdh]) {
                        translate ([x, y, 0])
                            cylinder (r=m3r, h=hd);
                        translate ([x, y+(y>hdh?1:-1)*m3r/2, hd/2])
                            cube ([2*m3r, m3r, hd], center=true);
                    }
                }
                for (y = [hdh, wdb-hdh]) {
                    translate ([ldb-hdh+m3r/2, y+(y>hdh?1:-1)*m3r/2, hd/2])
                        cube ([2*m3r, m3r, hd], center=true);
                }
            }
        }
        // Screws
        translate ([t, t, 0]) {
            for (xy = [ [0, wdif+w,  hrx,  -huy]
                      , [l, wdif+w, -hulx, -huy]
                      , [0, 0,       hrx,   hly]
                      , [l, 0,      -hllx,  hly]
                      ])
            {
                translate ([xy [0] + xy [2], xy [1] + xy [3], -e]) {
                    cylinder (r=m3 [screw_channel]/2, h=2*hmount);
                    cylinder ( r=m3 [screw_head_channel]/2
                             , h=m3[screw_head_height]
                             );
                }
            }
        }
        // round corners for mounting
        translate ([0, 0, htop]) {
            difference () {
                cube ([l+2*t, wdb+2*t, 2*h]);
                translate ([t, t, 0]) {
                    render () hull () {
                        for (x = [d, l-d]) {
                            for (y = [wdif+d, wdif+w-d]) {
                                translate ([x, y, -e])
                                    cylinder (r=ri, h=3*h);
                            }
                        }
                    }
                }
            }
        }
        // hole for display
        translate ([t+l-ld-dx, t+(wdb-wd)/2, -t])
            cube ([ld, wd, 3*t]);
        // Holes for display screws
        translate ([t+l-ldb-dx, t, 0]) {
            for (x = [hdh, ldb-hdh]) {
                for (y = [hdh, wdb-hdh]) {
                    translate ([x, y, 0]) {
                        translate ([0, 0, -hd])
                            cylinder (r=m3 [screw_channel]/2, h=7*hd);
                        cylinder ( r=m3 [screw_head_channel]/2
                                 , h=m3[screw_head_height]
                                 );
                    }
                }
            }
        }
        // Hole for rotary encoder
        // In middle of remaining space right of display
        translate ([t+(l-ldb-dx)/2, wdb/2, -t])
            cylinder (r=rot, h=3*t);
    }
}

top    ($fa=3, $fs=0.5);
//translate ([l + 3*t + ro, 0, 0])
translate ([0, wdb+3*3+ro, 0])
    bottom ($fa=3, $fs=0.5);
