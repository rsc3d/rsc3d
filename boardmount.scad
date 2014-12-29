// Board mount (Regalbretthalter)
$fn = 100;

module mount (inner_dia, outer_dia, small_dia, h1, h2, dif)
{
    sr = small_dia / 2;
    ir = inner_dia / 2;
    c  = 2 * (h1 + h2);
    s  = (outer_dia / 2) - (outer_dia - dif);
    difference () {
        union () {
            cylinder (r = ir, h = h1 + h2 / 2);
            translate ([0, 0, h1])
                cylinder (r1 = outer_dia / 2, r2 = sr, h = h2 - sr);
            translate ([0, 0, h1 + h2 - sr]) sphere (r = sr);
        }
        translate ([c / 2 + s, 0, c / 4])
            cube (c, center = true);
    }
    // Support material
    translate ([s / 2, 0, (h1 + 1) / 2])
        cube ([s, 1, h1 + 1], center = true);

    // Support material to fixate thin support above
    translate ([0, 0, -ir + 0.01])
    {
        translate ([(s - ir) / 2 + ir, 0, 0])
            cube ([s - ir, inner_dia, inner_dia], center = true);
    }
}

rotate ([0, 90, 0])
    mount (5, 15, 10.5, 12, 16, 12);
