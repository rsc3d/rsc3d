$fn = 100;
//2.5 schief auf 5.5
angle = atan (2.5 / 5.5);
echo (angle);
echo (cos (angle));

module slantcyl (r, h, angle, up)
{
    e = 0.1;
    mov = (2 * r / cos (angle) + e) * (up ? 1 : -1);
    difference () {
        cylinder (r = r, h = h, center = true);
        translate ([0, 0, mov])
            rotate ([angle, 0, 0])
                cube (4 * r, center = true);
    }
}

difference () {
    union () {
        slantcyl (4.5, 3.8, angle, true);
        slantcyl (5.5 / 2, 3.5, angle, false);
    }
    cylinder (r = 1.6, h = 7, center = true);
}
