module breadboard	(w, x, y, z, r4, r5, r6);  
input w, x, y, z;
output r4, r5, r6;
reg r4, r5, r6;

  always @ (w, x, y, z, r4, r5, r6) begin

// f4: yz
r4 = (y&z);

// f5: y'z' + w'x'
r5 = ((!y)&(!z)) | ((!w)&(!x));

// f6: w'x'z + w'x'y + xy'z + wx'y'z' [OR] w'y'z + w'x'y + xy'z + wx'y'z'
r6 = ((!w)&(!x)&z) | ((!w)&(!x)&y) | (x&(!y)&z) | (w&(!x)&(!y)&(!z));

end

endmodule                           


module testbench();

  // Main code goes here
  
  // Loop

  reg [4:0] i;		// for looping from 0-15
  reg w, x, y, z; 	// for holding the bit values of i

  wire f4, f5, f6;	// hold function return values

  breadboard zap(w, x, y, z, f2, f3, f4, f7);

  initial begin
    $display("|##|w|x|y|z|f4|f5|f6|");
    $display("|===================|");

    for (i = 0; i <= 15; i = i + 1) begin
      w = (i/8) % 2;
      x = (i/4) % 2;
      y = (i/2) % 2;
      z = i % 2;

      #10; // time delay

      $display ("|%2d|%1d|%1d|%1d|%1d| %1d| %1d| %1d| %1d|", i, w, x, y, z, f4, f5, f6);
		  if(i%4==3) 
		    $display ("|-------------------|");

    end // end for loop
    #10;
    $finish;
  end // end intial


endmodule // end module testbench 