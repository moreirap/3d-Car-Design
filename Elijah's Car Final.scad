//Quick 3D car body design
//The dimensions of the side view must fit in a bounding
//box 100mm wide by 24.1
//The dimensions of the front view must fit in a bounding
//box 50mm wide by 24.1 
Body_length = 100;
Body_width = 50;
Body_thickness = 6;												//Thickness of car walls
Scale = 1;													//scale model from 0.5 to 2
Xscale = (Body_length-2*Body_thickness/Scale)/100;		        //Car wall thickness calculations
Yscale = (Body_length-Body_thickness/Scale)/100;
Zscale = (Body_length-4*Body_thickness/Scale)/100;

Holders_Offset = 12;

// Draw main body of the car
translate([0,0,-15]) rotate([90,0,90])scale([Scale,Scale,Scale])car();

// Draw the 2 wheel holders and 4 wheels

DrawHolder(Holders_Offset);
DrawWheel(-5,Holders_Offset);
DrawWheel(Body_width + 5,Holders_Offset);    

DrawHolder(Body_length-Holders_Offset);
DrawWheel(-5,Body_length - Holders_Offset);
DrawWheel(Body_width + 5,Body_length - Holders_Offset);

// Modules

module body()
{
    intersection() {
        linear_extrude (height=Body_width)
        import(file = "side.dxf");
    
        rotate([0,90,0])translate([-Body_width,0,0])
        linear_extrude (height=Body_length)
        import(file = "front.dxf");
   }
}

module car()
{    
    difference(){
        // Add main car body
        body();
       
        // Remove interior to make it hollow
        //translate([Body_thickness/Scale,0,Body_thickness/Scale]) 
        //scale([Xscale,Yscale,Zscale])body();
        
        //add windows
        linear_extrude (height=50) 
        import(file = "side_windows.dxf");
        
        // add Wheels holes
       translate([Holders_Offset,24,-8])rotate([0,0,0])cylinder(h=60,r= 3.5,$fn=100);
       translate([Body_length - Holders_Offset,24,-8])rotate([0,0,0])cylinder(h=60,r= 3.5,$fn=100);  
    }
    
}

module DrawHolder(y)
{    
    // wheel holder
    translate([-5,y,9.5]) {
        rotate([0,90,0]) {
        cylinder(h=Body_width+10, r=3, $fn=100,center=false);
        }
    }
}  

module DrawWheel(a,b)
{
    translate([a,b,9.5]) {
     rotate([0,90,0]) {
        color("black") {
            cylinder(h=5, r=8, $fn=100, center=true);
        }
     }
    }
}