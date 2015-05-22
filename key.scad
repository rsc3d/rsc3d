
// Old-fashioned key

module key (th = 15, td = 8.8, tw = 3.8, tm = 5, dia = 6.0, l = 51)
{
    // th: teeth-height
    // td: teeth-depth
    // tw: teeth-width
    // tm: teeth-mount (on round part)
    grip_r = th * 5 / 6;
    rotate ([-90, 0, 0])
        cylinder (h = l, r = dia / 2, $fa = 3, $fs = 0.5);
    tcr = 2.5;
    // teeth
    difference () {
        translate ([0, tm, -tw / 2])
            cube ([th, td, tw]);
        translate ([th - 1.05, tm + (td - 5.7) / 2, -2 * tw])
            cube ([5.7, 5.7, 4 * tw]);
        translate ([th - 3.05, tm + (td - 2.8) / 2, -2 * tw])
            cube ([2.8, 2.8, 4 * tw]);
        translate ([4.4, tm - 2.7 + 1.22, -2 * tw])
            cube ([2.7, 2.7, 4 * tw]);
        translate ([4.4, tm + td  - 1.22, -2 * tw])
            cube ([2.7, 2.7, 4 * tw]);
        translate ([0, tm - 1 / 2, tw / 2 - 0.5])
            cube ([td + 1, td + 1, tw]);
        translate ([th - 6.1, 0, tcr - tw / 2 + 2.0])
            rotate ([-90, 0, 0])
                cylinder (r = tcr, h = 2 * td, $fa = 3, $fs = 0.5);
    }
    translate ([0, grip_r - dia / 2 + l, 0]) difference () {
        cylinder ( h = dia,     r = grip_r
                 , center = true, $fa = 3, $fs = 0.5
                 );
        cylinder ( h = dia * 3, r = grip_r - dia
                 , center = true, $fa = 3, $fs = 0.5
                 );
    }

}

key ();
