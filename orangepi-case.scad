include <nuts.scad>

e   = 0.01; // Epsilon
E   = 0.1;  // big Epsilon :-)
// Length and Width include space for rounded corners
// Note that the case is designed to flush the pcb with the
// ethernet-side wall
// Board itself is quadratic but we need to leave space for SD
l = 54;     // length of board including connectors + 3mm (+1mm at SD-Card)
w = 48;     // width of board + 2mm (no connectors on sides)
// Overall height of box is t + hl + hb + ha + h
hl  =  2.2;   // height of highest part on bottom of board
hb  =  1.75;  // height (width) of board (pcb)
ha  =  1;     // additional height above nut (below pcb at floor)
h   = 35;     // height including expansion board
t   =  2.5;   // thickness of walls of box
hu  = t + ha + hb + hl;
ri  =  1.5;   // Radius of inner rounding
ro  = ri + t; // outer rounding
// All measures from left or right include the 1mm space at wall
eur =  6.5;   // Ethernet/USB block from right
eul = 15.5;   // Ethernet/USB block from left
eh  = 15.5;   // Ethernet/USB height
ed  = 15;     // Ethernet depth
h1x =  3;     // From ethernet side
h2x = 45.5;   // From ethernet side
hy  =  4;     // From either side all 4 holes (incl 1mm spacing to wall)
sc  =  m3 [screw_channel];  // Screw dia
rz  =  m3 [screw_head_channel] / 2;
rv  =  m3 [nut_diameter_low]; // additional reinforcement for nuts
cw  =  6;     // Width of cylinder around screw
uop = 11;     // USB-OTG from right (center)
uoy =  1.5;   // Y-pos of USB-OTG (center)
uow = 12;     // Width of USB-OTG Plug
uoh =  8;     // Height of USB-OTG Plug
oh  =  3;     // Height of OTG
ubd = 11;     // Distance to upper board
ubw =  2;     // width of holder of upper board
pp  = 17.5;   // HeadPhone pos (center) from right
ph  = 15.25;  // HeadPhone height (center)
pd  = 10.5;   // Diameter of HeadPhone Jack
upx = 32;     // Upper USB Pos (center)
upz = 21.5;   // Upper USB height (center)
uph = 17;     // Height of upper USB with connectors
upw = 16;     // Width of upper USB (connector)

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
                                    cylinder (r=ro, h=hu+eh - ro + e);
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
                        difference () {
                            cylinder (h=ha+e, r=rv);
                            // Prevent overshoot
                            if (x < h2x) {
                                translate ([-rv-E, 0, 0])
                                    cube ([rv, 2*rv, 3*ha], center=true);
                            }
                        }
                        // Cylinder around screw
                        cylinder (h=hl+ha+e, r=cw/2);
                    }
                }
                for (y = [hy/2, w-hy/2]) {
                    translate ([x+t, y+t, t-e+(hl+ha+e)/2])
                        cube ([cw, hy+e, hl+ha+e], center=true);
                }
            }
	    for (y = [(hy+cw/2)/2, w-((hy+cw/2)/2)]) {
		translate ([t+h1x/2, y+t, t-e+(hl+ha+e)/2])
		    cube ([h1x, hy+cw/2, hl+ha+e], center=true);
		translate ([-(l-h2x)/2+l+t, y+t, t-e+(hl+ha+e)/2])
		    cube ([l-h2x, hy+cw/2, hl+ha+e], center=true);
	    }
            // Holder for upper board, we make it same width as upper USB
	    translate ([l+t-(ubw+(l-w))/2+e, t+upx, ubd/2+hu]) {
		difference () {
		    cube ([ubw + (l-w), upw, ubd], center=true);
                    rotate([0, -atan((ubw+(l-w))/ubd), 0])
			translate ([-(ubw+l-w)/2, 0, 0])
			    cube ([ubw + (l-w), 3*upw, 3*ubd], center=true);
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
        // USB OTG (power supply)
        translate ([l+3*t-E, uop+t, t+hl+hb+ha+uoy])
            cube ([4*t, uow, uoh], center = true);
        // HeadPhone
        translate ([l+E, pp+t, hu+ph])
            rotate ([0, 90, 0])
                cylinder (h=2*t, r=pd/2);
        // Upper USB
        translate ([l+3*t-E, upx+t, hu+upz])
            cube ([4*t, upw, uph], center = true);
    }
    // support material for USB OTG
    for (y = [-uow/4, 0, uow/4]) {
        translate ([t+l+t/2, uop+t+y, t+hl+hb+ha+uoy-(uoh+2*E)/2])
            cylinder (r=t/2, h=uoh+2*E);
    }
}

module top ()
{
    union () {
        difference () {
            union () {
                difference () {
                    render () hull () {
                        for (x = [ro, l+2*t-ro]) {
                            for (y = [ro, w+2*t-ro]) {
                                translate ([x, y, ro]) {
                                    sphere (ro);
                                    cylinder (r = ro, h = h-eh-ro);
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
			    difference () {
				cylinder (h=ha+e, r=rv);
				// Prevent overshoot
				if (x < h2x) {
				    translate ([-rv-E, 0, 0])
					cube ([rv, 2*rv, 3*ha], center=true);
				}
			    }
                            // Cylinder around screw
                            cylinder (h=h-t+e, r=cw/2);
                        }
                    }
                    for (y = [hy/2, w-hy/2]) {
                        translate ([x+t, y+t, t-e+(h-t+e)/2])
                            cube ([cw, hy+e, h-t+e], center=true);
                    }
                }
		for (y = [(hy+cw/2)/2, w-((hy+cw/2)/2)]) {
		    translate ([t+h1x/2, y+t, t-e+(h-t+e)/2])
			cube ([h1x, hy+cw/2, h-t+e], center=true);
		    translate ([-(l-h2x)/2+l+t, y+t, t-e+(h-t+e)/2])
			cube ([l-h2x, hy+cw/2, h-t+e], center=true);
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
            // HeadPhone
            translate ([l+E, w-pp+t, h-ph])
                rotate ([0, 90, 0])
                    cylinder (h=2*t, r=pd/2);
	    // Upper USB
	    translate ([l+3*t-E, w-upx+t, h-upz])
		cube ([4*t, upw, uph], center = true);
	    // Rounded corners for screw channels
            difference () {
		translate ([-l, -l, h-eh])
		    cube (3*l);
		translate ([t, t, t]) {
		    render () hull () {
			for (x = [ri, l-ri]) {
			    for (y = [ri, w-ri]) {
				translate ([x, y, 0]) {
				    cylinder (r=ri-E, h=2*h);
				}
			    }
			}
		    }
		}
	    }
	}
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
