use <lib/arc.scad>

// see calculations in steckdose.wxm

module outside (da, dm, iw, th)
{
    // da: outer diameter
    // dm: medium diameter
    // iw: inner width
    // th: thickness
    a   = iw / 2;
    b   = (dm - da) / 2;
    r   = (b * b + a * a) / (2 * b);
    z   = da / 2;
    c   = z - a;
    phi = 2 * acos ((r - b) / r);
    m2  = -(a * z - a * r + a * b) / (r - b - a);
    r2  = sqrt (pow (z - m2, 2) + pow (a - m2, 2));
    alpha = acos ((pow (r2, 2) - pow (c, 2)) / pow (r2, 2));
    echo (a, m2, r2, alpha);
    echo (-(a - m2) / (z - m2));
    echo (a / (b - r));
    for (rot = [0, 90, 180, 270]) {
        rotate ([0, 0, rot]) {
            translate ([0, z + b - r, 0])
                arc (-phi / 2, phi, r, th, 10, $fa = 3);
            translate ([m2, m2, 0])
                arc (-(45 + alpha / 2 + 1), alpha + 2, r2, th, 10, $fa = 3);
        }
    }
}

module groundhole_flat (w1=4, w2=8, h=2, l=10)
{
    a = atan (h / ((w2-w1)/2));
    difference () {
        translate ([0, 0, -2*h])
            cube ([l, w2, 6*h], center = true);
        for (k=[-1, 1])
            translate ([k*l/2, 0, 0])
                rotate ([0, -180+k*a, 0])
                    translate ([0, 0, -10])
                        cube (20, center = true);
        for (k=[-1, 1])
            translate ([0, k*w2/2, 0])
                rotate ([180-k*a, 0, 0])
                    translate ([0, 0, -10])
                        cube (20, center = true);
    }
}

module groundhole (ld, ud, h, w=4, d=4)
{
    a = atan ((ld - ud) / 2 / h);
    rotate ([180, 0, 0]) translate ([0, -w/2, 0]) {
        translate ([-ud/2, 0, 0])
            cube ([ud, w, h + d]);
        translate ([-ud/2, 0, 0])
            rotate ([0, -a, 0])
                cube ([ud, w, h + d]);
        translate ([ud/2, 0, 0])
            rotate ([0, a, 0])
                translate ([-ud, 0, 0])
                    cube ([ud, w, h + d]);
    }
}

// Inside of a DIN power outlet -- negative (to subtract from something)
// dia:  dia of plug hole
// w:    width of plug hole between flattened sides
// w2:   width of non-flattened part in the middle
// hdia: connector hole diameter
// ld:   lower diameter of ground hole at side
// ud:   upper diameter of ground hole at side
// ghw:  ground hole diameter at bottom
// ghh:  ground hole height (on side) measured from top
// ghd:  ground hole depth (at bottom)
// h:    height of plug hole
// h2:   height of flattened side
// cd:   connector distance (between inner hole borders)
module inside
    ( dia=39.2+.5, w=33.2+.5, w2=5.2+.5, hdia=5.5
    , ld=7.5, ud=3.2, ghw=3, ghh=1.2, ghd=5.5
    , h=17.8, h2=14, cd=13.4, 
    )
{
    r = dia / 2;
    xx = (dia - w) / 2;
    //translate ([0, 0, -h]) {
    translate ([0, 0, 0]) {
        union () {
            difference () {
                cylinder (r = r, h = h + 1);
                for (y = [1, -1]) {
                    for (x = [1, -1]) {
                        translate ([x * (3*r/2 - xx), y * (r/2 + w2/2), h2/2]) {
                            cube ([r, r, h2 + 2], center = true);
                        }
                    }
                }
            }
            for (x = [1, -1]) {
                translate ([x*(cd+hdia)/2, 0, -h/2])
                    cylinder (r = hdia / 2, h = 10);
            }
            for (y = [1, -1]) {
                translate ([0, y*(r+1), (h-ghh)])
                    groundhole (ld, ud, h-ghh);
            }
            for (y = [1, -1]) {
                translate ([0, y*(r-ghd/2+.01), -2])
                    cube ([ghw, ghd, 4.1], center = true);
                translate ([0, y*(r-ghd/2+.01), -3])
                    rotate ([0, 0, 90])
                        groundhole_flat (w1=ghw, w2=ghw+4, l=ghd + 4, h=2);
            }
        }
    }
}

module outlet_single
    ( h=66.5, w=66.5, dia=43, sc=2.5, sch=5.5, t=3
    , sd=2.7, hr=7.5, hi=2, hc=20.5, hs=24
    , ql=27.7, qw=8.8, q2w=2.5, q2l=15.5, q2d=26, q3h=1.2
    )
{
    render (convexity=10)
    difference () {
        union () {
            translate ([0, 0, -hr + hc]) {
                difference () {
                    translate ([0, 0, hr/2])
                    cube ([h, w, hr], center = true);
                    translate ([0, 0, (hr-t)/2-.01])
                        cube ([h - 2*hi, w - 2*hi, hr - t], center = true);
                }
            }
            cylinder (r=dia/2, h=hc);
            translate ([0, 0, -(hs-hc)/2])
                cube ([ql, qw, hs-hc], center=true);
            for (x=[-1,1]) {
                translate ([(q2w/2-q2d/2)*x, 0, -(hs-hc)/2])
                    cube ([q2w, q2l, hs-hc], center=true);
                for (y=[-1,1]) {
                    translate ([(q2w-q2d)*x/2, y*(q2w-q2l)/2, -(hs-hc+q3h)/2])
                        cube ([q2w, q2w, hs-hc+q3h], center=true);
                }
            }
        }
        translate ([0, 0, 2.21]) inside ();
        translate ([0, 0, 2.21+.01]) {
            translate ([0, 0, -50])
                cylinder (r=sc/2,  h=50);
            translate ([0, 0, -.5])
                cylinder (r=sch/2, h=.5);
            translate ([0, 0, -.5-1.7])
                cylinder (r1=sc/2, r2=sch/2, h=1.7);
        }
    }
}

//outside (100.25, 106.5, 81.25, 2);
//inside ();
//groundhole (ld=7.5, ud=3.2, h=17.8-1.2);
mirror ([0, 0, 1])
    outlet_single ($fa=3, $fs=.5);
//groundhole_flat ();
