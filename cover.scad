module cover (d1, h1, d2, d2h, h2, h3, ro=3.5, rh=1.5)
{
    difference () {
        union () {
            translate ([0, 0, h1 / 2])
                cube ([d1, d1, h1], center = true);
            translate ([0, 0, h2 / 2])
                cube ([d2, d2, h2], center = true);
            for (x = [-d2h/2, d2h/2]) {
                for (y = [-d2h/2, d2h/2]) {
                    translate ([x, y, (h3 + h1) / 2])
                        cylinder (r = ro, h = h3 + h1, center = true);
                }
            }
        }
        for (x = [-d2h/2, d2h/2]) {
            for (y = [-d2h/2, d2h/2]) {
                translate ([x, y, 0])
                    cylinder (r = rh, h = 4 * h2, center = true);
            }
        }
    }
}

cover (122, 1.8, 92, 90, 3.6, 3.6, $fa=3, $fs=.5);
