module washer (odia = 17.5, idia = 4, mdia = 11.5, d1 = 3.2, d2 = 1.6)
{
    difference () {
        cylinder (r = odia / 2, h = d1);
        translate ([0, 0, -d1])
            cylinder (r = idia / 2, h = 3 * d1);
        translate ([0, 0, d1 - d2])
            cylinder (r = mdia / 2, h = d1);
    }
}

washer ($fa=3, $fs=.5);
