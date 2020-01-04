include <nuts.scad>

e = 0.01;

module antenna_calibre (dipole_r = 31, wd = 1.5, h = 5, hh = 10.3, nut = m3)
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
        translate ([0, 0, -e])
            countersunk_screw_hole (nut, 3 * h);
    }
}

dipole_r = 31;
for (i=[0, 2 * dipole_r + 3]) {
    translate ([i, 0, 0])
        antenna_calibre (dipole_r = dipole_r, $fa = 2, $fs = .5);
}
