module antenna_piece (l=30, t=5, h=6, hh=3, wd1=1.5, wd2=2, phi=60)
{
    d1 = 0.7;
    d2 = 1.2;
    alpha = 
        [ atan (((d2 - d1) / 2 * wd1) / hh)
        , atan (((d2 - d1) / 2 * wd2) / hh)
        ];
    difference () {
        for (p = [0, phi]) {
            rotate ([0, 0, p]) {
                for (y = [0, l-t]) {
                    translate ([0, y, 0])
                        cylinder (r=t/2, h=h);
                }
                translate ([0, (l-t)/2, h/2])
                    cube ([t, l-t, h], center=true);
            }
        }
        for (y = [0, l-2.1*t]) {
            rotate ([0, 0, phi/2 + (y?0:90)]) {
                translate ([-l, y, h-hh])
                    rotate ([0, 90, 0])
                        cylinder (r=(y?wd2:wd1)/2, h=2*l);
                for (p = [-(alpha [y?1:0]), (alpha [y?1:0])]) {
                    translate ([0, y, h-hh])
                        rotate ([p, 0, 0])
                            translate ([0, 0, h])
                                cube ([2*l, (y?wd2:wd1)*d1, 2*h], center=true);
                }
            }
        }
    }
}

antenna_piece ($fa = 2, $fs = .3);
