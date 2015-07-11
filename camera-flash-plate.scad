module plate (w, h, d, w2, h2, d2, r)
{
    cube ([w, d, h]);
    translate ([-(w2 - w) / 2, 0, 0])
        cube ([w2, d2, h2]);
}

plate (18.5, 2, 16, 22, 4, 3, 1.5);
