include <nuts.scad>
$fn=50;
module extr ()
{
    e  = 0.01;
    bh = 11.8;
    bw = 11.25;
    bd = 10;
    rb = 12;
    hb = 9;
    w  = 26;
    h  = 12;
    l  = 41.5;
    difference () {
        union () {
            translate ([0, 0, h / 2])
                cube ([w, l, h], center = true);
            translate ([0, -16.3, 10])
                rotate ([0, 90, 0])
                    cylinder (r = 5.3, h = w, center = true);
            translate ([0, 15.75, bh / 2 + 12 - e])
                difference () {
                    cube ([bw, bd, bh], center = true);
                    translate ([0, 0, (bh + 1) / 2 + 3])
                        cube ([3.5, bd + 1, bh + 1], center = true);
                    translate ([0, bd + bh / 2, 3])
                        rotate ([90, 0, 0])
                            cylinder (r = 3.5 / 2, h = bd + bh);
                }
        }
        translate ([0, 0, 10])
            rotate ([0, 90, 0])
            {
                difference () {
                    cylinder (r = rb, h = hb - e, center = true);
                    translate ([0, 0,  hb / 2])
                        cylinder (r1 = 6, r2 = 8, h = 2, center = true);
                    translate ([0, 0, -hb / 2])
                        cylinder (r1 = 8, r2 = 6, h = 2, center = true);
                }
                cylinder (r = 4.2, h = 20, center = true);
            }
        translate ([0, -20, -20])
            rotate ([30, 0, 0])
                translate ([0, 0, 13])
                    cube ([27, 26, 26], center = true);
        translate ([0, -16.3, 10])
            rotate ([0, 90, 0])
                cylinder (r = 3.5 / 2, h = w + 2, center = true);
        translate ([-8.5, -16.3, 10])
            rotate ([0, 90, 0])
                rotate ([0, 0, 90])
                    nut_hole (m3, m3 [nut_height]);
        translate ([0, -16.3, 10])
            rotate ([0, 90, 0])
                cylinder (r = 5.8, h = w / 2, center = true);
        translate ([0, -23, 7])
            rotate ([30, 0, 0])
                cube (w / 2, center = true);
        translate ([0, 15, 20.8])
            rotate ([90, 0, 0])
                cylinder (r = 3.5 / 2, h = 20, center = true);
        translate ([0, 15, 20.8 + 5])
            cube ([3.5, 20, 10], center = true);
        translate ([-8, 14, 0])
            cylinder (r = 2.4, h = 30, center = true);
        translate ([-8, 14 + 10, 0])
            cube ([4.8, 20, 30], center = true);
        translate ([8, 14, 0])
            cylinder (r = 2.4, h = 30, center = true);
        translate ([8, 14 + 10, 0])
            cube ([4.8, 20, 30], center = true);
    }
}

extr ();
