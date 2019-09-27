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
    , recd=7    // Recess depth
    , nut=m3    // Nut parameters for holes
    , phi=77    // Angle of standing part
    )
{
    hyp = l2 - recd - (h/2 / cos (90 - phi));
    c1w = hyp * sin (90 - phi);
    c1h = hyp * cos (90 - phi);
    yhp = c1h + d * sin (90 - phi);
    xhp = l/2 - h1 + ((l2 - recd) * sin (90 - phi) - d * cos (90 - phi));

    c2w = 1;
    c2h = 0*15;
    c2phi = atan (xhp / yhp);
    difference () {
        union () {
            cube ([l, w, h], center = true);
            rotate ([0, phi, 0])
                translate ([l2/2, 0, -d/2])
                    difference () {
                        %cube ([l2, w, d], center = true);
                        translate ([l2/2-recd/2, 0, 0])
                            cube ([recd+e, recw, 3*d], center = true);
                    }
            translate ([c1w/2 + h/2 * tan (90-phi), 0, -(c1h/2+h/2)])
                cube ([c1w, w, c1h], center = true);
            translate ([-(l/2-h1), 0, -h/2])
                rotate ([0, -c2phi, 0])
                    translate ([c2w/2, 0, -c2h/2])
                        cube ([c2w, w, c2h], center = true);
            translate ([xhp/2 -l/2 + h1, 0, -yhp/2 - h/2])
                #cube ([xhp, w, yhp], center = true);
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

holder ($fa = 1, $fs = .5);
