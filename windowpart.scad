module wpart ()
{
    difference () {
        union () {
            cube ([50, 10, 2], center = true);
            translate ([0, 1, 5])
                cube ([30, 2, 8], center = true);
        }
        translate ([0, -1, 0])
            cube ([40, 2, 6], center = true);
        translate ([0, 4, 0])
            cube ([40, 4, 6], center = true);
    }
}

wpart ();
