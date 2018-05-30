d2=65;

module roleholder (d1=28, d2=d2, di=13, h=40)
{
    difference () {
        cylinder (r1=d2/2, r2=d1/2, h=h);
        cylinder (r=di/2, h=3*h, center=true);
    }
}

roleholder ($fa=3, $fs=.05);
translate ([d2+5, 0, 0])
    roleholder ($fa=3, $fs=.05);
