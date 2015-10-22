module grip (h, lower_r, upper_r, edges, holedia = 4.5)
{
    rho = atan ((lower_r - upper_r) / h);
    echo (rho);
    ch  = sqrt (pow (h, 2) + pow (lower_r - upper_r, 2)) * 1.5;
    cs  = lower_r * 1.5 * 2;
    difference () {
        translate ([0, 0, h])
            rotate ([180, 0, 0])
                intersection_for (n = [1 : edges]) {
                    rotate ([0, 0, n * 360 / edges])
                        translate ([-lower_r, -lower_r, 0])
                            rotate ([-rho, 0, 0])
                                cube ([cs, cs, ch]);
                }
        translate ([0, 0, -ch / 2])
            cube (ch, center = true);
        cylinder (r = holedia / 2, h = 11 * 2, center = true);
    }
}

module handle ()
{
}

grip (18.5, 18.5 / 2, 12 / 2, 8, $fa = 3, $fs = .5);
