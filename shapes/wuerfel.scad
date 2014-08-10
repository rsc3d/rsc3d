module mycube()
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

mycube();
