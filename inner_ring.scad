module ring (ro = 66.5/2, w = 4, h = 23)
{
    difference () {
        cylinder (h = h, r = ro);
        translate ([0, 0, -h])
            cylinder (h = 3 * h, r = ro - w);
    }
}

ring ($fa = 2, $fs = .5);
