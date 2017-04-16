module grip (dia = 100, w = 2, gw = 10)
{
    g = gw / sqrt (2);
    difference () {
        rotate ([45, 0, 0])
            cube ([dia - 2 * w, g, g], center = true);
        translate ([0, 0, g])
            cube ([dia, 2*g, 2*g], center = true);
    }
}

module stopper (dia = 100, ovh = 2, w = 2, h = 10, gw = 10)
{
    r = dia / 2;
    difference () {
        union () {
            cylinder (r1 = r - ovh, r2 = r, h = 2 * w);
            translate ([0, 0, 2*w])
                cylinder (r = r, h = h - 2*w);
            translate ([0, 0, h])
                cylinder (r1 = r, r2 = r + w, h = w);
        }
        translate ([0, 0, w])
            cylinder (r = r - ovh - w, h = h + w);
    }

    difference () {
        union () {
            translate ([0, -(r - ovh - w), h + w])
                grip (dia, w, gw);
            translate ([0,  (r - ovh - w), h + w])
                grip (dia, w, gw);
        }
        difference () {
            cylinder (r = dia, h = 2*h);
            translate ([0, 0, -w])
                cylinder (r = r, h = 3*h);
        }
    }
}

stopper ($fa = 2, $fs = .5);
