// Sealing ring for water tube
module dring (do=18.5, di=16, hg=11, dg=3, ds=2.5, ug=1)
{
    th = hg - (dg + ds + ug);
    difference () {
        cylinder (r = do/2, h = th);
        translate ([0, 0, -th])
            cylinder (r = di/2, h = 3*th);
    }
}

dring ($fa=3, $fs=.5);
