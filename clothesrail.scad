include <nuts.scad>;

module rail
    ( d   = 15.6   // diameter of rail
    , t   = 6      // thickness of border around rail
    , h   = 3.2    // height of low part
    , h2  = 12.2   // height of rail border from bottom
    , l1  = 31     // lenght of space for rail
    , l2  = 22.5   // length of rail border
    , h3  = 20     // height of board mount
    , h4  = 10.5   // height of screw in board mount
    , m   = m6     // nut for board mount
    , sr  = 3.6/2  // screw hole radius
    , shr = 6.8/2  // screw head radius
    , shh = 3      // screw head height
    )
{
    e   = 0.01;
    r   = d / 2;
    ll  = l2 - r;
    w   = d + 2 * t;
    s   = sqrt (pow (l1 - h, 2) + pow (h3, 2));
    phi = atan ((h3) / (l1 - h));
    echo (s);
    echo (phi);
    difference () {
        union () {
            translate ([0, -(r + t), 0]) {
                cube ([2 * l1 + ll, w, h]);
                cube ([ll, w, h2]);
            }
            cylinder (r = w / 2, h = h2);
            translate ([2 * l1 + ll -h, -w / 2, 0])
                cube ([h, w, h3]);

            translate ([l1 + ll, -w / 2, 0])
                rotate ([0, 90 - phi, 0])
                    cube ([s, w, s]);
        }
        translate ([0, 0, h])
            cylinder (r = r, h = h2);
        translate ([0, -r, h])
            cube ([2 * ll, d, h2]);

        translate ([2 * l1 + ll, -w , -w])
            cube (2 * w);
        translate ([2 * l1 + ll -1.9 * w, -w , -2 * w])
            cube (2 * w);

        translate ([2 * l1 + ll - h, 0, h4])
            rotate ([30, 0, 0])
                rotate ([0, -90, 0]) {
                    nut_hole (m, 2 * h3);
                    translate ([0, 0, -h3])
                        cylinder (r = m [screw_channel] / 2, h = 3 * h3);
                }

        translate ([0, 0, -h])
            cylinder (r = sr, h = 3 * h);
        translate ([0, 0, h - shh + e])
            cylinder (r1 = sr, r2 = shr, h = shh);

        for (x = [-1, 1]) {
            translate ([l1 + ll + 2.8 * shr, x * (w / 2 - shr - 1), 0]) {
                translate ([0, 0, -h])
                    cylinder (r = sr, h = 3 * h);
                translate ([0, 0, h])
                    cylinder (r = shr, h = 8 * h);
                translate ([0, 0, h - shh + e])
                    cylinder (r1 = sr, r2 = shr, h = shh);
            }
        }
    }
}

translate ([0, 20, 0])
    rail ($fa=3, $fs=.5);
translate ([0, -20, 0])
    rail ($fa=3, $fs=.5);
