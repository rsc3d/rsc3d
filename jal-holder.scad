include <nuts.scad>

e = 0.01;

module holder
    ( w=11   // width
    , l=25.5    // length of groundplane
    , l2=21.5   // length of standing part
    , h=4.5     // height of groundplane
    , d=3       // thickness of standing part
    , h1=4.5    // distance hole 1
    , h2=5.5    // distance hole 2
    , recw=2    // Recess width
    , recd=9    // Recess depth
    , nut=m3    // Nut parameters for holes
    , phi=90-77 // Angle of standing part
    )
{
    hyp = l2 - recd - (h/2 / cos (phi));
    c1w = hyp * sin (phi);
    c1h = hyp * cos (phi);
    yhp = c1h + d * sin (phi);
    xhp = l/2 - h1 + ((l2 - recd) * sin (phi) - d * cos (phi));

    c2phi = atan (xhp / yhp);
    c2w = 6;
    c2h = xhp / sin (c2phi);
    difference () {
        union () {
            cube ([l, w, h], center = true);
            rotate ([0, 90 - phi, 0])
                translate ([l2/2, 0, -d/2])
                    union () {
                        difference () {
                            hull () {
                                for (x = [l2/2, -l2/2]) {
                                    for (y = [-w/2+d/2, w/2-d/2]) {
                                        translate ([x, y, 0])
                                            sphere (r=d/2);
                                    }
                                }
                            }
                            translate ([l2/2-recd/2, 0, 0])
                                cube ([recd+e, recw, 3*d], center = true);
                        }
                        for (x = [l2/2, l2/4]) {
                            hull () {
                                for (y = [-w/2+d/2, w/2-d/2]) {
                                    translate ([x, y, 0])
                                        #sphere (r=d/2);
                                }
                            }
                        }
                    }
            translate ([c1w/2 + h/2 * tan (phi), 0, -(c1h/2+h/2)])
                cube ([c1w, w, c1h], center = true);
            difference () {
                translate ([-(l/2-h1), 0, -h/2])
                    rotate ([0, -c2phi, 0])
                        translate ([c2w/2, 0, -c2h/2])
                            cube ([c2w, w, c2h], center = true);
                translate ([d/2, -w, -l2])
                    cube ([l2, 3*w, l2]);
            }
            // Cube for measuring correct xhp yhp
            //translate ([xhp/2 -l/2 + h1, 0, -yhp/2 - h/2])
            //    #cube ([xhp, w, yhp], center = true);
        }
        translate ([-l / 2 + h1, 0, -h])
            cylinder (r = m3 [screw_channel]/2, h = 3 * h);
        translate ([-l / 2 + h1, 0, -h/2-e])
            countersunk_screw_hole (nut, h, 20);
        translate ([l / 2 - h2, 0, -h])
            cylinder (r = m3 [screw_channel]/2, h = 3 * h);
        translate ([l / 2 - h2, 0, -h/2-e])
            countersunk_screw_hole (nut, h, 10);
    }
}

rotate ([90, 0, 0])
    holder ($fa = 1, $fs = .5);
