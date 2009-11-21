
module test004b()
{
    difference ()
    {
        cube (20, center = true);
        difference ()
        {
            cube (40, center = true);
            sphere (13);
        }
    }
}

test004b();

