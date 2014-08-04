module y_plane ()
{
    h  = 4.3;
    hh = h + 0.7;
    difference () {
        cube ([130, 70, h], center = true);
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

        // Down 37 mm from current position: optimize usable height
        translate ([ 30,  25 - 37, 0])
            cylinder (r = 2.6, h = hh, center = true);
        translate ([-30,  25 - 37, 0])
            cylinder (r = 2.6, h = hh, center = true);
        translate ([ 50,  25 - 37, 2])
            cylinder (r = 4.3, h = hh, center = true);
        translate ([-50,  25 - 37, 2])
            cylinder (r = 4.3, h = hh, center = true);
    }
}

y_plane ();
