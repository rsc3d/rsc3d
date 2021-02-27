eps = 0.5;

module middle (ri = 25/2, ro=60, n=6, h=35)
{
    difference () {
        // polygon angle
        alpha = 180 - (360 / n);
        // angle of interesting triangle is alpha / 2
        hi = ri * tan (alpha / 2);
        cylinder (r = ro, h = h);
        union () {
            for (phi = [0 : 360 / n : 361]) {
                rotate ([0, 0, phi])
                    translate ([0, 0, h/2])
                        rotate ([90, 0, 0])
                            translate ([0, 0, hi + eps])
                                cylinder (r = ri, h = ro);
            }
        }
    }
}

//middle ($fa=3, $fs=0.5);
//middle (ri=15.5/2, h=20.5, n=5, ro=30, $fa=3, $fs=0.5);
middle (ri=16.5/2, h=21.6, n=6, ro=30, $fa=3, $fs=0.5);
