module bracket (l=15, w=12, t=2, d=3.2)
{
    difference () {
        cube ([l, l, w]);
        translate ([t, t, -w])
            cube ([l, l, 3*w]);
        translate ([l/2, 2*t, w/2])
            rotate ([90, 0, 0])
                cylinder (r=d/2, h=3*t);
        translate ([-t, l/2, w/2])
            rotate ([0, 90, 0])
                cylinder (r=d/2, h=3*t);
    }
}

for (k = [0 : 4 : 3*4 - 1])
    translate ([k, k, 0])
        bracket ($fa=3, $fs=0.5);
