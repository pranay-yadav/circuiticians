module Breadboard	(w,x,y,z,r1,r2,r3); 
input w,x,y,z;                        
output r1,r2,r3;                      
reg r1, r2, r3;                       .

always @ ( w,x,y,z,r1,r2,r3) begin    
	
r1= (w&x)|(w&z)|(x&y)|(y&z);                     //Bitwise operation of the formula

r2= (y&z);

r3 = (((!w)&(!x)&(!y)&(z)) | ((!w)&(!x)&(y)&(!z)) 
    | ((!w)&(x)&(!y)&(!z)) | ((!w)&(x)&(y)&(z))
    | ((w)&(x)&(!y)&(z)) | ((w)&(x)&(y)&(!z))
    | ((w)&(!x)&(!y)&(!z)) | ((w)&(!x)&(y)&(z)));
end                                   // Finish the Always block

endmodule                             //Module End

//----------------------------------------------------------------------

module testbench();

  //Registers act like local variables
  reg [4:0] i; //A loop control for 16 rows of a truth table.
  reg  a;//Value of 2^3
  reg  b;//Value of 2^2
  reg  c;//Value of 2^1
  reg  d;//Value of 2^0
  
  wire  f0,f8,f9;
  
 
  Breadboard zap(a,b,c,d,f0,f8,f9);
  //FunctionOne zap2(b,c,d,a,f2);
     
	 
  
  initial begin
   	
	for (i = 0; i < 16; i = i + 1) 
	begin//Open the code blook of the for loop
		a=(i/8)%2;//High bit
		b=(i/4)%2;
		c=(i/2)%2;
		d=(i/1)%2;//Low bit	
		 
		//Oh, Dr. Becker, do you remember what belongs here? 
		#60;
		 	
		$display ("|%2d|%1d|%1d|%1d|%1d| %1d| %1d|",i,a,b,c,d,f1,f2,f3);
		if(i%4==3) //Every fourth row of the table, put in a marker for easier reading.
		 $display ("|--+-+-+-+-+--|--|--|");//Only one line, does not need a code block

	end//End of the for loop code block
 
  end  //End the code block of the main (initial)

