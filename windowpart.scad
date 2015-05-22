$fn = 50;
// l: length of the gap
// lower wall is l + corr long, higher wall is l + corr + ld long
// w is half the width of the whole part but it extends below with
// half-circles, the circle radius of that circle is
// circ_r / 2 = w / 4
// th is the thickness of the wall, gp is the thickness of the ground
// plane. The heights of h1 and h2 are the whole wall height and the
// lower (less long) part h2. Finally gw is the gap width (minus half
// the wall width).

module wpart (l, corr, ld, w, th, gp, h1, h2, gw)
{
    circ_r = w / 2;
    difference () {
        union () {
            cube ([l, w, gp], center = true);
            translate ([ l / 2, 0 , 0])
                cylinder (r = circ_r, h = gp, center = true);
            translate ([-l / 2, 0 , 0])
                cylinder (r = circ_r, h = gp, center = true);
            translate ([0, 0, (h1 + 1) / 2])
                cube ([l + corr, th, h1 + 1], center = true);
            translate ([0, 0, (h1 - h2) / 2 + gp / 2 + h2])
                cube ([l + ld + corr, th, h1 - h2], center = true);
        }
        difference () {
            union () {
                translate ([0, -gw / 2, 0])
                    cube ([l - corr - circ_r, gw, 2 * gp], center = true);
                translate ([ (l - corr) / 2 - gw, 0, 0])
                    cylinder (r = gw, h = 2 * gp, center = true);
                translate ([-(l - corr) / 2 + gw, 0, 0])
                    cylinder (r = gw, h = 2 * gp, center = true);
            }
            translate ([0, l / 2 - th / 2, 0]) cube (l, center = true);
        }
        translate ([0, w / 2 + th / 2, 0])
            cube ([2 * l, w, 2 * gp], center = true);
    }
    translate ([ l / 2 + circ_r / 2, circ_r / 2, 0])
        cube ([circ_r, circ_r, gp], center= true);
    translate ([ l / 2 + circ_r / 2, circ_r, 0])
        cylinder (r = circ_r / 2, h = gp, center = true);
    translate ([-l / 2 - circ_r / 2, circ_r / 2, 0])
        cube ([circ_r, circ_r, gp], center= true);
    translate ([-l / 2 - circ_r / 2, circ_r, 0])
        cylinder (r = circ_r / 2, h = gp, center = true);
}

wpart (30, 0.5, 1, 10, 1.4, 2, 7, 2.7, 2.5);
