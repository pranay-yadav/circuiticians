module breadboard	(w, x, y, z, r0, r1, r2);  
	input w, x, y, z;
	output r0, r1, r2;
	reg r0, r1, r2;
	always @(w, x, y, z, r0, r1, r2) begin


	r0 = (y&z) | (w&x) | (w&z) | (x&y);

	r1 = (w&x) | (x&y) | (x&z);
	r2 = (w&x&z) | (w&x&y) | (x&y&z) | (w&y&z);
	
	end 
	
	endmodule
	
module testbench();

	reg [4:0] i;
	reg w, x, y, z;
	wire f0, f1, f2;
	
	breadboard zap (w, x, y, z, f0, f1, f2);
	
	initial begin
		$display("|##|w|x|y|z|f0|f1|f2|");
		$display("|===================|");
			for (i = 0; i <= 15; i = i + 1) begin
			  w = (i/8) % 2;
			  x = (i/4) % 2;
			  y = (i/2) % 2;
			  z = i % 2;
			  #10; // time delay
			  $display ("|%2d|%1d|%1d|%1d|%1d| %1d| %1d| %1d|", i, w, x, y, z, f0, f1, f2);
				  if(i%4==3) 
					$display ("|----------------------|");
			end // end for loop
		#10;
		$finish;
	end // end intial
endmodule