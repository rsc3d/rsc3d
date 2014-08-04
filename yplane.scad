module y_plane ()
{
    h  = 4.3;
    hh = h + 0.7;
    x  = 130;
    y  = 70;
    // max down 38 mm from current position
    // Limited by nut for mounting nut holder which must be above lower
    // frame. Lower frame is 20mm from bottom of this holder. Nut width
    // of M5 is 8mm, we add 1mm.
    md = min (38 - 25, y / 2 - 20 - 9 / 2);
    difference () {
        cube ([x, y, h], center = true);
        cube ([20, 30, 5], center = true);
        translate ([ 30,  25, 0])
            cylinder (r = 2.6, h = hh, center = true);
        translate ([-30,  25, 0])
            cylinder (r = 2.6, h = hh, center = true);
        translate ([ 30, -25, 0])
            cylinder (r = 2.6, h = hh, center = true);
        translate ([-30, -25, 0])
            cylinder (r = 2.6, h = hh, center = true);

        // Down 22 mm from current position
        // This optimizes usable Y-axis length as the upper table won't
        // collide with the frame but can move beyond it
        translate ([ 30,  25 - 22, 0])
            cylinder (r = 2.6, h = hh, center = true);
        translate ([-30,  25 - 22, 0])
            cylinder (r = 2.6, h = hh, center = true);
        translate ([ 50,  25 - 22, 2])
            cylinder (r = 4.3, h = hh, center = true);
        translate ([-50,  25 - 22, 2])
            cylinder (r = 4.3, h = hh, center = true);

        // Down md (max 38mm) from current position: optimize usable height
        translate ([ 30,  -md, 0])
            cylinder (r = 2.6, h = hh, center = true);
        translate ([-30,  -md, 0])
            cylinder (r = 2.6, h = hh, center = true);
        translate ([ 50,  -md, 2])
            cylinder (r = 4.3, h = hh, center = true);
        translate ([-50,  -md, 2])
            cylinder (r = 4.3, h = hh, center = true);
    }
}

translate ([0, -40, 0])
    y_plane ();
translate ([0,  40, 0])
    y_plane ();
