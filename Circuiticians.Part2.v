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
	assign eIN1 = {{16{1'b0}}, IN1}; // extend IN1 to 32-bits
	assign eIN2 = {{16{1'b0}}, IN2}; // extend IN2 to 32-bits

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

	// carry
	assign CAR = c[32];
	// if highest bits of IN1 and IN2 are the same AND highest bit of S is different, then there was overflow
	assign OVF = ~(eIN1[31]^eIN2[31]) & (eIN1[31]^S[31] | eIN2[31]^S[31]); 
	
endmodule


// Multiplication
module Mul(IN1, IN2, P);
	input [15:0] IN1; // input 1
	input [15:0] IN2; // input 2
	output [31:0] P; // product of IN1 * IN2
	
	// Registers to work with data
	reg [31:0] regP;
	reg [6:0] i;
	reg carry;
	reg carryOut;
	reg [15:0] sumReg;
	reg [15:0] regA;
	reg [15:0] regB;

	wire [17:0] c; // carry wires
	wire [16:0] sum; // sum wires

	assign c[0] = 1'b0;

	FullAdder F0 (regA[ 0], regB[ 0], c[ 0], c[ 1], sum[ 0]);
	FullAdder F1 (regA[ 1], regB[ 1], c[ 1], c[ 2], sum[ 1]);
	FullAdder F2 (regA[ 2], regB[ 2], c[ 2], c[ 3], sum[ 2]);
	FullAdder F3 (regA[ 3], regB[ 3], c[ 3], c[ 4], sum[ 3]);
	FullAdder F4 (regA[ 4], regB[ 4], c[ 4], c[ 5], sum[ 4]);
	FullAdder F5 (regA[ 5], regB[ 5], c[ 5], c[ 6], sum[ 5]);
	FullAdder F6 (regA[ 6], regB[ 6], c[ 6], c[ 7], sum[ 6]);
	FullAdder F7 (regA[ 7], regB[ 7], c[ 7], c[ 8], sum[ 7]);
	FullAdder F8 (regA[ 8], regB[ 8], c[ 8], c[ 9], sum[ 8]);
	FullAdder F9 (regA[ 9], regB[ 9], c[ 9], c[10], sum[ 9]);
	FullAdder F10(regA[10], regB[10], c[10], c[11], sum[10]);
	FullAdder F11(regA[11], regB[11], c[11], c[12], sum[11]);
	FullAdder F12(regA[12], regB[12], c[12], c[13], sum[12]);
	FullAdder F13(regA[13], regB[13], c[13], c[14], sum[13]);
	FullAdder F14(regA[14], regB[14], c[14], c[15], sum[14]);
	FullAdder F15(regA[15], regB[15], c[15], c[16], sum[15]);
	
	

	always @(*) begin
		sumReg = {16{IN1[0]}} & IN2;
		carry = 0;
	
		regP[0] = IN1[0] & IN2[0];
		for (i = 1; i <= 15; i = i + 1) begin
			
			regA = {16{IN1[i]}} & IN2;
			regB = {carry, sumReg[15:1]};
			#1 // time delay to perform addition
			carry = c[16];
			sumReg = sum;
			regP[i] = sum[0];
			
		end
		#60
		regP = {{carry, sumReg[15:1]}, regP[15:0]};
		
		
	end


	assign P = regP;

endmodule


// Division
module Div(IN1, IN2, Q, DE);
	input [15:0] IN1;
	input [15:0] IN2;
	output [31:0] Q;
	output DE;

	reg regDE;
	reg [31:0] regQ;

	assign DE = regDE;
	assign Q = regQ; 

	always @(*) begin
	  	if (~(|IN2)) begin // IN2 is all 0's
			regDE = 1;
			regQ = 0;
		end
		else begin // IN2 is not 0
		  	regDE = 0;
			regQ = IN1 / IN2;
		end
	end
endmodule

// Modulo
module Mod(IN1, IN2, R, ME);
	input [15:0] IN1;
	input [15:0] IN2;
	output [31:0] R;
	output ME;

	reg regME;
	reg [31:0] regR;

	assign ME = regME;
	assign R = regR;

	always @(*) begin
	  	if (~(|IN2)) begin // IN2 is all 0s
			regME = 1;
			regR = 0;
		end
		else begin // IN2 is not 0
		  	regME = 0;
			regR = IN1 % IN2;
		end
	end
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
// 16-channel 32-bit multiplexer with 16-bit one-hot selector
module Mux(channels, SEL, OUT);
	input [15:0][31:0] channels;
	input [15:0] SEL;
	output [31:0] OUT;

	assign OUT = 	({32{SEL[ 0]}} & channels[ 0]) | 
               		({32{SEL[ 1]}} & channels[ 1]) |
			   		({32{SEL[ 2]}} & channels[ 2]) |
			   		({32{SEL[ 3]}} & channels[ 3]) |
			   		({32{SEL[ 4]}} & channels[ 4]) |
			   		({32{SEL[ 5]}} & channels[ 5]) |
			   		({32{SEL[ 6]}} & channels[ 6]) |
			   		({32{SEL[ 7]}} & channels[ 7]) |
			   		({32{SEL[ 8]}} & channels[ 8]) |
			   		({32{SEL[ 9]}} & channels[ 9]) |
			   		({32{SEL[10]}} & channels[10]) |
			   		({32{SEL[11]}} & channels[11]) |
			   		({32{SEL[12]}} & channels[12]) |
			   		({32{SEL[13]}} & channels[13]) | 
               		({32{SEL[14]}} & channels[14]) |
               		({32{SEL[15]}} & channels[15]) ;

endmodule


module BreadBoard(IN1, IN2, OP, OUT, ERR);
	input [15:0] IN1;
	input [15:0] IN2;
	input [3:0] OP;
	output [31:0] OUT;
	output [1:0] ERR;

	// Wires
	wire [15:0] IN1; // Input 1
	wire [15:0] IN2; // Input 2
	wire [3:0] OP; // Operation
	wire [31:0] OUT; // Output
	wire [1:0] ERR; // Error
	wire [1:0] DZE; // Divide by Zero Error

	//AddSub
	wire M; // Mode
	wire [31:0] S; // Sum
	wire CAR; // Carry
	wire OVF; // Overflow

	//Mul
	wire [31:0] P; // Product

	//Div
	wire [31:0] Q; // Quotient
	wire DE; // Divide Error

	//Mod
	wire [31:0] R; // Remainder
	wire ME; // Mod Error

	//Dec
	wire [15:0] SEL; // One-hot Select

	//Mux
	wire [15:0][31:0] channels;
	
	assign channels[ 0] = 0; // GROUND
	assign channels[ 1] = 0; // GROUND 
	assign channels[ 2] = S; // add
	assign channels[ 3] = S; // sub
	assign channels[ 4] = P; // mul
	assign channels[ 5] = Q; // div
	assign channels[ 6] = R; // mod
	assign channels[ 7] = 0; // GROUND
	assign channels[ 8] = 0; // GROUND
	assign channels[ 9] = 0; // GROUND
	assign channels[10] = 0; // GROUND
	assign channels[11] = 0; // GROUND
	assign channels[12] = 0; // GROUND
	assign channels[13] = 0; // GROUND
	assign channels[14] = 0; // GROUND
	assign channels[15] = 0; // GROUND

	// Module Instantiations

	AddSub addersubtractor(IN1, IN2, M, S, CAR, OVF);
	Mul multiplier(IN1, IN2, P);
	Div divider(IN1, IN2, Q, DE);
	Mod modulo(IN1, IN2, R, ME);
	Dec decoder(OP, SEL);
	Mux multiplexer(channels, SEL, OUT); 
	
	// Set value of outputs
	
	assign DZE = DE | ME;
	assign ERR[0] = OVF;
	assign ERR[1] = DZE;
	assign M = ~OP[3] & ~OP[2] & OP[1] & OP[0]; // 0011 -> Subtraction
	
endmodule


module TestBench();
	// Inputs
	reg [15:0] IN1; 
	reg [15:0] IN2; 
	reg [3:0] OP;
	// Outputs
	wire [31:0] OUT;
	wire [1:0] ERR;

	BreadBoard BB(IN1, IN2, OP, OUT, ERR);

	initial begin

		// Integers less than 250

	 	assign IN1 = 16'b0000000000001011; // 11
		assign IN2 = 16'b0000000000110011; // 51
		$display("=========================================================================================================================================================");
		$display("| Input IN1\t\t\t\t\t\t| Input IN2\t\t\t\t\t\t| Operation\t\t\t| Output OUT\t\t\t\t\t\t\t\t\t\t\t| Error\t\t|");
		$display("|=======================================================================================================================================================|");

		// Add
		assign OP = 4'b0010;
		#100
		$display("| IN1: %b (%2d)\t| IN2: %b (%d)\t| OP: %b (ADD)\t| OUT: %b (%d)\t| ERR: %b\t|",IN1,IN1,IN2,IN2,OP,OUT,OUT,ERR);

		// Subtract
		assign OP = 4'b0011;
		#100
		$display("| IN1: %b (%2d)\t| IN2: %b (%d)\t| OP: %b (SUB)\t| OUT: %b (%d)\t| ERR: %b\t|",IN1,IN1,IN2,IN2,OP,OUT,OUT,ERR);

		// Multiply
		assign OP = 4'b0100;
		#100
		$display("| IN1: %b (%2d)\t| IN2: %b (%d)\t| OP: %b (MUL)\t| OUT: %b (%d)\t| ERR: %b\t|",IN1,IN1,IN2,IN2,OP,OUT,OUT,ERR);

		// Divide
		assign IN1 = 16'b0000000000001011; // 11
		assign IN2 = 16'b0000000000000000; // 51
		assign OP = 4'b0101;
		#100
		$display("| IN1: %b (%2d)\t| IN2: %b (%d)\t| OP: %b (DIV)\t| OUT: %b (%d)\t| ERR: %b\t|",IN1,IN1,IN2,IN2,OP,OUT,OUT,ERR);

		// Modulo
		assign IN1 = 16'b0000000000001011; // 11
		assign IN2 = 16'b0000000000110011; // 51
		assign OP = 4'b0110;
		#100
		$display("| IN1: %b (%2d)\t| IN2: %b (%d)\t| OP: %b (MOD)\t| OUT: %b (%d)\t| ERR: %b\t|",IN1,IN1,IN2,IN2,OP,OUT,OUT,ERR);

		$display("|=======================================================================================================================================================|");

		// Integers greater than 16000

		assign IN1 = 16'b1111011100100111; // 62091
		assign IN2 = 16'b1011010100001100; // 47411
		#100
		// Add
		assign OP = 4'b0010;
		#100
		$display("| IN1: %b (%2d)\t| IN2: %b (%d)\t| OP: %b (ADD)\t| OUT: %b (%d)\t| ERR: %b\t|",IN1,IN1,IN2,IN2,OP,OUT,OUT,ERR);

		// Subtract
		assign OP = 4'b0011;
		#100
		$display("| IN1: %b (%2d)\t| IN2: %b (%d)\t| OP: %b (SUB)\t| OUT: %b (%d)\t| ERR: %b\t|",IN1,IN1,IN2,IN2,OP,OUT,OUT,ERR);

		// Multiply
		assign OP = 4'b0100;
		#100
		$display("| IN1: %b (%2d)\t| IN2: %b (%d)\t| OP: %b (MUL)\t| OUT: %b (%d)\t| ERR: %b\t|",IN1,IN1,IN2,IN2,OP,OUT,OUT,ERR);

		// Divide
		assign OP = 4'b0101;
		#100
		$display("| IN1: %b (%2d)\t| IN2: %b (%d)\t| OP: %b (DIV)\t| OUT: %b (%d)\t| ERR: %b\t|",IN1,IN1,IN2,IN2,OP,OUT,OUT,ERR);

		// Modulo
		assign OP = 4'b0110;
		#100
		$display("| IN1: %b (%2d)\t| IN2: %b (%d)\t| OP: %b (MOD)\t| OUT: %b (%d)\t| ERR: %b\t|",IN1,IN1,IN2,IN2,OP,OUT,OUT,ERR);

		$display("=========================================================================================================================================================");

	end

endmodule  