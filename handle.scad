module two_tangent_cube (h, x1, y1, r1, x2, y2, r2)
{
    // http://en.wikipedia.org/wiki/Tangent_lines_to_circles
    d = sqrt (pow (x1 - x2, 2) + pow (y1 - y2, 2));
    X = (x2 - x1) / d;
    Y = (y2 - y1) / d;
    R = (r2 - r1) / d;
    a1_1 = R * Y + X * sqrt (1 - R * R);
    b1_1 = R * X - Y * sqrt (1 - R * R);
    c1_1 = r1 - (a1_1 * x1 + b1_1 * y1);
    k1 = - (a1_1 / b1_1);
    echo (a1_1, b1_1, c1_1, k1, 1 / k1);
    phi1 = atan (k1);
    echo (phi1);
    a1_2 = R * Y - X * sqrt (1 - R * R);
    b1_2 = R * X + Y * sqrt (1 - R * R);
    c1_2 = r1 - (a1_2 * x1 + b1_2 * y1);
    k2 = - (a1_2 / b1_2);
    echo (a1_2, b1_2, c1_2, k2, 1 / k2);
    phi2 = atan (k2);
    echo (phi2);
    //echo (asin (sqrt (1 - R*R)));
    a2_1 = a1_1;
    b2_1 = b1_1;
    c2_1 = r2 - (a1_1 * x2 + b1_1 * y2);

    zz1_1  =
        (
        - b1_1 * b1_1 * y1 * y1
        - a1_1 * a1_1 * x1 * x1
        - 2 * a1_1 * b1_1 * x1 * y1
        - 2 * b1_1 * c1_1 * y1
        - 2 * a1_1 * c1_1 * x1
        + (a1_1 * a1_1 + b1_1 * b1_1) * r1 * r1
        - c1_1 * c1_1
        );
    echo (zz1_1);
    z1_1 = sqrt (abs (zz1_1) < 1e-9 ? 0 : zz1_1);
    xt1_1 = - ( b1_1 * z1_1 + a1_1 * b1_1 * y1 - b1_1 * b1_1 * x1 + a1_1 * c1_1)
            / (b1_1 * b1_1 + a1_1 * a1_1);
    yt1_1 =   ( a1_1 * z1_1 + a1_1 * a1_1 * y1 - a1_1 * b1_1 * x1 - b1_1 * c1_1)
            / (b1_1 * b1_1 + a1_1 * a1_1);
    echo (xt1_1, yt1_1);
    zz1_2  = 
        (
        - b1_2 * b1_2 * y1 * y1
        - a1_2 * a1_2 * x1 * x1
        - 2 * a1_2 * b1_2 * x1 * y1
        - 2 * b1_2 * c1_2 * y1
        - 2 * a1_2 * c1_2 * x1
        + (a1_2 * a1_2 + b1_2 * b1_2) * r1 * r1
        - c1_2 * c1_2
        );
    echo (zz1_2);
    z1_2 = sqrt (abs (zz1_2) < 1e-9 ? 0 : zz1_2);
    xt1_2 = - ( b1_2 * z1_2 + a1_2 * b1_2 * y1 - b1_2 * b1_2 * x1 + a1_2 * c1_2)
            / (b1_2 * b1_2 + a1_2 * a1_2);
    yt1_2 =   ( a1_2 * z1_2 + a1_2 * a1_2 * y1 - a1_2 * b1_2 * x1 - b1_2 * c1_2)
            / (b1_2 * b1_2 + a1_2 * a1_2);
    echo (xt1_2, yt1_2);
    zz2_1  =
        (
        - b2_1 * b2_1 * y2 * y2
        - a2_1 * a2_1 * x2 * x2
        - 2 * a2_1 * b2_1 * x2 * y2
        - 2 * b2_1 * c2_1 * y2
        - 2 * a2_1 * c2_1 * x2
        + (a2_1 * a2_1 + b2_1 * b2_1) * r2 * r2
        - c2_1 * c2_1
        );
    echo (zz2_1);
    z2_1 = sqrt (abs (zz2_1) < 1e-9 ? 0 : zz2_1);
    xt2_1 = - ( b2_1 * z2_1 + a2_1 * b2_1 * y2 - b2_1 * b2_1 * x2 + a2_1 * c2_1)
            / (b1_1 * b1_1 + a1_1 * a1_1);
    yt2_1 =   ( a2_1 * z2_1 + a2_1 * a2_1 * y2 - a2_1 * b2_1 * x2 - b2_1 * c2_1)
            / (b2_1 * b2_1 + a2_1 * a2_1);
    echo (xt2_1, yt2_1);
    kl = sqrt (pow (xt1_1 - xt2_1, 2) + pow (yt1_1 - yt2_1, 2));
    intersection () {
        translate ([xt1_1, yt1_1, 0])
            rotate ([0, 0, phi1 + 270])
                cube ([kl, kl, h]);
        translate ([xt1_2, yt1_2, 0])
            rotate ([0, 0, phi2])
                cube ([kl, kl, h]);
    }
}

module handle (ri1, ro1, h1, ri2, ro2, h2, len)
{
    l = len - ro1 - ro2;
    difference () {
        cylinder (r = ro1, h = h1);
        translate ([0, 0, -h1 / 2]) cylinder (r = ri1, h = 2 * h1);
    }
    translate ([l, 0, 0]) {
        difference () {
            cylinder (r = ro2, h = h2);
            translate ([0, 0, -h2 / 2]) cylinder (r = ri2, h = 2 * h2);
        }
    }
    two_tangent_cube (h1, 0, 0, ro1, 0, l, ro2);
}

handle (15 / 2, 27 / 2, 16, 21 / 2, 40 / 2, 39, 192 + 30);
