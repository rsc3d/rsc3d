// Hat for hoperf LoRa module when iot4pi is connected to smaller
// banana-pi to prevent short-circuit
//

module hoprf_hat
    (hi=2, ho=3.2, xi=16.5, yi=19, xo=20, yo=22, dx=2, dy=0.5, hr=1.5)
{
    difference () {
        union () {
            cube ([xo, yo, ho]);
            translate ([(xo-xi)/2-dx, (yo-yi)/2+dy, 0])
                cylinder (r=hr, h=hi+ho);
        }
        translate ([(xo-xi)/2, (yo-yi)/2, ho-hi])
            cube ([xi, yi, ho]);
    }
}

xo=20;
translate ([0, 0, 0])
    hoprf_hat (xo=xo, $fa = 3, $fs = 0.5);
translate ([xo+3, 0, 0])
    hoprf_hat (xo=xo, $fa = 3, $fs = 0.5);

