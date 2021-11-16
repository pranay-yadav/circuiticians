/* SPHERE / SA = 4* pi * r^2 / V = 4 * pi * r^3 / 3 */
	IN = 16'b0000000100111010; // 314
	OP = 4'b0010; // Add 0 + 314
	#60;
	IN = 16'b0000000001100100; // 100
	OP = 4'b0101; // Divide 314 / 100, store in pi
	#60;
	PI_5 = OUT;
	OP = 4'b1111; // RESET
	#60;
		
	IN = PI_5; 
	OP = 4'b0010; // Add pi
	#60;
	IN = r;
	OP = 4'b0100; // Multiply Pi * r
	#60;
	IN = r;
   	OP = 4'b0100; // Multiply Pi * r ^ 2
	#60;
	IN = 16'b0000000000000100; // 4
	OP = 4'b0100; // Multiply 4 * Pi * r ^ 2
	#60;
	SURFACEAREA_5 = OUT;
    OP = 4'b1111; // RESET
	#60;

    IN = PI_5; 
	OP = 4'b0010; // Add pi
	#60;
	IN = r;
	OP = 4'b0100; // Multiply Pi * r
	#60;
	IN = r; 
	OP = 4'b0100; // Multiply Pi * r ^ 2
	#60;
	IN = r; 
	OP = 4'b0100; // Multiply Pi * r ^ 3
	#60;
	IN = 16'b0000000000000100; // 4
	OP = 4'b0100; // Multiply 4 * Pi * r ^ 3
	#60;
	IN = 16'b0000000000000011; // 3
	OP = 4'b0101; // 4 * pi * r ^ 3 / 3
	#60;
	VOLUME_5 = OUT;
	OP = 4'b1111; // RESET
	#60;
	
	/* End SPHERE */