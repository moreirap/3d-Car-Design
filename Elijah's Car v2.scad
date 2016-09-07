//Quick 3D car body design
//The dimensions of the side view must fit in a bounding
//box 100mm wide by 24.1
//The dimensions of the front view must fit in a bounding
//box 50mm wide by 24.1 
Body_length = 100;
Body_width = 50;
Body_thickness = 2;												//Thickness of car walls
Scale = .32;													//scale model from 0.5 to 2
Xscale = (Body_length-2*Body_thickness/Scale)/100;		        //Car wall thickness calculations
Yscale = (Body_length-Body_thickness/Scale)/100;
Zscale = (Body_length-4*Body_thickness/Scale)/100;

echo("Xscale = ",Xscale);
echo("Yscale = ",Yscale);
echo("Zscale = ",Zscale);

module body()
{
    difference() 
    {
        intersection() {
            linear_extrude (height=Body_width)
            import(file = "side.dxf");
        
            rotate([0,90,0])translate([-Body_width,0,0])
            linear_extrude (height=Body_length)
            import(file = "front.dxf");
        }
    }
}

module car()
{
    union() {
        difference(){
            // Add main car body
            body();
           
            // Remove interior to make it hollow
            translate([Body_thickness/Scale,0,Body_thickness/Scale]) 
            scale([Xscale,Yscale,Zscale])body();
            //add windows
            linear_extrude (height=50) import(file = "side_windows.dxf");
          
            // Add logo
            rotate([0,270,0])
            translate([0,15.6,-7])
            scale([.25,.15,.2])
            linear_extrude (height=Body_length+20)
            import(file = "logojaguar.dxf");
        }
    }
}

translate([-7,-14,-5])rotate([90,0,90])scale([Scale,Scale,Scale])car();


// Draw main body of the car


// Draw the 2 wheel holders
DrawHolder(-10.2);
DrawHolder(13.2);

// Draw 4 wheels
// left
DrawWheel(11,-10,1);
DrawWheel(11,13.2,1);
//right
DrawWheel(-8.7,-10,-1);
DrawWheel(-8.7,13.2,-1);


// Modules

module DrawHolder(y)
{    
    // wheel holder
    translate([-8.7,y,2.7]) {
        rotate([0,90,0]) {
        cylinder(h=20, r=1, $fn=100,center=false);
        }
    }
}  

module DrawWheel(a,b,c)
{
    translate([a,b,2.5]) {
     rotate([0,90,0]) {
        color("black") {cylinder(h=3, r=3, $fn=100, center=true);}
     }
    }
    translate([a+c,b,2.5]) {
     rotate([0,90,0]) {
        color("grey")  {cylinder(h=1, r=1, $fn=100, center=true);}
     }
    }
}