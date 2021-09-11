module breadboard	(w, x, y, z, r2, r3, r4, r7);  
input w, x, y, z;
output r2, r3, r4, r7;
reg r2, r3, r4, r7;

  always @(w, x, y, z, r2, r3, r4, r7) begin
  

r2 = (w&x&z) | (x&y&z) | (w&y&z) | (w&x&y);
 r3 = (w&z)|(x&y);

r4 = (y&z);

r7 = (w&x&(!y)&(!z)) | ((!w)&x&(!y)&z) | (w&(!x)&(!y)&z) | ((!w)&(!x)&y&z) | ((!w)&x&y&(!z)) | (w&(!x)&y&(!z));

end

endmodule                           


module testbench();

  // Main code goes here
  
  // Loop

  reg [4:0] i; // for looping from 0-15
  reg w, x, y, z; // for holding the bit values of i

  wire f2, f3, f4, f7; // hold function return values

  breadboard zap(w, x, y, z, f2, f3, f4, f7);

  initial begin
    $display("|##|w|x|y|z|f2|f3|f4|f7|");
    $display("|======================|");

    for (i = 0; i <= 15; i = i + 1) begin
      w = (i/8) % 2;
      x = (i/4) % 2;
      y = (i/2) % 2;
      z = i % 2;

      #10; // time delay

      $display ("|%2d|%1d|%1d|%1d|%1d| %1d| %1d| %1d| %1d|", i, w, x, y, z, f2, f3, f4, f7);
		  if(i%4==3) 
		    $display ("|----------------------|");

    end // end for loop
    #10;
    $finish;
  end // end intial


endmodule // end module testbench 
