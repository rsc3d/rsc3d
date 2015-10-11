
module klopart ()
{
    intersection () {
        difference () {
            cube ([33, 10, 6], center=true);
            cube ([9, 4.2, 7], center=true);
            translate ([0, 0, 4])
                rotate ([90, 0, 0])
                    cylinder (r=2.5, h=11.5, center=true);
            translate ([0, 0, 3])
                rotate ([0, 55, 0])
                    cylinder (r=2.1, h=30, center=true);
            translate ([0, 0, 3])
                rotate ([0, 45, 0])
                    cylinder (r=2.1, h=30, center=true);
        }
        translate ([0, 0, -31.5])
            rotate ([90, 0, 0])
                cylinder (r=35, h=40, center = true);
    }
}

klopart ($fa=3, $fs=.5);
