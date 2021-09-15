/* Circuiticians - Project 1 Verilog Code
 
 Jacob Medel, Christopher Clark, Donavin Sip, Pranay Yadav, Carlos Moran, Antonio Ramaj
 
 CS 4341.001 Fall 2021 - University of Texas at Dallas
 */

//Define breadboard module
module Breadboard (w, x, y, z,
                   r1, r3, r5);
   
   //4 inputs, 3 outputs as memory registers
   input w, x, y, z;
   output r1, r3, r5; 
   reg    r1, r3, r5;                   

   //Always execute when any of the inputs change
   always @ (w, x, y, z,
             r1, r3, r5)         
      
     begin
        //Minimized functions
        r1 = y & z | w & x | z & x;
        r3 = y & x | w & z;        
        r5 = !w & !x | !y & !z;
        
     end // always @ (w, x, y, z,...
   
endmodule // Breadboard

module Testbench();
   //Define five bit wide counter and 4 local vars to be inputs
   reg [4:0] i;
   reg       a;
   reg       b;
   reg       c;
   reg       d;
   //Get output of Breadboard module
   wire      f1, f3, f5;                

   //Instantiate Breadboard calc w/ inputs and output wires
   Breadboard calc(a, b, c, d,
                   f1, f3, f5);   

   initial
     begin
        //Table header
        $display("_____________________");        
        $display("|##|A|B|C|D|F1|F3|F5|");
        $display("|--|-|-|-|-|--|--|--|");        
        
        
        for(i = 0; i < 16; i = i + 1)
          begin
             /*
              **NOTE**
              reg will be assigned the
              last bit of a multibit value, thus
              we are concerned only with shifting the bit
              we want to the end
              */
             //Assigns to a, b, c, d the 3d,2nd,1st, and 0th
             //bit of i by shifting said bit to the end
             a = i >> 3;
             b = i >> 2;
             c = i >> 1;
             d = i;

             //Delay
             #50;

             $display("|%2d|%1d|%1d|%1d|%1d|%2d|%2d|%2d|",             
                      i, a, b, c, d, f1, f3, f5);             
             //Seperate every 4th row
             if(i % 4 == 3)
               $display("|--|-|-|-|-|--|--|--|");             

          end // for (i = 0; i < 16; i = i + 1)
        
        //Delay
        #10;        
        
        $finish;
        
     end // initial begin

endmodule

