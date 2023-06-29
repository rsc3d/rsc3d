// Mount for photo resitor for chicken door

eps = 0.01;

module mount (r1 = 5, r2 = 2.5, h1 = 3, h2 = 8, rm = 3.5, r3 = 0.4)
{
    difference () {
        union () {
            cylinder (r = r1, h = h1);
            translate ([0, 0, h2 / 2])
                cube ([r2 * 2, r2 * 2, h2], center = true);
        }
        translate ([ r2 * 5/4, 0, h1])
            cylinder (r = r2, h = h2 + eps);
        translate ([-r2 * 5/4, 0, h1])
            cylinder (r = r2, h = h2 + eps);
        translate ([ rm / 2, 0, -eps])
            cylinder (r = r3, h = h1 + 2*eps);
        translate ([-rm / 2, 0, -eps])
            cylinder (r = r3, h = h1 + 2*eps);
    }
}

mount ($fa = 1, $fs = 0.05);
