use <lib/segment.scad>

module carpart 
    ( h1=3
    , h2=12
    , x=81, y=28, r1=6.5
    , ix=10.5, iy=47, ri=2
    , rhi=2.5, rhiu=9.5/2, rhid=3.5, rho=9.5/2, dh=60
    , h3=5, l3=40, d3=1.8
    , h4=7
    )
{
    // Solved touching the two circles where gradient is equal
    hbig   = h4;
    vbig   = x - 2 * r1;
    hsmall = (2 * hbig*hbig * r1)   / (vbig*vbig + hbig*hbig);
    vsmall = (2 * hbig * r1 * vbig) / (vbig*vbig + hbig*hbig);
    hu = y / 2 - h4;
    difference () {
        union () {
            hull () {
                for (yy = [-1:2:1]) {
                    for (xx = [-1:2:1]) {
                        translate ([xx*(x/2-r1), yy*(y/2-r1), 0])
                            cylinder (h = h1, r = r1);
                    }
                }
            }
            for (yy = [-1:2:1]) {
                translate ([0, yy*y/2, 0])
                    rotate ([0, 0, 90 - yy*90])
                        circle_segment (x - 2 * r1, h4, h1);
            }
            for (yy = [-1:2:1]) {
                translate ([0, yy*(ix/2 + hu/2), h1])
                    rotate ([90, 0, 0])
                        translate ([0, 0, -hu / 2])
                            circle_segment (x - 2 * r1, h4, hu);
            }
            for (yy = [-1:2:1]) {
                translate ([yy*dh/2, 0, -h2/2])
                    cylinder (r = rho, h = h2+1, center=true);
            }
        }
        for (xx = [-1:2:1]) {
            translate ([xx*dh/2, 0, -2*h2])
                cylinder (r = rhi, h=2*(h1+h2));
            translate ([xx*dh/2, 0, h1 - rhid + 0.01])
                cylinder (r1 = rhi, r2 = rhiu, h=rhid);
        }
        hull () {
            for (xx = [-1:2:1]) {
                for (yy = [-1:2:1]) {
                    translate ([yy*(iy/2-ri), xx*(ix/2-ri), -h1])
                        cylinder (h = 3*h1, r = ri);
                }
            }
        }
    }
    for (xx = [-1:2:1]) {
        translate ([0, xx*(ix/2+d3/2), -h3/2+1])
            cube ([l3, d3, h3+2], center=true);
    }
}

carpart ($fa = 3, $fs = .5);
