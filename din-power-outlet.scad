use <lib/arc.scad>

// see calculations in steckdose.wxm

module outside (da, dm, iw, th)
{
    // da: outer diameter
    // dm: medium diameter
    // iw: inner width
    // th: thickness
    a   = iw / 2;
    b   = (dm - da) / 2;
    r   = (b * b + a * a) / (2 * b);
    z   = da / 2;
    c   = z - a;
    phi = 2 * acos ((r - b) / r);
    m2  = -(a * z - a * r + a * b) / (r - b - a);
    r2  = sqrt (pow (z - m2, 2) + pow (a - m2, 2));
    alpha = acos ((pow (r2, 2) - pow (c, 2)) / pow (r2, 2));
    echo (a, m2, r2, alpha);
    echo (-(a - m2) / (z - m2));
    echo (a / (b - r));
    for (rot = [0, 90, 180, 270]) {
        rotate ([0, 0, rot]) {
            translate ([0, z + b - r, 0])
                arc (-phi / 2, phi, r, th, 10, $fa = 3);
            translate ([m2, m2, 0])
                arc (-(45 + alpha / 2 + 1), alpha + 2, r2, th, 10, $fa = 3);
        }
    }
}

outside (100.25, 106.5, 81.25, 2);
