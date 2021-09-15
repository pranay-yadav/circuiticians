/*
 Circuiticians - Project Part 1 Verilog Code

 Jacob Medel, Christopher Clark, Donavin Sip, Pranay Yadav, Carlos Moran, Antonio Ramaj
 
 CS 4341.001 Fall 2021 - University of Texas at Dallas
 */

//Define breadboard module
module breadboard (w, x, y, z,
                   r0, r1, r2,
                   r3, r4, r5,
                   r6, r7, r8, r9);
   
   //4 inputs, 3 outputs as memory registers
   input w, x, y, z;
   output r0, r1, r2, r3, r4, r5, r6, r7, r8, r9;
   reg    r0, r1, r2, r3, r4, r5, r6, r7, r8, r9;

   //Always execute when inputs change
   always @(w, x, y, z, r0, r1, r2, r3, r4, r5, r6, r7, r8, r9) begin

      // f0 = wx + wz + xy + yz
      r0 = (w&x) | (w&z) | (x&y) | (y&z);
      // f1 = wx + xz + yz
      r1 = (w&x) | (x&z) | (y&z);
      // f2 = wxz + w'xyz + w'x'yz' + wx'yz
      r2 = (w&x&z) | (x&y&z) | (w&y&z) | (w&x&y);
      // f3 = wz + xy
      r3 = (w&z)|(x&y);
      // f4: yz
      r4 = (y&z);
      // f5: y'z' + w'x'
      r5 = ((!y)&(!z)) | ((!w)&(!x));
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
   reg       w, x, y, z; // for holding the bit values of i

   wire      f0, f1, f2, f3, f4, f5, f6, f7, f8, f9; // hold function return values

   breadboard zap(w, x, y, z, f0, f1, f2, f3, f4, f5, f6, f7, f8, f9);

   initial begin
      $display("|##|w|x|y|z|f0|f1|f2|f3|f4|f5|f6|f7|f8|f9|");
      $display("|========================================|");
      for (i = 0; i <= 15; i = i + 1) begin
         /*
          **NOTE**
          reg will be assigned the
          last bit of a multibit value, thus
          we are concerned only with shifting the bit
          we want to the end
          */
         
         //Assigns to a, b, c, d the 3d,2nd,1st, and 0th
         //bit of i by shifting said bit to the end
         w = i >> 3;       
         x = i >> 2;
         y = i >> 1;
         z = i;       

         #10; // time delay

         $display ("|%2d|%1d|%1d|%1d|%1d| %1d| %1d| %1d| %1d| %1d| %1d| %1d| %1d| %1d| %1d|", i, w, x, y, z, f0, f1, f2, f3, f4, f5, f6, f7, f8, f9);
         
         if(i % 4 == 3) 
	   $display ("|----------------------------------------|");

      end // end for loop
      #10;
      $finish;
   end // end intial


endmodule // end module testbench 
