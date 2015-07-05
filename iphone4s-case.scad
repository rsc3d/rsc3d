use <iphone4S_model.scad>

glass_t   =   1.59;
bevel     =   0.6;

glass_d   =   9.34;

steel_h   = 115.15 + 1;
steel_w   =  58.55;
steel_d   = glass_d - 2 * glass_t;

glass_h   = steel_h - 2 * bevel;
glass_w   = steel_w - 2 * bevel;
corner_r  = 8.77;

// corner radius for small elements
element_r = 1;

// camera
cam_m     = 8.77; // h and v
cam_r     = 7 / 2;

// flash
fl_v_m    = cam_m;
fl_h_m    = 14.91;
fl_r      = 3 / 2;

// sim slot
sim_w     = 69.98 - 52.01 + 0.5;
sim_h     = 5.83 - 3.52 + 0.5;
sim_v     = 52.01;

// jack
jack_h    = 46.51;
jack_r    = 9 / 2;

// connector
cn_h      =  6;
cn_w      = 27;

// top mic
tm_h      = 41.82;
tm_r      = 2 / 2;

// mute switch
mute_t    = 12.53;
mute_w    = 3;
mute_h    = 6.5;

// up/down buttons
u_c       = 25.28;
d_c       = 35.56;
ud_r      = 7 / 2;

// sleep button
sl_a      = 2;
sl_hd     = 19.54 + sl_a / 2;
sl_w      = sl_hd - 9.44 + sl_a / 2;
sl_h      = 5;

// speaker(?)
spkr_w = 7;
spkr_o = 7.29;

module rrect (x, y, h, r)
{
    hull () {
        translate ([-x / 2 + r, -y / 2 + r, 0]) cylinder (r = r, h = h);
        translate ([ x / 2 - r, -y / 2 + r, 0]) cylinder (r = r, h = h);
        translate ([-x / 2 + r,  y / 2 - r, 0]) cylinder (r = r, h = h);
        translate ([ x / 2 - r,  y / 2 - r, 0]) cylinder (r = r, h = h);
    }
}

module case (h, w, d, t1, t2)
{
    difference () {
        rrect (h + 2 * t1, w + 2 * t1, d + 2 * t2, corner_r + t1);
        translate ([0, 0, t2])
            rrect (h, w, d + 2 * t1, corner_r);
        translate ([0, 0, -t2])
            cylinder (r = 20, h = 5);
        // camera
        translate ([-(h / 2 - cam_m), w / 2 - cam_m, -t2])
            cylinder (h = 3 * t2, r = cam_r, $fa = 3, $fs = 0.5);
        // flash
        translate ([-(h / 2 - fl_v_m), w / 2 - fl_h_m, -t2])
            cylinder (h = 3 * t2, r = fl_r, $fa = 3, $fs = 0.5);
        // SIM slot (not rendered, good when sim is hidden)
        // translate ([- (h / 2 - sim_v - sim_w / 2), w / 2 - t1, glass_d / 2])
        //     rotate ([-90, 0, 0])
        //         rrect (sim_w, sim_h, 3 * t1, element_r);
        // jack
        translate ([-(h / 2 + 2 * t1), w / 2 - jack_h, d / 2 + t2])
            rotate ([0, 90, 0])
                cylinder (h = 3 * t1, r = jack_r);
        // top mic
        translate ([-h / 2 - 2 * t1, w / 2 - tm_h, d / 2 + t2])
            rotate ([0, 90, 0])
                cylinder (r = tm_r, h = 3 * t1);
        // Mute slot hole, Up/Down buttons
        hull () {
            translate ([-h/2 + d_c, -w/2 + t1, d/2 + t2])
                rotate ([90, 0, 0])
                    cylinder (r = ud_r, h = 3 * t1);
            translate ([-h/2 + u_c + (u_c - d_c), -w/2 + t1, d/2 + t2])
                rotate ([90, 0, 0])
                    cylinder (r = ud_r, h = 3 * t1);
        }
        // Sleep button
        hull () {
            translate ([-h / 2 - 2 * t1, w/2 - sl_hd + .25 * sl_w, d/2 + t2])
                rotate ([90, 0, 90])
                    cylinder (h = 3 * t1, r = sl_h / 2 * 1.3);
            translate ([-h / 2 - 2 * t1, w/2 - sl_hd + .75 * sl_w, d/2 + t2])
                rotate ([90, 0, 90])
                    cylinder (h = 3 * t1, r = sl_h / 2 * 1.3);
        }
        // connector
        if (0) {
            translate ([h / 2 - t1, 0, d / 2 + t2]) {
                rotate ([0, 90, 0]) hull () {
                    translate ([0, -cn_w / 2 + cn_h / 2, 0])
                        cylinder (r = cn_h / 2, h = 3 * t1);
                    translate ([0,  cn_w / 2 - cn_h / 2, 0])
                        cylinder (r = cn_h / 2, h = 3 * t1);
                }
            }
        }
        // speakers (?) bottom
        hull () {
            translate ([h / 2 - t1,  w / 2 - spkr_w / 2 - spkr_o, d / 2 + t2])
                rotate ([0, 90, 0])
                    cylinder (r = spkr_w / 2, h = 3 * t1);
            translate ([h / 2 - t1, -w / 2 + spkr_w / 2 + spkr_o, d / 2 + t2])
                rotate ([0, 90, 0])
                    cylinder (r = spkr_w / 2, h = 3 * t1);
        }
    }
    // support material for connector
    for (t = [0 : 2.6 : w / 2 - spkr_w / 2 - spkr_o]) {
        translate ([h / 2 + t1 / 2,  t, t2])
            cylinder (r = t1 / 2, h = cn_h * 1.5);
        translate ([h / 2 + t1 / 2, -t, t2])
            cylinder (r = t1 / 2, h = cn_h * 1.5);
    }
    // support material for Sleep button
    for (t = [0 : 2.2 : sl_w / 2]) {
        translate ([-h / 2 - t1 / 2, w / 2 - sl_hd + sl_w / 2 + t, t2])
            cylinder (r = t1 / 2, h = sl_h * 1.8);
        translate ([-h / 2 - t1 / 2, w / 2 - sl_hd + sl_w / 2 - t, t2])
            cylinder (r = t1 / 2, h = sl_h * 1.8);
    }
    // support material for top mic
    translate ([-h / 2 - t1, w / 2 - jack_h + jack_r - 0.1, d / 3 + t2])
        cube ([t1, 0.61, 3 * tm_r]);

    // support material up/down buttons, Mute slot hole
    for (t = [0 : 2.5 : (d_c - u_c)]) {
        translate ([-h/2 + u_c - t, -w/2 - t1 / 2, t2])
            cylinder (r = t1 / 2, h = ud_r * 2.6);
        translate ([-h/2 + u_c + t, -w/2 - t1 / 2, t2])
            cylinder (r = t1 / 2, h = ud_r * 2.6);
    }
}

case (steel_h, steel_w, glass_d, 1.3, 1, $fa = 3, $fs = 0.4);
//translate ([0, 0, 1]) iphone4(true,true,true,true,true);
