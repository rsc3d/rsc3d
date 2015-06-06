module oval(w, h, height, center = false)
{
    scale([1, h/w, 1]) cylinder(h=height, r=w, center=center);
}

module wallmount (inner_dia, screwdia, screwhead, headheight)
{
    h  = screwdia * 1.5;
    hh = headheight / 2;
    sr = screwdia / 2;
    sh = screwhead / 2;
    
    difference () {
        oval (inner_dia * 1.5, inner_dia, h, center = true);
        cylinder (r = inner_dia / 2, h = 2 * h, center = true);
        translate ([inner_dia, 0, 0])
            cylinder (r = sr, h = 2 * h, center = true, $fs = 0.1);
        translate ([inner_dia, 0, -hh + h / 2 + 0.01])
            cylinder (r1 = sr, r2 = sh, h = hh);
        translate ([-inner_dia, 0, 0])
            cylinder (r = sr, h = 2 * h, center = true, $fs = 0.1);
        translate ([-inner_dia, 0, -hh + h / 2 + 0.01])
            cylinder (r1 = sr, r2 = sh, h = hh);
    }
}

wallmount (21, 4.5, 8, 4.5);
