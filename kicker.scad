module kicker (foot_h, hole_h, h, hh, hole_dia, w, foot_w, d, shw, shd, s1, s2)
{
    body_r = 1.8 * hole_dia / 2;
    difference () {
        union () {
            // Foot
            translate ([0, 0, foot_h / 2])
                cube ([foot_w, d, foot_h], center = true);
            // Legs
            translate ([-foot_w / 4 + foot_w / 16, 0, foot_h - 0.01])
                cylinder (h = hole_h - foot_h, r = foot_w / 4);
            translate ([ foot_w / 4 - foot_w / 16, 0, foot_h - 0.01])
                cylinder (h = hole_h - foot_h, r = foot_w / 4);
            // Body
            translate ([0, 0, hole_h]) {
                hull () {
                    translate ([0, 0,  body_r / 2])
                        rotate ([0, 90, 0])
                            cylinder (r = body_r, h = w, center = true);
                    translate ([0, 0, -body_r / 2])
                        rotate ([0, 90, 0])
                            cylinder (r = body_r, h = w, center = true);
                }
            }
            // Neck
            translate ([0, 0, hole_h])
                cylinder (r = foot_w / 4, h = h - hole_h);
            // Head
            translate ([0, 0, h - hh / 2])
                cube ([foot_w, d, hh], center = true);
        }
        translate ([0, 0, hole_h])
        {
            // Big hole through body for mounting
            rotate ([0, 90, 0])
                cylinder (r = hole_dia / 2, h = 2 * w, center = true);
            // Screw hole
            rotate ([90, 0, 0])
                translate ([0, 0, -body_r - 0.01])
                    cylinder (r = shw / 2, h = shd);
            rotate ([-90, 0, 0])
                cylinder (r = s1 / 2, h = 1.1 * body_r);
            rotate ([90, 0, 0])
                cylinder (r = s2 / 2, h = 3 * body_r, center = true);
        }
    }
}

rotate ([0, 90, 0])
kicker (13, 62, 105, 19, 13, 33.5, 23, 13, 7, 2.5, 3.5, 3);
