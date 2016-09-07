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
    union() {
        //intersection(){	
            //linear_extrude (height=Body_width)
            //import(file = "side.dxf");
            
            union() {
                rotate([0,90,0])translate([-Body_width,0,0])
                linear_extrude (height=Body_length)
                import(file = "front.dxf");                
                
                translate([-Body_width,0,0])
                cube(10);
                
                #rotate([0,90,0])
                translate([-Body_width,20,-10])
                scale([.25,.25,1])
                linear_extrude (height=Body_length+20)
                import(file = "logojaguar.dxf");
            }
       // }
    }
}

module car()
{
    union() {
        difference(){
            body();
            //Hollow body out
            translate([Body_thickness/Scale,0,Body_thickness/Scale]) 
            scale([Xscale,Yscale,Zscale])body();
            //add windows and wheel wells
            linear_extrude (height=50) import(file = "side_windows.dxf");
            rotate([0,90,0])translate([50,0,0])cylinder(h=24,r= 1,$fn=100);
            translate([12,24,-8])rotate([0,0,0])cylinder(h=60,r= 3.5,$fn=100);
            translate([85,24,-8])rotate([0,0,0])cylinder(h=60,r= 3.5,$fn=100);       
        }
        color("red") {
            rotate([-10,-90,0])
            translate([-1,15,-1]) 
            scale([.25,.25,.1])
            import(file = "logojaguar.stl");
        }
    }
}
body();

//translate([-7,-14,-5])rotate([90,0,90])scale([Scale,Scale,Scale])car();


// Draw main body of the car


// Draw the 2 wheel holders
//DrawHolder(-10.2);
//DrawHolder(13.2);
//
//// Draw 4 wheels
//// left
//DrawWheel(11,-10,1);
//DrawWheel(11,13.2,1);
////right
//DrawWheel(-8.7,-10,-1);
//DrawWheel(-8.7,13.2,-1);


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