e = 0.1;
$fn = 100;
module peg (l, h, w, spring_dia, spring_l, wire_dia, minw, filled)
{
    angle = atan (w - 2 * minw / ((l - spring_dia) / 2));
    difference () {
        union () {
            cube ([l / 6 * 5.2, h, w + e], center = true);
            translate ([-(l / 6 * 5 + l / 6) / 2, 0, -(l / 6 - h)])
                rotate ([90, 0, 0])
                    cylinder (r = l / 12, h = h, center = true);
        }
        translate ([-l / 12 * 5 + w * 0.15, 0, w / 2.2])
            rotate ([90, 0, 0])
                cylinder (r = w / 2.2, h = h + e, center = true);
        translate ([-0.3 * l, 0, w / 2 + 0.1 * w / 4.5])
            rotate ([90, 0, 0])
                cylinder (r = w / 4.5, h = h + e, center = true);
        translate ([-l / 12, 0, w / 2 + 0.2 * spring_dia])
            rotate ([90, 0, 0])
                cylinder (r = spring_dia / 2, h = h + e, center = true);
        translate ([-spring_l -l / 12, 0, -w / 2])
            rotate ([90, 0, 0])
                cylinder (r = wire_dia / 2, h = h + e, center = true);
        translate ([0, 0, -l - w / 2])
            cube (2 * l, center = true);
        translate ([0, 0, l + w / 2])
            rotate ([0, -angle, 0])
                cube (2 * l, center = true);
    }
}

peg (72, 9.2, 6.5, 6.5, 17.5, 1.5, 1.8, false);
