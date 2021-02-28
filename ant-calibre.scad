include <nuts.scad>

e = 0.01;

// Dipole radius for the best antenna optimized with old algorithm:
// We call it after the random-seed used "number 26".
// For the balcony-antenna with seed 11 use:
// -Ddipole_r=40.8 when calling openscad with this model.

dipole_r = 36.4;
wd       =  1.5;
h        =  4;
hh       =  wd + .5;
// This uses a hole for the head of a screw by default.
// If you set this to true with -Duse_nut=true you get a nut-hole
// instead which might make for easier mounting depending on your build
// process.
use_nut  = false;

module antenna_calibre (dipole_r = dipole_r, wd = wd, h = h, hh = hh, nut = m3)
{
    dia = 2 * dipole_r;
    ro  = (dia - wd) / 2;
    wr  = wd / 2;
    xh  = hh - wd;
    difference () {
        union () {
            cylinder (r = ro, h = h + xh);
            translate ([0, 0, h - wd]) {
                for (x = [0 : 0.1 : wr]) {
                    cylinder (r = ro + wr - sqrt (2*wr*x - x*x), h = x + 0.05);
                }
            }
            cylinder (r = ro + wr, h = h - wd);
        }
        if (use_nut) {
            translate ([0, 0, -e]) {
                cylinder (r = nut [screw_channel] / 2, h = 3 * h);
                nut_hole (nut, nut [nut_height] * .75);
            }
        } else {
            translate ([0, 0, -e])
                countersunk_screw_hole (nut, 3 * h);
        }
    }
}

for (i=[0, 2 * dipole_r + 3]) {
    translate ([i, 0, 0])
        antenna_calibre ($fa = 2, $fs = .5);
}
