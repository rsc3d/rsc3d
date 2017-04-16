module feedthrough (w=19.5, h=17, r=10, md=1, od=2, oh=2)
{
    difference () {
        union () {
            translate ([0, 0, h / 2])
                cube ([w, md + 2 * od, h], center = true);
            translate ([0,  md / 2 + od / 2, h / 2 + oh / 2])
                cube ([w + 2 * oh, od, h + oh], center = true);
            translate ([0, -md / 2 - od / 2, h / 2 + oh / 2])
                cube ([w + 2 * oh, od, h + oh], center = true);
        }
        translate ([0, 0, h / 2])
            rotate ([90, 0, 0])
                cylinder (r = r / 2, h = 2 * (md + 2 * od), center = true);
    }
    // Support material
    translate ([ 0.15 * r, 0, h / 2])
        cube ([0.7, md + 2 * od, h], center = true);
    translate ([-0.15 * r, 0, h / 2])
        cube ([0.7, md + 2 * od, h], center = true);
    translate ([0, 0, h / 2])
        cube ([0.7, md + 2 * od, h], center = true);
}

feedthrough ($fa = 5, $fs = .5);
