void () Climb =
{
local vector spot;
        makevectors (self.v_angle);
        spot=self.origin+v_forward*48+'0 0 16';
        if(pointcontents(spot)==CONTENT_SOLID)
        {
        if(self.climbing==FALSE)
                centerprint(self,"Climbing Mode\n");
        self.climbing=TRUE;
        self.wallspot=spot;
        }
        self.button2=0;
};

void() ClimbDrop=
{
        centerprint(self,"Jumping Mode\n");
        self.climbing=FALSE;
        self.velocity_z = self.velocity_z + self.jumphite*54/self.mass;
        self.velocity=self.velocity + v_forward*100;
};
