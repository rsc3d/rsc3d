module cover (d1, h1, d2, h2, hole=4)
{
    difference () {
        union () {
            translate ([0, 0, h1 / 2])
                cube ([d1, d1, h1], center = true);
            translate ([0, 0, h2 / 2])
                cube ([d2, d2, h2], center = true);
        }
        for (x = [-d2/2, d2/2]) {
            for (y = [-d2/2, d2/2]) {
                translate ([x, y, 0])
                    cylinder (r = hole / 2, h = 4 * h2, center = true);
            }
        }
    }
}

cover (122, 1.8, 92, 3.6, $fa=3, $fs=.5);
