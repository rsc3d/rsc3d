include <tux.scad>

e       = 0.01; // Epsilon
euro_1  = 23.3;
euro_2  = 25.8;
cent_50 = 24.4;
module cart_unlock (w=euro_1, w2=18.5, l1=12, h=2.5, l=3*euro_1, hd = 6)
{
    // Width:  402.10078
    // Height: 425.68005
    sc  = (w + 2 * w2) / 3 / 425.69;
    hsc = 2/3;
    difference () {
        union () {
            hull () {
                cylinder (r = w / 2, h = h);
                translate ([0, l - w - l1, 0])
                    cylinder (r = w2 / 2, h = h);
            }
            hull () {
                translate ([0, l - w - l1, 0])
                    cylinder (r = w2 / 2, h = h);
                translate ([0, l - w, 0])
                    cylinder (r = w / 2, h = h);
            }
        }
        translate ([0, -w/4, -h])
            cylinder (r = hd/2, h=3*h);
    }
    translate ([0, 0.5*w, h-e])
        scale ([sc, sc, hsc]) {
            rotate ([0, 0, 180])
                tux (h);
        }
}

cart_unlock ($fa=3, $fs=0.5);
