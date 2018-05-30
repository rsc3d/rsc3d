e = 0.01; // epsilon
module beaker
    (d1=65, d2=76, d3=92, ds1=42, ds2=12, h1=99, h2=112, h3=132, t=2.5, dh=15)
{
    difference () {
        union () {
            cylinder (r1=d1/2, r2=d2/2, h=h1);
            translate ([0, 0, h1-e])
                cylinder (r1=d2/2, r2=d3/2, h=h2-h1+e);
            translate ([0, 0, h2-e])
                cylinder (r=d3/2, h=h3-h2+e);
            translate ([d3/2-3*t, 0, h3])
                rotate ([0, 90, 0])
                    cylinder (r1=ds1/2, r2=ds2/2, h=dh);
        }
        translate ([0, 0, -e])
            difference () {
                cylinder (r1=d1/2-t, r2=d2/2-t, h=h1+2*e);
                cylinder (r=d1, h=t);
            }
        translate ([0, 0, h1-e])
            cylinder (r1=d2/2-t, r2=d3/2-t, h=h2-h1+2*e);
        translate ([0, 0, h2-e])
            cylinder (r=d3/2-t, h=h3-h2+5*e);
        translate ([d3/2-3*t, 0, h3]) {
            rotate ([0, 90, 0]) {
                cylinder (r1=ds1/2-t, r2=ds2/2-t, h=dh+e);
                translate ([0, 0, -3*t+e])
                    cylinder (r=ds1/2-t, h=3*t);
            }
        }
        translate ([0, 0, h3])
            cylinder (r=d3, h=ds1);
    }
}

beaker ($fa=3, $fs=0.5);
