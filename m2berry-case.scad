include <nuts.scad>

e   = 0.01; // Epsilon
E   = 0.1;  // big Epsilon :-)
// Length and Width include space for rounded corners
// Note that the case is designed to flush the pcb with the
// ethernet-side wall
l   = 90;     // length of board including connectors + 2mm
w   = 58;     // width of board (excl conn) + 2mm
// Overall height of box is t + hl + hb + ha + h
// Should add up to max 22.8 (m3 screw 25mm)
hl  =  2;     // height of highest part on bottom of board
hb  =  1.1;   // height (width) of board (pcb)
ha  =  1;     // additional height above nut (below pcb at floor)
h   = 18.5;   // height of highest part on top of board (USB)
t   =  2.5;   // thickness of walls of box
hu  = t + ha + hb + hl;
ri  =  1.5;   // Radius of inner rounding
ro  = ri + t; // outer rounding
// All measures from left or right include the 1mm space at wall
eur =  2.5;   // Ethernet/USB block from right
eul =  3.5;   // Ethernet/USB block from left
eh  = 13.5;   // Height of Ethernet
ed  = 20;     // Ethernet Depth
uw  = 33;     // Width of two USB
h1x = 24;     // From ethernet side
h2x = 81.5;   // From ethernet side
hy  =  4.5;   // From either side all 4 holes (incl 1mm spacing to wall)
sc  =  m3 [screw_channel];  // Screw dia (hole on board is 2.5, needs widening)
rz  =  m3 [screw_head_channel] / 2;
rv  =  m3 [nut_diameter_low]; // additional reinforcement for nuts
cw  =  6;     // Width of cylinder around screw
pp  = 32;     // HeadPhone from end
ph  =  3;     // HeadPhone height (center)
pd  = 10.5;   // Diameter of HeadPhone Jack
hp  = 46;     // Position of HDMI
hh  =  6;     // Height of HDMI above PCB
hw  = 15;     // Width of HDMI
hd  = 13;     // Depth of HDMI
hcw = 20;     // Width of HDMI Connector
hdx = hp + hw / 2;
hdy = hh / 2;
hch = 13;     // Height of HDMI Connector
rp  = 66;     // Position of Reset Button
rh  =  2.5;   // Height of Reset Button (center)
rhh =  4.5;   // Height of Reset Button upper corner
rd  =  2;     // Diameter of Reset Button
uop = 74.5;   // Position of USB-OTG (center)
uoy =  1.5;   // Y-pos of USB-OTG (center)
uow = 12;     // Width of USB-OTG Plug
uoh =  8;     // Height of USB-OTG Plug
oh  =  3;     // Height of OTG

echo (t + hl + hb + ha + h);
module bottom ()
{
    difference () {
        union () {
            difference () {
                render () hull () {
                    for (x = [ro, l+2*t-ro]) {
                        for (y = [ro, w+2*t-ro]) {
                            translate ([x, y, ro]) {
                                difference () {
                                    sphere (ro);
                                    translate ([0, 0, 2*ro])
                                        cube (4*ro, center=true);
                                }
                                translate ([0, 0, -e])
                                    cylinder (r=ro, h=t+hl+hb+ha - ro + e);
                            }
                        }
                    }
                }
                translate ([t, t, t]) {
                    render () hull () {
                        for (x = [ri, l-ri]) {
                            for (y = [ri, w-ri]) {
                                translate ([x, y, ri]) {
                                    sphere (ri);
                                    cylinder (r=ri, h=2*h);
                                }
                            }
                        }
                    }
                }
            }
            // For screws
            for (x = [h1x, h2x]) {
                for (y = [hy, w-hy]) {
                    translate ([x+t, y+t, t-e]) {
                        // Additional reinforcement for nuts
                        cylinder (h=ha+e, r=rv);
                        // Cylinder around screw
                        cylinder (h=hl+ha+e, r=cw/2);
                    }
                }
                for (y = [hy/2, w-hy/2]) {
                    translate ([x+t, y+t, t-e+(hl+ha+e)/2])
                        cube ([cw, hy+e, hl+ha+e], center=true);
                }
            }
        }
        // Ethernet and USB
        translate ([-t, eur+t, hu])
            cube ([8*t, w-(eul+eur), 2*h]);
        // Screw holes with nuts at bottom
        for (x = [h1x, h2x]) {
            for (y = [hy, w-hy]) {
                translate ([x+t, y+t, -e]) {
                    rotate ([0, 0, 90])
                        nut_hole (m3, m3 [nut_height]);
                    cylinder (h=7*t, r=sc/2);
                }
            }
        }
        // HeadPhone
        translate ([pp+t, 3*t+w-E, t+hl+hb+ha+ph])
            rotate ([90, 0, 0])
                cylinder (h=2*t, r=pd/2);
        // USB OTG (power supply)
        translate ([uop+t, w+3*t-E, t+hl+hb+ha+uoy])
            cube ([uow, 4*t, uoh], center = true);
        // HDMI
        translate ([hdx+t, w, t+hl+hb+ha+hdy])
            cube ([hcw, 5*t, hch], center = true);
    }
}

module top ()
{
    hdmiwall    = (uop + uow / 2) - (hdx - hcw / 2);
    hdmiwallpos = ((uop + uow / 2) + (hdx - hcw / 2)) / 2;
    //hdmiwally   = hdy + (hh / 2) + t;
    hdmiwally   = hdy + (hh / 2) + t;
    otgwally    = uoy + (oh / 2) + t;
    rwally      = rh + (rhh / 2) + t;
    union () {
        difference () {
            union () {
                difference () {
                    render () hull () {
                        for (x = [ro, l+2*t-ro]) {
                            for (y = [ro, w+2*t-ro]) {
                                translate ([x, y, ro]) {
                                    sphere (ro);
                                    cylinder (r=ro, h=h - ro);
                                }
                            }
                        }
                    }
                    translate ([t, t, t]) {
                        render () hull () {
                            for (x = [ri, l-ri]) {
                                for (y = [ri, w-ri]) {
                                    translate ([x, y, ri]) {
                                        sphere (ri);
                                        cylinder (r=ri, h=2*h);
                                    }
                                }
                            }
                        }
                    }
                }
                // For screws
                for (x = [h1x, h2x]) {
                    for (y = [hy, w-hy]) {
                        translate ([x+t, y+t, t-e]) {
                            // Additional reinforcement for screw heads
                            //cylinder (h=ha+e, r=rv);
                            // Cylinder around screw
                            cylinder (h=h-t+e, r=cw/2);
                        }
                    }
                    for (y = [hy/2, w-hy/2]) {
                        translate ([x+t, y+t, t-e+(h-t+e)/2])
                            cube ([cw, hy+e, h-t+e], center=true);
                    }
                }
            }
            // Screw holes with screw head at bottom
            for (x = [h1x, h2x]) {
                for (y = [hy, w-hy]) {
                    translate ([x+t, y+t, -e]) {
                        cylinder (h=2*h, r=sc/2);
                        cylinder (h=m3 [screw_head_height], r=rz);
                    }
                }
            }
            // Reset hole
            translate ([rp+t, 3*t, h-rh])
                rotate ([90, 0, 0])
                    cylinder (h=5*t, r=rd/2);
            // HeadPhone
            translate ([pp+t, t+E, h-ph])
                rotate ([90, 0, 0])
                    cylinder (h=5*t, r=pd/2);
            // USB OTG (power supply)
            translate ([uop+t, -t+E, h - uoy])
                cube ([uow, 4*t, uoh], center = true);
            // HDMI
            translate ([hdx+t, t, h - hdy])
                cube ([hcw, 5*t, hch], center = true);
            // Ethernet, USB
            translate ([-t-e, eul+t, h-eh-E])
                cube ([5*t, w-eur-eul, h]);
            translate ([-t-e, -uw+w+t-eur, t])
                cube ([5*t, uw, h]);
        }
        // Ethernet "wall" above
        translate ([t, t, t-e])
            cube ([ed, w - (uw+eur), h-eh-t-E]);
        // HDMI "wall" above
        translate ([hdmiwallpos+t/2, hd/2+t, t+(h-hdmiwally)/2-e])
            cube ([hdmiwall-t/2, hd, h-hdmiwally+e], center=true);
        translate ([uop+3*t/4, hd/2+t, t+(h-otgwally)/2-e])
            cube ([uow-t/2, hd, h-otgwally+e], center=true);
        translate ([rp+t, hd/2+t, t+(h-rwally)/2-e])
            cube ([hdmiwall-uow-hcw, hd, h-rwally+e], center=true);
    }
}

test = 0;
if (test) {
    bottom ($fa=3, $fs=0.5);
    translate ([0, w + 2*t, h + hl + hb + ha + t + 5*E])
        rotate ([180, 0, 0])
            top ($fa=3, $fs=0.5);
} else {
    bottom ($fa=3, $fs=0.5);
    translate ([0, -w-4*t, 0])
        top ($fa=3, $fs=0.5);
}
