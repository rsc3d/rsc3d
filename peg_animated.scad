use <peg.scad>

e = 0.1;
a = -2.5 + (1 + sin (360 * $t)) * 12.5 / 2;

color ("Silver") {
    rotate ([90, 0, 0])
        cylinder (r = 6.5 / 2 - e, h = 12, center = true);
    for (i = [-1, +1])
        rotate ([i * 90, i * (23.8 + a), 0])
            translate ([-19.12, 0, 0])
                rotate ([0, 0, -7]) {
                    translate ([0, 0, -5])
                        cylinder (r = 1.5 / 2 - e, h = 11);
                    translate ([0, -1.5 / 2 + e, 5])
                        cube ([19.2, 1.5 - 2*e, 1]);
                }
}

color ("BurlyWood") {
    for (rot = [[0, -a, 0], [180, a, 0]])
        rotate (rot) translate ([6, 0, -4.5]) render ()
            peg (72, 9.2, 6.5, 6.5, 23.3, 1.5, 1, true);
}
