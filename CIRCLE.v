
		/* CIRCLE */
		/* 	
			Pi = 314/100
			Circumference = 2 * pi * r
			Area = pi * r * r
		*/
		IN = 16'b0000000100111010; // 314
		OP = 4'b0010; // Add 0 + 314
		#60;
		IN = 16'b0000000001100100; // 100
		OP = 4'b0101; // Divide 314 / 100, store in pi
		#60;
		PI_3 = OUT;
		OP = 4'b1111; // RESET
		#60;
		
		IN = PI_3; 
		OP = 4'b0010; // Add 0 + Pi
		#60;
		IN = r;
		OP = 4'b0100; // Multiply Pi * r
		#60;
		IN = 16'b0000000000000010; // 2
		OP = 4'b0100; // Multiply 2 * Pi * r
		#60;
		CIRCUMFERENCE_3 = OUT;
		OP = 4'b1111; // RESET
		#60;

        IN = PI_3; 
		OP = 4'b0010; // Add 0 + Pi
		#60;
		IN = r;
		OP = 4'b0100; // Multiply Pi * r
		#60;
		IN = r; 
		OP = 4'b0100; // Multiply Pi * r * r
		#60;
		AREA_3 = OUT;
		OP = 4'b1111; // RESET
		#60;
	
	/* End CIRCLE */
