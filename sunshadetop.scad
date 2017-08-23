module umbrella_top (d = 24, hi = 20, w = 4)
{
    difference () {
        cylinder (r = d/2 + w, h=hi + w);
        translate ([0, 0, w + 0.01])
            cylinder (r = d/2, h=hi);
    }
}

umbrella_top ($fa = 1, $fs = .5);
