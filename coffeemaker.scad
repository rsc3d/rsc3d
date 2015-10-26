module grip (h, lower_r, upper_r, edges, holedia = 4.5)
{
    rho = atan ((lower_r - upper_r) / h);
    echo (rho);
    ch  = sqrt (pow (h, 2) + pow (lower_r - upper_r, 2)) * 1.5;
    cs  = lower_r * 1.5 * 2;
    difference () {
        translate ([0, 0, h])
            rotate ([180, 0, 0])
                intersection_for (n = [1 : edges]) {
                    rotate ([0, 0, n * 360 / edges])
                        translate ([-lower_r, -lower_r, 0])
                            rotate ([-rho, 0, 0])
                                cube ([cs, cs, ch]);
                }
        translate ([0, 0, -ch / 2])
            cube (ch, center = true);
        cylinder (r = holedia / 2, h = 11 * 2, center = true);
    }
}

module main1 (r1, r2, r3, l1, l2, l3, a1, c3h)
{
    rotate ([180 + 60, 0, 0])
        translate ([0, -r1, 0])
            cylinder (r1 = r1, r2 = r2, h = l1);
    translate ([0, r1, 0])
        cylinder (r = r1, h = l2);
    translate ([0, 2 * r1, c3h])
        rotate ([-90 + a1, 0, 0])
            translate ([0, -r3, 0])
                cylinder (r = r3, h = l3);
    translate ([0, 2 * r1, c3h])
        rotate ([-90 + a1, 0, 0])
            translate ([0, -r3, 0])
                sphere (r = r3);
}

module main2 (r1, r2, r3, l1, l2, l3, a1, a2, w, w2, d1, dy, c3h, guide)
{
    wx = w / 5 * 7;
    w3 = guide [0];
    difference () {
        main1 (r1, r2, r3, l1, l2, l3, a1, c3h);
        differ (r1, r3, l2, l3, a1, a2, c3h, d1);
    }
    translate ([0, 2 * r1, c3h])
        rotate ([-90 + a1, 0, 0])
            translate ([0, -r3 + wx/2, 0])
            intersection () {
                translate ([0, 0, l3 / 2])
                    cube ([w2, 2 * r3 - wx, l3], center = true);
                translate ([0, -wx/2, 0])
                    cylinder (r = r3, h = l3);
            }
    translate ([0, dy, c3h + 2 * r3 / cos (a1) - 2 * r1 * tan (a1)])
        rotate ([-a2, 0, 0])
            translate ([0, r3 - w/2, l3 / 2])
                cube ([w2, 2 * r3 - w, l3], center = true);
    // guide
    translate ([0, dy, c3h + 2 * r3 / cos (a1) - 2 * r1 * tan (a1)])
        rotate ([-a2, 0, 0])
            translate ([-w3/2, r3 - w/2, guide [2] + guide [1] / 2])
                cube ([w2 + w3, 2 * r3 - w, guide [1]], center = true);
}

module main3
    (r1, r2, r3, l1, l2, l3, a1, a2, w, w2, d1, d2, c3h, dy, hole, guide)
{
    difference () {
        main2 (r1, r2, r3, l1, l2, l3, a1, a2, w, w2, d1, dy, c3h, guide);
        differ (r1, r3, l2, l3, a1, a2, c3h, d1 + d2 / cos (a2));
        if (hole) {
            translate ([0, dy, c3h + 2 * r3 / cos (a1) - 2 * r1 * tan (a1)])
                rotate ([-a2, 0, 0])
                    translate ([0, hole [1], hole [0]])
                        rotate ([0, 90, 0])
                            cylinder (r = hole [2] / 2, h = 2*w2, center=true);
        }
    }
    translate ([0, 2 * r1, c3h])
        rotate ([-90 + a1, 0, 0])
            translate ([0, -r3, 0])
                difference () {
                    cylinder (r = r3, h = l3);
                    translate ([0, 0, -l3 / 2])
                        cylinder (r = r3 - w, h = 2 * l3);
                    translate ([0, -r3 + 1, l3 / 2])
                        cube ([2 * r3, 2 * r3, 2 * l3], center = true);
                }
}

module differ (r1, r3, l2, l3, a1, a2, c3h, distance)
{
    translate ([0, distance, c3h + 2 * r3 / cos (a1) - 2 * r1 * tan (a1)])
        rotate ([-a2, 0, 0])
            translate ([-l3, -l3, 0])
                cube (2 * l3);
}

module handle
    ( r1 = 5, r2 = 7.5 / 2, r3 = 18.5 / 2
    , l1 = 44, l2 = 23, l3 = 30
    , w = 2.5, w2 = 4.21
    , d1 = 9, d2 = 9, d3 = 3.5
    , hole  = [6, 4.2, 3.2]
    , guide = [1, 4, 1.5]
    )
{
    a1 = 20.5;
    a2 = 45;
    dis = d1 + d2 / cos (a2) + d3;
    c3h = l2 / 2;
    dy  = d1;
    difference () {
        main3
            ( r1, r2, r3
            , l1, l2, l3
            , a1, a2
            , w, w2
            , d1, d2, c3h, dy
            , hole, guide
            );
        differ (r1, r3, l2, l3, a1, a2, c3h, dis);
    }
    // Support material
    translate ([0, dy, c3h + 2 * r3 / cos (a1) - 2 * r1 * tan (a1)])
        rotate ([-a2, 0, 0])
            translate ([0, d2 + w2 - 1, d2 - 1.2])
                rotate ([0, 90, 0])
                    cylinder (r = 1.2, h = 2 * r3 - 2, center = true);
}

translate ([6, 30, 0])
    grip (18.5, 18.5 / 2, 12 / 2, 8, $fa = 3, $fs = .5);
translate ([0, 0, 15.5/2])
    rotate ([0, 90, 0])
        handle (hole = 0, $fa = 3, $fs = .5);
