use <lib/segment.scad>

// Fridge part

module fpart
    ( h1=10, h2=21, h3=35
    , w=66.8, w2=10, w3=40, w4=17, w5=16, w6=38, w7=21
    , l=114, l1=78, l2=14, l3=16.2, l4=75
    , sh=4
    , d=8.5, df=3.5, hg=4, t=1.9, tg=7.5, tge=0.5
    , lh1=24, lh2=43, hh=15, hu=3, hd=5.5, hsd=2.5
    , ro=5
    )
{
    chord  = sqrt (l1*l1 + (h3-h2)*(h3-h2));
    alpha  = atan ((h3-h2) / l1);
    chord2 = sqrt (l1*l1 + (w3-w2)*(w3-w2));
    beta   = atan ((w3-w2) / l1);
    gamma  = atan ((w5-w4) / (l-l1));
    l3s    = l3 + w6 * sin (1);
    al     = w4;

    difference () {
        intersection () {
            cube ([l, w, h3]);
            translate ([0, w, h2])
                rotate ([0, -alpha, 0])
                    translate ([chord/2, 0, 0])
                        rotate ([90, 0, 0])
                            cylinder_segment (chord, sh, w, true);
            union () {
                translate ([0, w2, 0])
                    rotate ([0, 0, beta])
                        translate ([chord2/2, 0, 0])
                            cylinder_segment (chord2, sh, h3, true);
                translate ([l1, 0, 0])
                    cube ([l, w, h3]);
            }
        }
        translate ([2*t, hg, -0.001])
            cube ([l-3*t, df, tg]);
        translate ([d/2 + t, hg + df/2, -0.001])
            cylinder (h=tg+tge, r=d/2);
        // side facing rear is 1° tilted
        translate ([l, 0, 0])
            rotate ([0, 0, 1])
                translate ([0, -w/2, -w/2])
                    cube (2*w);
        // remove mounting space
        translate ([l1, 0, w4])
            rotate ([0, -gamma, 0])
                translate ([0, -w, 0])
                    cube ([2*(l-l1), 3*w, h3]);
        translate ([l1-0.01, -w, w4])
            cube ([2*(l-l1)+0.01, 3*w, h3]);
        translate ([l1, -0.01, h1])
            // For printing we need a 45° angle
            difference () {
                cube ([l-l1, w6, h3-h1]);
                translate ([0, w6-(w4-h1), 0])
                    rotate ([45, 0, 0])
                        translate ([-l/3, 0, h1-h3])
                            cube ([l, h3-h1, h3-h1]);
            }
        translate ([l-l3s-l2, w6-0.02-al, h1])
            cube ([l2, w7+0.01+al, h3-h1]);
        // holes for railing
        for (lh = [lh1, lh2]) {
            translate ([lh, 0, hh])
            rotate ([-90, 0, 0])
                union () {
                    translate ([0, 0, hu])
                        cylinder (h=w, r=hd/2);
                    translate ([0, 0, -1])
                        cylinder (h=w, r=hsd/2);
                }
        }
        for (m = [h3-ro, w4+ro]) {
            translate ([l4, -1, m])
                rotate ([-90, 0, 0])
                    cylinder (h=w, r=ro);
        }
        translate ([l4, -1, w4])
            cube ([ro, w, h3-w4+1]);
        translate ([l4-ro, -1, w4+ro])
            cube ([ro, w, h3-w4-2*ro]);
    }
    // support for printing
    translate ([0, 0, 0.4])
        cube ([l-t, d/2 + hg + df/2, 0.8]);
    translate ([l-l3s+l2/2-l2/3, w6+(2/3)*w7, 0])
        rotate ([0, 0, 45])
            cube ([0.8, w7/2, (w4+w5)/2]);
    translate ([l-l3s-l2-l2/2+l2/3, w6+(2/3)*w7, 0])
        rotate ([0, 0, -45])
            cube ([0.8, w7/2, (w4+w5)/2]);
}

mirror ([0, 1, 0])
    rotate ([90, 0, 0])
        fpart ($fa = 1, $fs = .5);
