include <nuts.scad>
eps = 0.01;
module motor_mount (d=37, h=6, w1=7, w2=12, l=16)
{
    r   = d / 2 + w1;
    r2  = 2 * r;
    ndh = m3 [nut_diameter_high];
    nh  = m3 [nut_height];
    sc  = m3 [screw_channel];
    difference () {
        union () {
            cylinder (r = r, h = w2);
            translate ([0, -(r + h) / 2, w2/2])
                cube ([r2, r + h, w2], center = true);
            translate ([0, w1/2-r-h, w2/2])
                cube ([r2 + 2*l, w1, w2], center = true);
        }
        translate ([0, 0, -w2])
            cylinder (r = d/2, h = 3*w2);
        translate ([0, -(d + h)/2, w2/2])
            cube ([d, d + h, 3*w2], center = true);

        translate ([d/2 - eps, -ndh, w2/2])
            rotate ([0, 90, 0]) rotate ([0, 0, 90]) {
                nut_hole (m3, nh);
                cylinder (r = sc / 2, h = 3 * w1);
            }
        translate ([-d/2 - nh + eps, -ndh, w2/2])
            rotate ([0, 90, 0]) rotate ([0, 0, 90]) {
                nut_hole (m3, m3 [nut_height]);
                translate ([0, 0, -2*w1])
                    cylinder (r = sc / 2, h = 3 * w1);
            }
        for (i = [-1, 1]) {
            hull () {
                for (x = [sc/2, l-3*sc/2])
                    translate ([i * (r + x), -d/2, w2/2])
                        rotate ([90, 0, 0])
                            cylinder (r = sc / 2, h = 3 * w1);
            }
        }
    }
    // Support
    for (i = [-1, 1]) {
        translate ([i * (r + l/2 - sc/2), -(r+h)+w1/2, w2/2])
            cube ([1, w1, w2], center = true);
    }
}

for (i = [0, 1])
    translate ([i * 60, 0, 0])
        rotate ([0, 0, i*180])
            motor_mount ($fa = 1, $fs = 0.05);
