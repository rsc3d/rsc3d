$fn = 100;

module rounded (x, y, h, d)
{
    minkowski()
    {
        cube ([x - d, y - d, h / 2], center = true);
        cylinder (r = d / 2, h = h / 2, center = true);
    }
}

module cyl (d, w, dia)
{
    translate ([0, 0, (d - w) / 2])
        rotate ([0, 90, 0])
            cylinder (r = d / 2, h = dia + 1, center = true);
}

module mousering (d_o, d_i, d_m, h, w1, w2, w3, m, n)
{
    dia = 2 * m + d_m - 2 * w2;
    wx  = w1 - w3;
    difference () {
        union () {
            union () {
                cylinder (r = d_o / 2 - wx, h = w1);
                translate ([0, 0, wx])
                    cylinder (r = d_o / 2, h = w3);
            }
            cylinder (r = d_m / 2, h = h);
            translate ([0, 0, h - w3 / 2])
                intersection () {
                    rounded (dia, n, w3, n / 2);
                    cylinder (r = dia / 2, h = w3 + 1, center = true);
                    cyl (2 * d_o, w3, dia);
                }
        }
        cylinder (r = d_i / 2, h = 3 * h, center = true);
        translate ([0, 0, w1])
            cylinder (r = (d_m - w2) / 2, h = h);
        cylinder (r = d_i / 2 + wx, h = 2 * wx, center = true);
        for (i = [-5:5]) {
            translate ([i * 2 * 0.7, 0, 0])
                cube ([0.7, 2 * d_o, 2 * wx], center = true);
        }
    }
    translate ([-dia / 2 + 0.5, 0, 0])
        cylinder (r = 0.7, h = h);
    translate ([-dia / 2 + 1, n / 3, 0])
        cylinder (r = 0.7, h = h);
    translate ([-dia / 2 + 1, -n / 3, 0])
        cylinder (r = 0.7, h = h);
    translate ([ dia / 2 - 0.5, 0, 0])
        cylinder (r = 0.7, h = h);
    translate ([ dia / 2 - 1, n / 3, 0])
        cylinder (r = 0.7, h = h);
    translate ([ dia / 2 - 1, -n / 3, 0])
        cylinder (r = 0.7, h = h);
}

mousering (34.5, 15, 22, 4.35, 1.7, 1, 1.2, 4.5, 10);
