// Peeler (e.g. for potatoes)
$fn = 100;

e = 0.001;

// starts at y axis + a1 in clock direction, continues for a2.
module arc (a1, a2, r, fw, h)
{
    rotate ([0, 0, a1])
    {
        difference () {
            slice (r, h, a2);
            rotate ([0, 0, -1])
                translate ([0, 0, -h])
                    slice (r - fw, 3 * h, a2 + 2);
        }
    }
}

// Starts at Y-axis in negative clock direction
module slice (r = 10, h = 10, ang = 30) {
    aa = (ang % 360 > 0) ? ang % 360 : ang % 360 + 360;
    rotate (-90) {
        difference() {
            cylinder (r = r, h = h);
            if (aa > 180)
                intersection_for (a = [0, 180 - aa])
                    rotate(-a) translate([-r, 0, -h])
                        cube ([r * 2, r * 2, 3 * h]);
            else union() for (a = [0, 180 - aa])
                rotate(-a) translate([-r, 0, -h])
                    cube ([r * 2, r * 2, 3 * h]);
        }
    }
}

module peelerside
    ( fw, bw, bd, h, r1, r2, c2x, c2y, rg, cgx, cgy
    , ga, sx, sy, c3x, c3y, cta, r1a, r2a, db, dh
    )
{
    l = sqrt (pow ((c2x - c3x), 2) + pow (c2y - c3y, 2));
    a = atan ((h / 3) / (bw / 4));
    difference () {
        union () {
            translate ([bw / 2, 0, 0])
                cube ([fw, bd + e, h]);
            translate ([bw / 2 - r1 + fw, bd, 0])
                arc (-90, r1a, r1, fw, h);
            translate ([cgx, cgy, 0])
                arc (90 - r2a, r1a + r2a, rg, fw, h);
            translate ([c2x, c2y, 0])
                arc (180 + 90 - r2a - 1, ga + 1, r2, fw, h);
            translate ([sx, sy, 0]) rotate ([0, 0, cta])
                cube ([fw, l, h]);
            translate ([(bw + fw) / 2, 1.917 * db, h / 2]) rotate ([0, -90, 0])
                cylinder (r = db / 2, h = db + fw / 2);
            // Support:
            translate ([bw / 2 - db + 0.5, 1.917 * db, 0])
                cylinder (r = 0.5, h = h / 2);
        }
        translate ([bw / 2, dh, dh]) rotate ([0, 90, 0])
            cylinder (r = dh / 2, h = 3 * fw, center = true);
        translate ([bw / 2 - fw, 0, h * 2 / 3]) rotate ([a, 0, 0])
            cube ([3 * fw, bw / 2, h]);
    }
}

module middle (fw, bw, bd, h)
{
    #cube ([bw, bd, fw], center = true);
}

// fw: feature width
// bw: width of peeler blade (inner peeler width)
// bd: depth of blade space
// h: height
// dg: dia of grip
// ed: distance to lower end from middle
// d1: dia of 1st rounded corner
// d2: dia of 2nd rounded corner
// d3: dia of lower round end
// db: dia of blade holder
// dh: dia of blade hole
// 
module peeler (fw, bw, bd, h, dg, ed, d1, d2, d3, db, dh)
{
    r1 = d1 / 2;
    r2 = d2 / 2;
    rg = dg / 2;
    r3 = d3 / 2;
    r1a = 60;
    r2a = 50;
    cgx = (bw / 2) - (r1 - fw) * (1 - cos (r1a)) + rg * cos (r1a);
    cgy = bd + (r1 -fw) * sin (r1a) + rg * sin (r1a);
    c2x = cgx - r2 * cos (r2a) - (rg - fw) * cos (r2a);
    c2y = cgy + r2 * sin (r2a) + (rg - fw) * sin (r2a);
    c3x = 0;
    c3y = cgy + ed - r3;
    dc2c3 = sqrt (pow (c2x - c3x, 2) + pow (c2y - c3y, 2));
    ca = asin ((c2x - c3x) / dc2c3);
    ta = asin ((r2 - r3) / dc2c3);
    cta = ca + ta;
    ga = r2a + cta;
    a3  = 180 - 2 * cta;
    sx = c2x + (r2 - fw) * cos (cta);
    sy = c2y + (r2 - fw) * sin (cta);
    peelerside
        ( fw, bw, bd, h, r1, r2, c2x, c2y, rg, cgx, cgy
        , ga, sx, sy, c3x, c3y, cta, r1a, r2a, db, dh
        );
    mirror ([1, 0, 0])
        peelerside 
            ( fw, bw, bd, h, r1, r2, c2x, c2y, rg, cgx, cgy
            , ga, sx, sy, c3x, c3y, cta, r1a, r2a, db, dh
            );
    translate ([0, c3y, 0])
        arc (-a3 / 2, a3, r3, fw, h);
    middle (fw, bw, bd, h);

}

//slice (10, 10, 230);
//arc (10, 230, 10, 2, 10);
peeler (2.5, 51, 24, 12, 30, 70, 25, 10, 32, 3, 3.5);
