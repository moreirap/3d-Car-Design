Body_width = 50;

module step1()
{ 
	color("silver") {
        linear_extrude (height=Body_width)
        import(file = "grelha.dxf");
    }
}

step1();

