
// Cable tube holder (bracket)
$fn = 100;

module hole (hr, hh, s)
{
    translate ([ s / 2, 0 , 0]) cylinder (r = hr, h = hh);
    translate ([-s / 2, 0 , 0]) cylinder (r = hr, h = hh);
    translate ([0, 0, hh / 2]) cube ([s, 2 * hr, hh], center = true);
}

module recess (l, h)
{
    translate ([0, l / 2, 0]) {
        translate ([-l / 2, 0, 0]) cube ([l, l, h], center = true);
        translate ([0, 0,  h / 2])
            rotate ([0,  45, 0]) translate ([-l / 2,  0, -h / 2])
                cube ([l, l, h], center = true);
        translate ([0, 0, -h / 2])
            rotate ([0, -45, 0]) translate ([-l / 2,  0,  h / 2])
                cube ([l, l, h], center = true);
    }
}

module holder (dia, screw, l, w, h)
{
    r  = dia / 2;
    rk = 10 * r;
    ri = screw / 2;
    ro = ri * 5 / 3;
    sh = rk - l / 2;
    e  = 0.01;
    hd = w * 0.55;
    difference () {
        union () {
            // base
            translate ([ 0, -1.5 * w / 2 - r + 0.5 * w, 0])
                cube ([l, 1.5 * w, h], center = true);
            // rounded bracket
            intersection () {
                translate ([ sh, -r, 0])
                    cylinder (r = rk, h = h, center = true);
                translate ([-sh, -r, 0])
                    cylinder (r = rk, h = h, center = true);
            }
        }
        translate ([0, sqrt (2) * l / 2, 0])
        {
            rotate ([0, 0, 30])
                cube (l, center = true);
            rotate ([0, 0, 60])
                cube (l, center = true);
        }
        // Screw hole
        rotate ([-90, 0, 0])
        {
            translate ([0, 0, -(r + w + 1)])
                hole (ri, hd + 1, ri);
            translate ([0, 0, -(r + w + 1) + hd])
                hole (ro, 3 * hd, ri);
        }
        // Cylinder for tube
        cylinder (r = r, h = 2 * h, center = true);
        // Remove upper and lower parts of rounded bracket
        translate ([0, -rk / 2 - r - w, 0])
            cube (rk, center = true);
        translate ([0,  rk / 2 + r + w, 0])
            cube (rk, center = true);
        // Add recess, destroys rounded bracket :-(
        if (0) {
            translate ([-l / 2 + 1, -r, 0])
                rotate ([0, 0, -10])
                    recess (4 * r, h - 4);
            translate ([ l / 2 - 1, -r, 0])
                rotate ([0, 0, 10])
                    rotate ([0, 180, 0]) recess (4 * r, h - 4);
        }
    }
    // Support for screw hole
    translate ([ ri / 2, -w / 2 - r, 0])
        cube ([0.8, w, h], center = true);
    translate ([-ri / 2, -w / 2 - r, 0])
        cube ([0.8, w, h], center = true);
}

translate ([-17 + 0.001, 0, 0])
    holder (24.5, 5, 34, 13, 12);
translate ([ 17 - 0.001, 0, 0])
    holder (24.5, 5, 34, 13, 12);
