include <nuts.scad>

module lock
    ( w=21, l=44.5, h=7
    , hw=11, hl=15, hh=12
    , hod=3.5, hr1=2, hr2=3.5
    , d=7.5, ww=3
    , fhd=.5
    )
{
    difference () {
        union () {
            cube ([l, w, h], center=true);
            translate ([0, 0, (h+hh)/2])
                cube ([hl+2*ww, w, h+hh], center=true);
        }
        translate ([0, 0, (hh+h)/2])
            cube ([hl, hw, hh], center=true);
        for (y = [l/2 - d, -l/2 + d]) {
            translate ([y, 0, -h])
                cylinder (r=hr1,   h=3*h);
            translate ([y, 0, -h/2 + hod])
                cylinder (r=hr2, h=3*h);
        }
        translate ([0, 3*ww, hh/2 + h/2 - fhd + fhd])
            cube ([hl, 5*ww, hh], center=true);
    }
}

rotate ([90, 0, 0])
    lock ($fa=3, $fs=0.3);
