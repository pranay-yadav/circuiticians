module breadboard	(w, x, y, z, r6, r7, r8, r9);  
input w, x, y, z;
output r6, r7, r8, r9;
reg r6, r7, r8, r9;

always @(w, x, y, z, r6, r7, r8, r9) begin
  
// f6 = w'x'y + w'x'z + xy'z + wx'y'z'
r6 = ((!w)&(!x)&y) | ((!w)&(!x)&z) | (x&(!y)&z) | (w&(!x)&(!y)&(!z));
// f7 = wxy'z' + w'xy'z + wx'y'z + w'x'yz + w'xyz' + wx'yz'
r7 = (w&x&(!y)&(!z)) | ((!w)&x&(!y)&z) | (w&(!x)&(!y)&z) | ((!w)&(!x)&y&z) | ((!w)&x&y&(!z)) | (w&(!x)&y&(!z));
// f8 = yz
r8 = (y&z);
// f9 = w'x'y'z + w'x'yz' + w'xy'z' + w'xyz + wxy'z + wxyz' + wx'y'z' + wx'yz
r9 = ((!w)&(!x)&(!y)&z) | ((!w)&(!x)&y&(!z)) | ((!w)&x&(!y)&(!z)) | ((!w)&x&y&z) | (w&x&(!y)&z) | (w&x&y&(!z)) | (w&(!x)&(!y)&(!z)) | (w&(!x)&y&z);

end

endmodule                           


module testbench();

  // Main code goes here
  
  // Loop

  reg [4:0] i; // for looping from 0-15
  reg w, x, y, z; // for holding the bit values of i

  wire f6, f7, f8, f9; // hold function return values

  breadboard zap(w, x, y, z, f6, f7, f8, f9);

  initial begin
    $display("|##|w|x|y|z|f6|f7|f8|f9|");
    $display("|======================|");

    for (i = 0; i <= 15; i = i + 1) begin
      w = (i/8) % 2;
      x = (i/4) % 2;
      y = (i/2) % 2;
      z = i % 2;

      #10; // time delay

      $display ("|%2d|%1d|%1d|%1d|%1d| %1d| %1d| %1d| %1d|", i, w, x, y, z, f6, f7, f8, f9);
		  if(i%4==3) 
		    $display ("|----------------------|");

    end // end for loop
    #10;
    $finish;
  end // end intial


endmodule // end module testbench 































//Dr. Becker's cheat sheet of what is wrong in the code.
//The loop control variable can never reach 16, it is only 4 bits. Add another bit
//There needs to be a time dealy, such a #5, inside the for loop
