// 
$fn = 100;
module stand ()
{
    a = atan (7 / 19);
    difference () {
        union () {
            difference () {
                union () {
                    translate ([21, 0, 0])
                        cube ([42, 64, 2], center = true);
                    translate ([36, 0, 0])
                        rotate ([0, 50, 0])
                            translate ([0, 0, -0.2])
                                cube ([4.7, 50, 11], center = true);
                }
                cylinder (r = 12, h = 5, center = true);
                translate ([13 + 19, -4 - (32 - 7), 0])
                    cube ([26, 8, 5], center = true);
                translate ([13 + 19,  4 + (32 - 7), 0])
                    cube ([26, 8, 5], center = true);
                translate ([19, -(32 - 7), 0])
                    rotate ([0, 0, a])
                        translate ([-13, -4, 0])
                            cube ([26, 8, 5], center = true);
                translate ([19,  (32 - 7), 0])
                    rotate ([0, 0, -a])
                        translate ([-13, 4, 0])
                            cube ([26, 8, 5], center = true);
                translate ([42 - 3.75 / 2, -3.5 + 29, 0])
                    cube ([3.75, 7, 15], center = true);
                translate ([42 - 3.75 / 2,  3.5 - 29, 0])
                    cube ([3.75, 7, 15], center = true);
            }
            translate ([42, 0, 0.35])
                rotate ([90, 0, 0])
                    cylinder (r = 2.7 / 2, h = 29 * 2, center = true);
            translate ([42 - 3.75, 0, 0.35 + 5 - 2.7 / 2])
                rotate ([90, 0, 0])
                    cylinder (r = 2.7 / 2, h = 63, center = true);
            translate ([42 - 3.75, 0, 2])
                cube ([0.7, 63, 6], center = true);
            translate ([42 - 3.75,  (63 - 2.7) / 2, 1])
                cylinder (r = 2.7 / 2, h = 6, center = true);
            translate ([42 - 3.75, -(63 - 2.7) / 2, 1])
                cylinder (r = 2.7 / 2, h = 6, center = true);
        }
        translate ([0, 0, -50 -1])
            cube (100, center = true);
        translate ([42 - 5,  (27 + 2.25) / 2, 0])
            cube ([23, 2.25, 20], center = true);
        translate ([42 - 5, -(27 + 2.25) / 2, 0])
            cube ([23, 2.25, 20], center = true);
    }
}

stand ();
