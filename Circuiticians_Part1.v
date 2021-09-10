module breadboard	(w, x, y, z, r6, r7, r8, r9);  
input w, x, y, z;
output r6, r7, r8, r9;
reg r6, r7, r8, r9;

always @(w, x, y, z, r6, r7, r8, r9) begin
  
// f6 = w'x'y + w'x'z + xy'z + wx'y'z'
r6 = ((!w)&(!x)&y) | ((!w)&(!x)&z) | (x&(!y)&z) | (w&(!x)&(!y)&(!z));
// f7 = wxy'z' + w'xy'z + wx'y'z + w'x'yz + w'xyz' + wx'yz'
r7 =  (w&x&(!y)&(!z)) | ((!w)&x&(!y)&z) | (w&(!x)&(!y)&z) | ((!w)&(!x)&y&z) | ((!w)&x&y&(!z))) | (w&(!x)&y&(!z));
// f8 = yz
r8 = (y&z);
// f9 = w'x'y'z + w'x'yz' + w'xy'z' + w'xyz + wxy'z + wxyz' + wx'y'z' + wx'yz
r9 = ((!w)&(!x)&(!y)&z) | ((!w)&(!x)&y&(!z)) | ((!w)&x&(!y)&(!z)) | ((!w)&x&y&z) | (w&x&(!y)&z) | (w&x&y&(!z)) | (w&(!x)&(!y)&(!z)) | (w&(!x)&y&z);

end

endmodule                           


module testbench();

  // Main code goes here
  
  // Loop

  reg [3:0] i; // for looping from 0-15
  reg a, b, c, d; // for holding the bit values of i

  wire f6, f7, f8, f9; // hold function return values

  


endmodule 































//Dr. Becker's cheat sheet of what is wrong in the code.
//The loop control variable can never reach 16, it is only 4 bits. Add another bit
//There needs to be a time dealy, such a #5, inside the for loop
