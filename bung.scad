// Bung(s) for legs of a stool

module bung
    (odia = 22.5, idia = 11.5, mdia = 21, h = 4.5, d = 11, w = 3, fw = 1.3)
{
    cylinder (r = odia / 2, h = h);
    difference () {
        union () {
            cylinder (r = idia / 2, h = d + h);
            linear_extrude
                (height = d + h, twist = -90, slices = 40, convexity = 5)
            {
                square ([fw, mdia], center = true);
                square ([mdia, fw], center = true);
            }
        }
        translate ([0, 0, h + 0.01])
            cylinder (r = idia / 2 - w, h = d);
    }
}

for (i = [-1, 0, 1]) {
    translate ([i * 26, 0, 0])
        bung ($fa = 3, $fs = .5);
}
