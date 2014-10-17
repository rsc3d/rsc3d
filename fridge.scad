// Refrigerator part

module axis (r1, r2, r3, h1, h2, a3, a4, s)
{
    rotate ([-90, 0, 0]) {
        rotate ([0, 0, -a3]) {
            translate ([0, s, 0]) {
                cylinder (r = r1, h = h1);
                difference () {
                    rotate ([0, 0, a4 - 180]) {
                        difference () {
                            cylinder (r = r3, h = h2);
                            translate ([0, 0, -h2])
                                cylinder (r = r2, h = 3 * h2);
                            translate ([r3, 0, 0])
                                cube (2 * r3, center = true);
                        }
                    }
                    translate ([r3, 0, 0])
                        cube (2 * r3, center = true);
                }
            }
        }
    }
}

module side (a1, a2, a3, a4, h2, l, m, r1, r2, r3, s)
{
    w1 = h2 / cos (a1);
    w2 = h2 / cos (a2);
    bc = l + w2;
    translate ([-h2 * tan (a2), 0, 0]) {
        difference () {
            translate ([0, 0, h2]) {
                rotate ([0, -a1, 0])
                    translate ([-l, 0, -w1])
                        cube ([l, m, w1]);
                rotate ([0, -a2, 0])
                    translate ([-w2, 0, -w2])
                        cube ([w2, m, w2]);
                axis (r1, r2, r3, m + 2, m + 3, a3, a4, s);
            }
            translate ([-bc, -bc, -2 * bc])
                cube (2 * bc);
        }
    }
}

module fridge (l, w, h1, h2, m, r, a1, a2, a3, a4, r1, r2, r3, s)
{
    difference () {
        union () {
            translate ([0, 0, -m]) {
                cube ([l, w, m]);
                translate ([0, 0, 0])
                    cube ([l, m, h1]);
                translate ([0, w - m, 0])
                    cube ([l, m, h1]);
                translate ([l, 0, h1 / 2])
                    rotate ([-90, 0, 0])
                        cylinder (r = h1 / 2, h = w);
            }
            translate ([l + h1 / 2, 0, h1 / 2 - m])
                side (a1, a2, a3, a4, h2, l, m, r1, r2, r3, s);
            rotate ([-90, 0, 0])
                cylinder (r = r + 2 * m, h = w);
        }
        rotate ([-90, 0, 0])
            translate ([0, 0, -w / 2])
                cylinder (r = r, h = 2 * w);
    }
}

fridge (40, 20, 9, 20, 3, 7.5, 30, 60, 10, 15, 3, 12, 40, 5);
