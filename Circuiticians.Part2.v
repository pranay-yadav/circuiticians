/*
	Circuiticians Project Part 2
	CS 4341.001 Fall 2021 - University of Texas at Dallas
	
	Authors: 
		Jacob Medel, Christopher Clark, Donavin Sip, Pranay Yadav, Carlos Moran, Antonio Ramaj
	
*/



// Half Adder
module HalfAdder(a, b, carry, sum);
	input a;
	input b;

	output carry;
	output sum;

	reg carry;
	reg sum;
	
	always @(*) begin
	  sum = a^b; // XOR
	  carry = a&b; // Carry bit
	end

endmodule


// Full Adder
module FullAdder(a, b, carry_in, carry_out, sum);
	input a;
	input b;
	input carry_in;
	
	output carry_out;
	output sum;

	reg carry_out;
	reg sum;
	// Interfaces that connect Half-adders
	wire c0;
	wire c1;
	wire s0;
	wire s1;
	// Half Adders
	HalfAdder H0(a, b, c0, s0);
	HalfAdder H1(s0, carry_in, c1, s1);

	always @(*) begin
	  sum = s1;
	  carry_out = c1|c0;
	end

endmodule

// Adder-Subtractor
module AddSub(IN1, IN2, M, S, CAR, OVF);
	input [15:0] IN1; // input 1
	input [15:0] IN2; // input 2
	input M; // mode

	output [31:0] S; // sum
	output CAR; // carry
	output OVF; // overflow

	// Sign-extended inputs
	wire [31:0] eIN1;
	wire [31:0] eIN2;
	assign eIN1 = {{16{IN1[15]}}, IN1}; // sign extend IN1 to 32-bits
	assign eIN2 = {{16{IN2[15]}}, IN2}; // sign extend IN2 to 32-bits

	// Interfaces between Full Adders
	wire [32:0] c; // carries
	assign c[0] = M; // Mode bit serves as initial carry

	// Full Adders
	FullAdder F0 (eIN1[ 0], eIN2[ 0]^M, c[ 0], c[ 1], S[ 0]);
	FullAdder F1 (eIN1[ 1], eIN2[ 1]^M, c[ 1], c[ 2], S[ 1]);
	FullAdder F2 (eIN1[ 2], eIN2[ 2]^M, c[ 2], c[ 3], S[ 2]);
	FullAdder F3 (eIN1[ 3], eIN2[ 3]^M, c[ 3], c[ 4], S[ 3]);
	FullAdder F4 (eIN1[ 4], eIN2[ 4]^M, c[ 4], c[ 5], S[ 4]);
	FullAdder F5 (eIN1[ 5], eIN2[ 5]^M, c[ 5], c[ 6], S[ 5]);
	FullAdder F6 (eIN1[ 6], eIN2[ 6]^M, c[ 6], c[ 7], S[ 6]);
	FullAdder F7 (eIN1[ 7], eIN2[ 7]^M, c[ 7], c[ 8], S[ 7]);
	FullAdder F8 (eIN1[ 8], eIN2[ 8]^M, c[ 8], c[ 9], S[ 8]);
	FullAdder F9 (eIN1[ 9], eIN2[ 9]^M, c[ 9], c[10], S[ 9]);
	FullAdder F10(eIN1[10], eIN2[10]^M, c[10], c[11], S[10]);
	FullAdder F11(eIN1[11], eIN2[11]^M, c[11], c[12], S[11]);
	FullAdder F12(eIN1[12], eIN2[12]^M, c[12], c[13], S[12]);
	FullAdder F13(eIN1[13], eIN2[13]^M, c[13], c[14], S[13]);
	FullAdder F14(eIN1[14], eIN2[14]^M, c[14], c[15], S[14]);
	FullAdder F15(eIN1[15], eIN2[15]^M, c[15], c[16], S[15]);
	FullAdder F16(eIN1[16], eIN2[16]^M, c[16], c[17], S[16]);
	FullAdder F17(eIN1[17], eIN2[17]^M, c[17], c[18], S[17]);
	FullAdder F18(eIN1[18], eIN2[18]^M, c[18], c[19], S[18]);
	FullAdder F19(eIN1[19], eIN2[19]^M, c[19], c[20], S[19]);
	FullAdder F20(eIN1[20], eIN2[20]^M, c[20], c[21], S[20]);
	FullAdder F21(eIN1[21], eIN2[21]^M, c[21], c[22], S[21]);
	FullAdder F22(eIN1[22], eIN2[22]^M, c[22], c[23], S[22]);
	FullAdder F23(eIN1[23], eIN2[23]^M, c[23], c[24], S[23]);
	FullAdder F24(eIN1[24], eIN2[24]^M, c[24], c[25], S[24]);
	FullAdder F25(eIN1[25], eIN2[25]^M, c[25], c[26], S[25]);
	FullAdder F26(eIN1[26], eIN2[26]^M, c[26], c[27], S[26]);
	FullAdder F27(eIN1[27], eIN2[27]^M, c[27], c[28], S[27]);
	FullAdder F28(eIN1[28], eIN2[28]^M, c[28], c[29], S[28]);
	FullAdder F29(eIN1[29], eIN2[29]^M, c[29], c[30], S[29]);
	FullAdder F30(eIN1[30], eIN2[30]^M, c[30], c[31], S[30]);
	FullAdder F31(eIN1[31], eIN2[31]^M, c[31], c[32], S[31]);

	// other outputs
	assign CAR = c[32];
	assign OVF = c[32] ^ c[31]; // if last two carries are different, then there was overflow

endmodule

/*
// Multiplication
module Mul(IN1, IN2, P);
	input [15:0] IN1; // input 1
	input [15:0] IN2; // input 2
	output [31:0] P; // product of IN1 * IN2

	

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
*/

module BreadBoard(IN1, IN2, OP, OUT, ERR);
	input [15:0] IN1;
	input [15:0] IN2;
	input [3:0] OP;
	output [31:0] OUT;
	output [1:0] ERR;

	// Wires and Registers
	wire [15:0] IN1;
	wire [15:0] IN2;
	wire [3:0] OP;
	reg [31:0] OUT;
	reg [1:0] ERR;


	//AddSub Variables
	reg M;
	wire [31:0] S;
	wire CAR;
	wire OVF;

	AddSub adder(IN1, IN2, M, S, CAR, OVF);
	
	
	// Set value of registers & outputs
	always @(*) begin
	  	M = OP[0] | OP[1] | OP[2] | OP[3];
		OUT = S; 
		ERR[0] = OVF;
		ERR[1] = 0;
	end

endmodule


module TestBench();
	reg [15:0] IN1;
	reg [15:0] IN2;
	reg [3:0] OP;

	wire [31:0] OUT;
	wire [1:0] ERR;

	BreadBoard BB(IN1, IN2, OP, OUT, ERR);

	initial begin
	  	assign IN1 = 16'b1011000111100000;
		assign IN2 = 16'b0111111100011101;
		assign OP = 4'b0001;
		#10
		$display("IN1: %b (%2d)\tIN2: %b (%d)\t OP :%b\tOUT: %b\tERR: %b",IN1,IN1,IN2,IN2,OP,OUT,ERR);
	end

endmodule  