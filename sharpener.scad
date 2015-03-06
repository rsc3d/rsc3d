e = 0.001;
module sharpener (odia = 55, h = 55, w = 2, d = 1, hd = 12, edges = 8, ang = 25)
{
    // inner_dia / cos (180 / edges) = odia - 2 * w;
    inner_dia = (odia - 2 * (w + d)) * cos (180 / edges);
    difference () {
        union () {
            intersection_for (n = [1 : edges / 2]) {
                rotate ([0, 0, n * 360 / edges])
                    cube ([odia, odia, h], center = true);
            }
            translate ([0, 0, h / 2 - e]) {
                linear_extrude (height = hd, twist = -ang, slices = 40) {
                    intersection_for (n = [1 : edges / 2]) {
                        rotate ([0, 0, n * 360 / edges])
                            square (inner_dia, center = true);
                    }
                }
            }
        }
        translate ([0, 0, w + h / 2])
            cylinder (r = inner_dia / 2 - w, h = 2 * h, center = true, $fa=5);
    }
}

module screwhole (w, ds1, ds2, hh)
{
    translate ([0, 0, -e]) {
        cylinder (r1 = ds2 / 2, r2 = ds1 / 2, h = hh);
        translate ([0, 0, hh - e])
            cylinder (r = ds1 / 2, h = 2*w);
    }
}

module sharpener_holes (w, holes)
{
    // 0-2: screw_dia, screwhead_dia, head_height
    //   3: big sharpener dia
    //   4: small sharpener dia
    //   5: width1 X
    //   6: screw hole 1 from edge
    //   7: small hole from screw hole
    //   8: big hole from small hole
    //   9: screw hole 2 from big hole
    //  10: width2 Y
    //  11: screw hole 2 from edge
    //  12: small hole from screw hole
    //  13: big hole from small hole
    //  14: screw hole 1 from big hole
    sc1x =  holes [5]  / 2 - holes [6];
    sc2y =  holes [10] / 2 - holes [11];
    sh1x = sc1x - holes [7];
    sh1y = sc2y - holes [12];
    bh1x = sh1x - holes [8];
    bh1y = sh1y - holes [13];
    sc2x = bh1x - holes [9];
    sc1y = bh1y - holes [14];
    translate ([sc1x, sc1y])
        screwhole (w, holes [0], holes [1], holes [2]);
    translate ([sh1x, sh1y])
        cylinder (r = holes [4] / 2, h = 4 * w, center = true);
    translate ([bh1x, bh1y])
        cylinder (r = holes [3] / 2, h = 4 * w, center = true);
    translate ([sc2x, sc2y])
        screwhole (w, holes [0], holes [1], holes [2]);
}

module top (holes, odia, w, hd = 12, edges = 8, ang = 25, d1 = 9, d2 = 13, sd)
{
    dia = (odia - 2 * (w)) * cos (180 / edges);
    difference () {
        translate ([0, 0, w / 2]) intersection_for (n = [1 : edges / 2]) {
                rotate ([0, 0, n * 360 / edges])
                    cube ([odia, odia, hd + w], center = true);
            }
        translate ([0, 0, -hd / 2 + w + e]) {
            linear_extrude (height = hd, twist = -ang, slices = 40) {
                intersection_for (n = [1 : edges / 2]) {
                    rotate ([0, 0, n * 360 / edges])
                        square (dia, center = true);
                }
            }
        }
        translate ([0, 0, -hd / 2])
            sharpener_holes (w, holes, $fs=0.1);
    }
}

odia  = 55;
h     = 55;
w     =  2;
d     =  1;
hd    = 12;
edges =  8;
ang   = 25;
holes = [2.5, 3.5, 2.5, 13, 9, 24.5, 3, 3, 12, 6, 17, 2, 3.5, 5, 2];

translate ([0, 0, h/2])
    sharpener (odia, h, w, d, hd, edges, ang);
translate ([1.1 * odia, 0, hd / 2])
    top (holes, odia, w, hd, edges, ang, d1, d2, sd);
