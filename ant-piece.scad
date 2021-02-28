dia1   = 1.5;
dia2   = 2.0;
height = 6.0;
thickn = 5;
// Larger variant, can be set with -D option to openscad:
// dia2   = 3.2;
// height = 7;
// thickn = 6;

module antenna_piece (l=30, t=thickn, h=height, hh=3, wd1=dia1, wd2=dia2, phi=60)
{
    d1 = 0.7;
    d2 = 1.2;
    ll = l;
    alpha = 
        [ atan (((d2 - d1) / 2 * wd1) / hh)
        , atan (((d2 - d1) / 2 * wd2) / hh)
        ];
    difference () {
        for (p = [0, phi]) {
            rotate ([0, 0, p]) {
                for (y = [0, ll]) {
                    translate ([0, y, 0])
                        cylinder (r=t/2, h=h);
                }
                translate ([0, (ll)/2, h/2])
                    cube ([t, ll, h], center=true);
            }
        }
        for (y = [0, l-(1.25*dia2 + t)]) {
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
