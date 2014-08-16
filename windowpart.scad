$fn = 50;
module wpart ()
{
    difference () {
        union () {
            cube ([30, 10, 2], center = true);
            translate ([ 15, 0 , 0])
                cylinder (r = 5, h = 2, center = true);
            translate ([-15, 0 , 0])
                cylinder (r = 5, h = 2, center = true);
            translate ([0, 0, 4])
                cube ([30.5, 0.7, 8], center = true);
            translate ([0, 0, (7 - 2.7) / 2 + 1 + 2.7])
                cube ([31.5, 0.7, 7 - 2.7], center = true);
        }
        difference () {
            union () {
                translate ([0, -1.5, 0])
                    cube ([29.5 - 5, 2.5, 6], center = true);
                translate ([ (29.5) / 2 - 2.5, -0.25, 0])
                    cylinder (r = 2.5, h = 3, center = true);
                translate ([-(29.5) / 2 + 2.5, -0.25, 0])
                    cylinder (r = 2.5, h = 3, center = true);
            }
            translate ([0, 15 - 0.35, 0]) cube (30, center = true);
        }
        translate ([0, 3.35, 0])
            cube ([42, 6, 6], center = true);
    }
    translate ([ 15 + 2.5, 0, 0])
        cylinder (r = 2.5, h = 2, center = true);
    translate ([-15 - 2.5, 0, 0])
        cylinder (r = 2.5, h = 2, center = true);
}

wpart ();
