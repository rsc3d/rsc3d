use <lib/segment.scad>

module carpart 
    ( h1=3
    , h2=12
    , x=81, y=28, r1=6.5
    , iy=10.5, ix=47, ri=2
    , rhi=2.5, rhiu=9.5/2, rhid=3.5, rho=9.5/2, dh=60
    , h3=5, l3=40, d3=2.8
    , h4=7
    )
{
    // Solved touching the two circles where gradient is equal
    // Note that vb/vs are only half the chord length
    hb   = h4;
    vb   = x/2 - r1;
    hs = (2 * hb*hb * r1)   / (vb*vb + hb*hb);
    vs = (2 * hb * r1 * vb) / (vb*vb + hb*hb);
    echo (hb, vb, hs, vs, x/2, r1);
    echo (y, iy);
    hu = y / 2 - iy / 2 - d3;
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
                translate ([0, yy*(y/2 - hs), 0])
                    rotate ([0, 0, 90 - yy*90])
                        cylinder_segment (2*(vb+vs), hb+hs, h1);
            }
            for (yy = [-1:2:1]) {
                translate ([0, yy*(iy/2 + hu/2), h1 - hs])
                    rotate ([90, 0, 0])
                        translate ([0, 0, -hu / 2])
                            cylinder_segment (2*(vb+vs), hb+hs, hu);
            }
            for (yy = [-1:2:1]) {
                translate ([yy*dh/2, 0, -h2/2])
                    cylinder (r = rho, h = h2+1, center=true);
            }
            for (yy = [-1:2:1]) {
                translate ([0, yy * (iy/2 + hu), h1 - hs])
                    rotate ([0, 0, yy*90])
                        rotate ([0, 45.1, 0])
                            sphere_segment (2*(vb+vs), hb+hs, 90.2);
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
                    translate ([yy*(ix/2-ri), xx*(iy/2-ri), -h1])
                        cylinder (h = 3*h1, r = ri);
                }
            }
        }
    }
    for (xx = [-1:2:1]) {
        translate ([0, xx*(iy/2+d3/2), -h3/2+1])
            cube ([l3, d3, h3+2], center=true);
    }
}

carpart (h4=7, $fa = 1, $fs = .5);
