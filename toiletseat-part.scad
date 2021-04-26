use <lib/segment.scad>

e   = 0.01;
d1  = 24;    // diameter lower round part
d2  = 17;    // diameter upper round part
h   = 13.5;
t   =  4.8;  // thickness of screwed-on part
l   = 48.5;  // length of screwed-on part
hd1 = 25.0;
hd2 = 22.5;
sh  =  4.2;
sw  =  8.2;
swh =  2;
ri  =  6.75;
wi  =  9.5;
di  = 12;
module seatpart (d1=d1, d2=d2, h=h, t=t, l=l, di=12, wi=wi)
{
    // Compute the inclination of the truncated cone
    // Call a variant of the sphere_segment that takes this inclination
    incl = h / ((d1 - d2) / 2);
    a    = 53.5;
    v1   = sin (a);
    v2   = cos (a);
    dl   = sqrt (pow (d2/2, 2) + pow (d2/2 + hd1 - sw/2 - d1/2, 2));
    phi  = asin (d2/2 / dl);
    td   = sqrt (pow (d2/2, 2) + pow (sin (phi) * d2/2, 2));
    difference () {
        union () {
            cylinder (r1 = d1/2, r2 = d2 / 2, h = h);
            translate ([0, 0, h])
                sphere_segment_incl (chord = d2, incl = incl, alpha = 180);
            translate ([d2/4+e, -t/2 + d2/2, h/2])
                cube ([d2/2, t, h], center = true);
            translate ([0, d1/2, 0])
                rotate ([0, 0, -phi])
                    translate ([0, -d2/2, 0])
                        cube ([td, dl+d2/2+e, h]);
            translate ([t/2 + d2/2, (l+t)/2 + d2/2 - t, h/2])
                cube ([t, l+t, h], center = true);
            translate ([t/2 + d2/2, l + d2/2, h/2])
                rotate ([0, 90, 0])
                    cylinder (r = h/2, h = t, center=true);
            translate ([(d2/2) * v1, -(d2/2) * v2, 0])
                rotate ([0, 0, a])
                    cube ([d2/2 + t/2, t, h]);
        }
        translate ([d2/2-e, d2/2 + hd1, h/2])
            rotate ([0, 90, 0]) {
                cylinder (r2 = sh/2, r1 = sw/2, h = swh);
                cylinder (r = sh/2, h=2*d2);
            }
        translate ([d2/2-e, d2/2 + hd1 + hd2, h/2])
            rotate ([0, 90, 0]) {
                cylinder (r2 = sh/2, r1 = sw/2, h = swh);
                cylinder (r = sh/2, h=2*d2);
            }
        translate ([0, 0, -e])
            difference () {
                intersection () {
                    cylinder (r = ri, h = di);
                    translate ([0, 0, di/2])
                        cube ([wi, 3*ri, di], center = true);
                }
                // Support
                for (x = [-wi/5, wi/5]) {
                    translate ([x, 0, di/2])
                        cube ([.7, 3*ri, 2*di], center = true);
                }
            }
        translate ([d2/2 + t, 0, -h])
            cube ([d2, l, 3*h]);
    }
}

seatpart ($fa = 2, $fs = .5);
