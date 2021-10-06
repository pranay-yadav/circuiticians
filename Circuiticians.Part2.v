/*
	Circuiticians Project Part 2
	CS 4341.001 Fall 2021 - University of Texas at Dallas
	
	Authors: 
		Jacob Medel, Christopher Clark, Donavin Sip, Pranay Yadav, Carlos Moran, Antonio Ramaj
	
*/



// Half Adder
module HalfAdder(a, b, carry, sum);

endmodule


// Full Adder
module FullAdder(a, b, carry, sum);
	
endmodule

// Adder-Subtractor
module AddSub(IN1, IN2, M, S, CAR, OVF);

endmodule

// Multiplication
module Mul(IN1, IN2, P);

endmodule

// Division
module Div(IN1, IN2, Q, DE);

endmodule

// Modulo
module Mod(IN1, IN2, R, ME)

endmodule

// Decoder
module Dec(OP, SEL);
	input [3:0] OP;
	output [15:0] SEL;

	// 4x16 One-hot Decoder
	assign SEL[ 0]=~OP[3]&~OP[2]&~OP[1]&~OP[0];
	assign SEL[ 1]=~OP[3]&~OP[2]&~OP[1]& OP[0];
	assign SEL[ 2]=~OP[3]&~OP[2]& OP[1]&~OP[0];
	assign SEL[ 3]=~OP[3]&~OP[2]& OP[1]& OP[0];
	assign SEL[ 4]=~OP[3]& OP[2]&~OP[1]&~OP[0];
	assign SEL[ 5]=~OP[3]& OP[2]&~OP[1]& OP[0];
	assign SEL[ 6]=~OP[3]& OP[2]& OP[1]&~OP[0];
	assign SEL[ 7]=~OP[3]& OP[2]& OP[1]& OP[0];
	assign SEL[ 8]= OP[3]&~OP[2]&~OP[1]&~OP[0];
	assign SEL[ 9]= OP[3]&~OP[2]&~OP[1]& OP[0];
	assign SEL[10]= OP[3]&~OP[2]& OP[1]&~OP[0];
	assign SEL[11]= OP[3]&~OP[2]& OP[1]& OP[0];
	assign SEL[12]= OP[3]& OP[2]&~OP[1]&~OP[0];
	assign SEL[13]= OP[3]& OP[2]&~OP[1]& OP[0];
	assign SEL[14]= OP[3]& OP[2]& OP[1]&~OP[0];
	assign SEL[15]= OP[3]& OP[2]& OP[1]& OP[0];

endmodule

// Multiplexer
module Mux(channels, SEL, OUT);

endmodule


module BreadBoard(IN1, IN2, OP, OUT, ERR);

endmodule


module TestBench();
 
endmodule  