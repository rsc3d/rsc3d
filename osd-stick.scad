include <nuts.scad>;

e=0.0001;

//
// main board:
// length:
mb_l = 35;
mb_w = 24;
mb_h =  1.8;

// serial board:
// Length including soldering points to main board
sb_l = 41;
sb_w = 17.1;

// usb
usb_w = 12.1;
usb_h =  4.5;

// height from lower edge of main board to upper edge of usb:
upper_h = 8.0;
// height of chip over mainboard
lower_h = 3.0;
// height of usb above serial board
sb_usb_h = 3.3;
// height of serial board above main board
sb_mb_h = 2.9;
// now we should have upper_h == sb_usb_h + sb_mb_h + mb_h
// height of chip over mainboard
mb_ch_h = 3;

// distance from mainboard egde to usb, usb facing to us
mb_usb_l = 6.3;
mb_usb_r = 5.8;
// now we should have mb_usb_r + mb_usb_l + usb_w == mb_w :-)

// distance from mainboard edge to edge of serial board
mb_sb_l = 4.0;
mb_sb_r = 2.9;
// now we should have mb_sb_r + mb_sb_l + sb_w == mb_w :-)

// Space for serial connectors
scs = 12;

// Soldering point on mainboard for capacitor (reset)
sp_d = 5.5;
sp_w = 4;

// Soldering space on top of mainboard on both sides
mb_sol = 3;

// Antenna from edge of mainboard
ant_d = 3.5;
ant_r = 1.5/2;

// feature width
fw = 3;

// Additional space to make room for screws
sw = 2;

// Additional space to fit
s = .4;

m3r  = m3 [screw_channel] / 2;
m3hr = m3 [screw_head_channel] / 2;
m3hh = m3 [screw_head_height];

module lower_part
    ( mb_l=mb_l, mb_w=24
    , sb_l=sb_l, sb_w=sb_w
    , usb_w=usb_w, usb_h=usb_h
    , mb_usb_l=mb_usb_l, mb_usb_r=mb_usb_r
    , mb_sb_l=mb_sb_l, mb_sb_r=mb_sb_r
    , upper_h=upper_h, lower_h=lower_h
    , sb_usb_h=sb_usb_h
    , sp_d=sp_d, sp_w=sp_w
    , ant_d=ant_d, ant_r=ant_r
    , fw=fw
    , s=s
    )
{
    difference () {
        minkowski () {
            translate ([sw/4, 0 , 0]) {
                cube ([sb_l + sw/2, mb_w + sw, lower_h], center = true);
                // Same cube again translated to make room for screw
                translate ([0, m3r, 0])
                    cube ([sb_l + sw/2, mb_w + sw, lower_h], center = true);
            }
            sphere (r = fw + s, $fs=1);
        }
        // flat surface
        translate ([0, 0, sb_l + lower_h / 2])
            cube (sb_l * 2, center = true);
        // hole for chip and other parts on mainboard
        // we leave out only the soldering space on sides
        translate ([(mb_l + s)/2 - (sb_l + s)/2, 0, 3/2*lower_h - mb_ch_h - s])
            cube ([mb_l + s, mb_w+s - 2*mb_sol, 2*lower_h], center = true);
        // Space for soldering point on mainboard
        translate ([-sp_w - (sb_l + s)/2 + (mb_l + s) - sp_d, -(mb_w+s)/2, 0])
            cube ([sp_w, (mb_w + s)/2, 2*lower_h]);
        // screw holes
        translate ([sb_l / 2 - m3r,  mb_w / 2 - m3r + m3r, -e]) {
            cylinder (r = m3r, h = 4*lower_h, center = true, $fa=3, $fs=.5);
            translate ([0, 0, -(lower_h/2 + fw + s)])
                nut_hole (m3, m3 [nut_height]);
        }
        translate ([sb_l / 2 - m3r, -mb_w / 2 + m3r, -e]) {
            cylinder (r = m3r, h = 4*lower_h, center = true, $fa=3, $fs=.5);
            translate ([0, 0, -(lower_h/2 + fw + s)])
                nut_hole (m3, m3 [nut_height]);
        }
        // Antenna hole
        translate ([- (sb_l + s)/2 + mb_l - ant_d, 0, 0])
            cylinder (r=ant_r, h=4*lower_h, center=true, $fa=3, $fs=.5);
        // hole for fitting piece from lower part
        translate ([-(fw+s)/4 - (sb_l+s)/2, m3r/2, 0])
            cube ([(fw+s)/2+s, mb_w+sw+m3r+s, lower_h+s], center=true);
    }
    // Fit into USB-hole of other part
    translate ([-(fw+s/2+sw/2)/2+(sb_l)/2+fw+s+sw/2
               , mb_usb_l - mb_usb_r
               , (upper_h-usb_h)/2 + lower_h/2 - s
               ])
        cube ([fw+s/2+sw/2, usb_w, upper_h-usb_h], center=true);
}

module upper_part
    ( mb_l=mb_l, mb_w=24
    , sb_l=sb_l, sb_w=sb_w
    , usb_w=usb_w, usb_h=usb_h
    , mb_usb_l=mb_usb_l, mb_usb_r=mb_usb_r
    , mb_sb_l=mb_sb_l, mb_sb_r=mb_sb_r
    , upper_h=upper_h, lower_h=lower_h
    , sb_usb_h=sb_usb_h
    , sp_d=sp_d, sp_w=sp_w
    , scs=scs
    , fw=fw
    , s=s
    )
{
    difference () {
        minkowski () {
            translate ([sw/4, 0 , 0]) {
                cube ([sb_l + sw/2, mb_w + sw, upper_h], center = true);
                // Same cube again translated to make room for screw
                translate ([0, -m3r, 0])
                    cube ([sb_l + sw/2, mb_w + sw, upper_h], center = true);
            }
            sphere (r = fw + s, $fs=1);
            //cube (2*(fw+s), center=true);
        }
        // USB hole
        translate ([fw - s/2, mb_usb_r - mb_usb_l, upper_h/2])
            cube ([sb_l + 2 * fw, usb_w+s, 2*upper_h], center = true);
        // hole for serial board
        translate ([0, mb_sb_r - mb_sb_l, upper_h/2 + sb_usb_h - s/2])
            cube ([sb_l + s, sb_w+s, 2*upper_h], center = true);
        // hole for main board
        translate ([(mb_l + s)/2 - (sb_l + s)/2, 0, 3/2*upper_h - mb_h - s/2])
            cube ([mb_l + s, mb_w+s, 2*upper_h], center = true);
        // flat surface
        translate ([0, 0, sb_l + upper_h / 2])
            cube (sb_l * 2, center = true);
        // Space for serial connectors
        translate ([scs/2 - (sb_l+s)/2, mb_sb_r - mb_sb_l, upper_h/2])
            cube ([scs, sb_w+s, 2*upper_h], center = true);
        // Same space as for serial connectors on other side
        // for soldering points of usb-connector and a resistor
        translate ([-scs/2 + (sb_l+s)/2, mb_sb_r - mb_sb_l, upper_h/2])
            cube ([scs, sb_w+s, 2*upper_h], center = true);
        // Space for soldering point on mainboard
        translate ([-sp_w - (sb_l + s)/2 + (mb_l + s) - sp_d, 0, 0])
            cube ([sp_w, (mb_w + s)/2, 2*upper_h]);
        // screw holes
        translate ([sb_l / 2 - m3r,  mb_w / 2 - m3r, -e]) {
            cylinder (r = m3r,  h = 2*upper_h, center = true, $fa=3, $fs=.5);
            translate ([0, 0, -(upper_h/2 + fw + s)])
                cylinder (r = m3hr, h = m3hh, $fa=3, $fs=.5);
        }
        translate ([sb_l / 2 - m3r, -mb_w / 2 + m3r - m3r, -e]) {
            cylinder (r = m3r, h = 2*upper_h, center = true, $fa=3, $fs=.5);
            translate ([0, 0, -(upper_h/2 + fw + s)])
                cylinder (r = m3hr, h = m3hh, $fa=3, $fs=.5);
        }
    }
    translate ([-(fw+s)/4 - (sb_l+s)/2, -m3r/2, (lower_h+upper_h)/2-e])
        cube ([(fw+s)/2, mb_w+sw+m3r, lower_h], center=true);
}

show_mount = 0;

if (show_mount) {
    upper_part ();
    translate ([0, 0, upper_h + lower_h])
        rotate ([180, 0, 0])
            lower_part ();
} else {
    translate ([0, 0, upper_h/2 + fw + s])
        upper_part ();
    translate ([0, 2*mb_w + 2*fw + 2*s, lower_h/2 + fw + s])
        lower_part ();
}
