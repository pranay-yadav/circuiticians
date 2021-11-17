/*
	Circuiticians Project Part 4
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

	// carry of the 16-bit + 16-bit operation
	assign CAR = c[16];
	// 16-bit + 16-bit unsigned int cannot overflow into a 32-bit result.
	// However, 16-bit - 16-bit unsigned can "overflow" and cycle around from 0 to MAX. 
	// This can be detected if the MSB of sum S is a 1, which is only possible when M is 1.
	assign OVF = S[31];

endmodule


// Multiplication
module Mul(IN1, IN2, P);
	input [15:0] IN1; // input 1
	input [15:0] IN2; // input 2
	output [31:0] P; // product of IN1 * IN2
	
	// Registers to work with data
	reg [31:0] P;
	
	/*reg [6:0] i;
	reg carry;
	reg [15:0] sumReg;
	reg [15:0] regA;
	reg [15:0] regB;*/

	wire [15:0] c; // carry wires
	//wire [15:0] s [15:0]; // sum wires

	reg [15:0]  Augend0 , Augend1 , Augend2 , Augend3 , 
				Augend4 , Augend5 , Augend6 , Augend7 , 
				Augend8 , Augend9 , Augend10, Augend11,
				Augend12, Augend13, Augend14, Augend15;
	reg [15:0]  Addend0 , Addend1 , Addend2 , Addend3 ,
				Addend4 , Addend5 , Addend6 , Addend7 ,
				Addend8 , Addend9 , Addend10, Addend11,
				Addend12, Addend13, Addend14, Addend15;
	wire [31:0] sum0 , sum1 , sum2 , sum3 ,
				sum4 , sum5 , sum6 , sum7 ,
				sum8 , sum9 , sum10, sum11,
				sum12, sum13, sum14, sum15;
	wire [15:0] ovf;

	AddSub add0 (Addend0 , Augend0 , 1'b0, sum0 , c[0 ], ovf[0 ]);
	AddSub add1 (Addend1 , Augend1 , 1'b0, sum1 , c[1 ], ovf[1 ]);
	AddSub add2 (Addend2 , Augend2 , 1'b0, sum2 , c[2 ], ovf[2 ]);
	AddSub add3 (Addend3 , Augend3 , 1'b0, sum3 , c[3 ], ovf[3 ]);
	AddSub add4 (Addend4 , Augend4 , 1'b0, sum4 , c[4 ], ovf[4 ]);
	AddSub add5 (Addend5 , Augend5 , 1'b0, sum5 , c[5 ], ovf[5 ]);
	AddSub add6 (Addend6 , Augend6 , 1'b0, sum6 , c[6 ], ovf[6 ]);
	AddSub add7 (Addend7 , Augend7 , 1'b0, sum7 , c[7 ], ovf[7 ]);
	AddSub add8 (Addend8 , Augend8 , 1'b0, sum8 , c[8 ], ovf[8 ]);
	AddSub add9 (Addend9 , Augend9 , 1'b0, sum9 , c[9 ], ovf[9 ]);
	AddSub add10(Addend10, Augend10, 1'b0, sum10, c[10], ovf[10]);
	AddSub add11(Addend11, Augend11, 1'b0, sum11, c[11], ovf[11]);
	AddSub add12(Addend12, Augend12, 1'b0, sum12, c[12], ovf[12]);
	AddSub add13(Addend13, Augend13, 1'b0, sum13, c[13], ovf[13]);
	AddSub add14(Addend14, Augend14, 1'b0, sum14, c[14], ovf[14]);
	//AddSub add15(Addend15, Augend15, 1'b0, sum15, c[15], ovf[15]);

	always @(*) begin
	  	Addend0  = {16{IN1[1]}} & IN2;
		Augend0  = {1'b0, ({15{IN1[0]}} & IN2[15:1])};
		
		Addend1  = {16{IN1[2]}} & IN2;
		Augend1  = {c[0], sum0[15:1]};
		
		Addend2  = {16{IN1[3]}} & IN2;
		Augend2  = {c[1], sum1[15:1]};

		Addend3  = {16{IN1[4]}} & IN2;
		Augend3  = {c[2], sum2[15:1]};

		Addend4  = {16{IN1[5]}} & IN2;
		Augend4  = {c[3], sum3[15:1]};
		
		Addend5  = {16{IN1[6]}} & IN2;
		Augend5  = {c[4], sum4[15:1]};

		Addend6  = {16{IN1[7]}} & IN2;
		Augend6  = {c[5], sum5[15:1]};

		Addend7  = {16{IN1[8]}} & IN2;
		Augend7  = {c[6], sum6[15:1]};

		Addend8  = {16{IN1[9]}} & IN2;
		Augend8  = {c[7], sum7[15:1]};

		Addend9  = {16{IN1[10]}} & IN2;
		Augend9  = {c[8], sum8[15:1]};

		Addend10 = {16{IN1[11]}} & IN2;
		Augend10 = {c[9], sum9[15:1]};

		Addend11 = {16{IN1[12]}} & IN2;
		Augend11 = {c[10], sum10[15:1]};

		Addend12 = {16{IN1[13]}} & IN2;
		Augend12 = {c[11], sum11[15:1]};

		Addend13 = {16{IN1[14]}} & IN2;
		Augend13 = {c[12], sum12[15:1]};

		Addend14 = {16{IN1[15]}} & IN2;
		Augend14 = {c[13], sum13[15:1]};
	
		P = {c[14], sum14[15:0], sum13[0], sum12[0], 
					sum11[0], sum10[0], sum9[0] , sum8[0] , 
					sum7[0] , sum6[0] , sum5[0] , sum4[0] , 
					sum3[0] , sum2[0] , sum1[0] , sum0[0], (IN1[0] & IN2[0])};
	end

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

// AND
module And(IN1, IN2, A);
	input [15:0] IN1;
	input [15:0] IN2;
	output [31:0] A;
	assign A = {{16{1'b0}}, (IN1 & IN2)}; // pad inputs with 0's
endmodule

// OR
module Or(IN1, IN2, O);
	input [15:0] IN1;
	input [15:0] IN2;
	output [31:0] O;
	assign O = {{16{1'b0}}, (IN1 | IN2)}; // pad inputs with 0's
endmodule

// XOR
module Xor(IN1, IN2, XO);
	input [15:0] IN1;
	input [15:0] IN2;
	output [31:0] XO;
	assign XO = {{16{1'b0}}, (IN1 ^ IN2)}; // pad inputs with 0's
endmodule

// NAND
module Nand(IN1, IN2, NA);
	input [15:0] IN1;
	input [15:0] IN2;
	output [31:0] NA;
	assign NA = {{16{1'b0}}, ~(IN1 & IN2)}; // pad inputs with 0's
endmodule

// NOR
module Nor(IN1, IN2, NO);
	input [15:0] IN1;
	input [15:0] IN2;
	output [31:0] NO;
	assign NO = {{16{1'b0}}, ~(IN1 | IN2)}; // pad inputs with 0's
endmodule

// XNOR
module Xnor(IN1, IN2, XN);
	input [15:0] IN1;
	input [15:0] IN2;
	output [31:0] XN;
	assign XN = {{16{1'b0}}, ~(IN1 ^ IN2)}; // pad inputs with 0's
endmodule

// NOT
module Not(IN1, IN2, N);
	input [15:0] IN1;
	input [15:0] IN2;
	output [31:0] N;
	assign N = {{16{1'b0}}, ~(IN1)}; // pad inputs with 0's
endmodule

// D Flip-Flop
module DFF(CLK, D, Q);      
	parameter n = 1;
    input CLK;      // 1-bit clock signal
    input [n-1:0] D;       
    output [n-1:0] Q;    
    reg [n-1:0] Q;
    
    always @(posedge CLK)   // clock signal drives flip-flops, rising edge
    begin
        Q = D;
    end

endmodule

// Accumulator - 32 bit Register of D Flip Flops
module Acc(CLK, D, OUT);
	input CLK;
	input [31:0] D;
	output [31:0] OUT;

	DFF #(32) dff32(CLK, D, OUT); // chain of 32 D flip flops

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
module Mux(channels, SEL, D);
	input [15:0][31:0] channels;
	input [15:0] SEL;
	output [31:0] D;
	wire [31:0] D;
	assign D =  ({32{SEL[ 0]}} & channels[ 0]) | 
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

// Combinational Logic
// Sets error code based on overflow, divide and mod errors, and op code
module CL(OVF, DE, ME, OP, ERR);
	input OVF;
	input DE;
	input ME;
	input [3:0] OP;
	output [1:0] ERR;

	assign ERR = { (DE | ME) & ((~OP[3] & OP[2] & ~OP[1] & OP[0]) | (~OP[3] & OP[2] & OP[1] & ~OP[0])),
				   OVF & ( ~OP[3] & ~OP[2] & OP[1] & OP[0]) };
endmodule

// Breadboard
module BreadBoard(CLK, IN, OP, OUT, ERR);
	input [15:0] IN;
	input [3:0] OP;
	input CLK;
	output [31:0] OUT;
	output [1:0] ERR;

	/* ======== Wires & Interfaces ======== */

	// General
	wire [15:0] IN; // Input 
	wire CLK; // Clock
	wire [3:0] OP; // Operation
	wire [31:0] OUT; // Output
	wire [1:0] ERR; // Error
	wire [31:0] RES; // Reset
	wire [31:0] PRE; // Preset

	//AddSub
	wire M; // Mode
	wire [31:0] S; // Sum
	wire CAR; // Carry
	wire OVF; // Overflow
	reg ovf; // overflow error to store on posedge of CLK

	//Mul
	wire [31:0] P; // Product

	//Div
	wire [31:0] Q; // Quotient
	wire DE; // Divide Error
	reg divErr; // divide-error register to store on posedge of CLK

	//Mod
	wire [31:0] R; // Remainder
	wire ME; // Mod Error
	reg modErr; // mod-error register to store on posedge of CLK
	
	//And
	wire [31:0] A; // AND

	//Or
	wire [31:0] O; // OR

	//Xor
	wire [31:0] XO; // XOR

	//Nand
	wire [31:0] NA; // NAND

	//Nor
	wire [31:0] NO; // NOR

	//Xnor
	wire [31:0] XN; // XNOR

	//Not
	wire [31:0] N; // NOT

	//Dec
	wire [15:0] SEL; // One-hot Select

	//Mux
	wire [15:0][31:0] channels;
	wire [31:0] D; // Output of Mux, feeds into input of Register Acc

	//Acc - 32 bit Register
	wire [15:0] FBK; // Feedback, lower 16 bits of output of Acc
	
	/* ======== End Wires ======== */

	// Multiplexer Channels
	assign channels[ 0] = OUT; // Ouput of Acc should feed back into channel 0 for no-op
	assign channels[ 1] = 0;   // Ground - unused channel
	assign channels[ 2] = S;   // add
	assign channels[ 3] = S;   // sub
	assign channels[ 4] = P;   // mul
	assign channels[ 5] = Q;   // div
	assign channels[ 6] = R;   // mod
	assign channels[ 7] = O;   // or
	assign channels[ 8] = A;   // and
	assign channels[ 9] = XO;  // xor
	assign channels[10] = NA;  // nand
	assign channels[11] = NO;  // nor
	assign channels[12] = XN;  // xnor
	assign channels[13] = N;   // not
	assign channels[14] = PRE; // Preset
	assign channels[15] = RES; // Reset

	// Module Instantiations
	AddSub addersubtractor(FBK, IN, M, S, CAR, OVF);
	Mul multiplier(FBK, IN, P);
	Div divider(FBK, IN, Q, DE);
	Mod modulo(FBK, IN, R, ME);
	Or orer(FBK, IN, O);
	And ander(FBK, IN, A);
	Xor xorer(FBK, IN, XO);
	Nand nander(FBK, IN, NA);
	Nor norer(FBK, IN, NO);
	Xnor xnorer(FBK, IN, XN);
	Not noter(FBK, IN, N);
	Dec decoder(OP, SEL);
	Mux multiplexer(channels, SEL, D); 
	Acc accumulator(CLK, D, OUT);
	CL combinationalLogic(ovf, divErr, modErr, OP, ERR); // error logic
	// Set value of remaining wires
	assign FBK = OUT[15:0]; // feedback is lower 16 bits of OUT
	assign M   = ~OP[3] & ~OP[2] & OP[1] & OP[0]; // 0011 -> Subtraction
	assign PRE = {32{1'b1}}; // all 1's
	assign RES = {32{1'b0}}; // all 0's

	always @(posedge CLK) begin
	  ovf = OVF;
	  divErr = DE;
	  modErr = ME;
	end
endmodule


module TestBench();
	// Inputs
	reg [15:0] IN; // input number
	reg CLK; // clock
	reg [3:0] OP; // operation code
	// Outputs
	wire [31:0] OUT; // output of operation
	wire [1:0] ERR; // error code

	BreadBoard BB(CLK, IN, OP, OUT, ERR);

	// Clock - #10 time unit cycle
	initial begin 
		forever begin
		  	CLK = 0;
			#30;
			CLK = 1;
			#30;
		end
	end

	

	// Stimulus
	initial begin
		/* Initialize Circuit */
		#13 // Allow clock to start, stagger displays.
		IN = 16'b0000000000000000;
		OP = 4'b1111; // RESET		
		#60

		/* TRIANGLE */
		/* 	
			Perimeter = a + b + c 
		*/
		IN = a_1;
		OP = 4'b0010; // Add 0 + a
		#60;
		IN = b_1;
		OP = 4'b0010; // a + b 
		#60;
		IN = c_1;
		OP = 4'b0010; // a + b + c
		#60;
		PERIMETER_1 = OUT; //set perimeter
		OP = 4'b1111; // RESET
		#60;
		
		/* 
			Area = a * b / 2
		*/
		IN = a_1;
		OP = 4'b0010; // Add 0 + a
		#60;
		IN = b_1;
		OP = 4'b0100; // Multiply a *  b
		#60;
		IN =  16'b0000000000000010; // 2
		OP = 4'b0101; // Divide a * b by 2
		#60;
		AREA_1 = OUT; // Set volume
		OP = 4'b1111; // RESET
		#60;

		/* 
			is right? (a * a) XNOR
			0 = False, otherwise True
			Should be 0 (false) since l != w != h
		*/
		
		IN = a_1;
		OP = 4'b0010; // 0 + a
		#60;
		IN = a_1;
		OP = 4'b0100; // a * a
		#60;
		a2_1 = OUT; //a^2 + b^2
		OP = 4'b1111; //reset
		
		#60;
		IN = b_1;
		OP = 4'b0010; // 0 + b
		#60;
		IN = b_1;
		OP = 4'b0100; // b * b
		#60;
		
		b2_1 = OUT; //a^2 + b^2
		OP = 4'b1111; //reset
		#60
		
		IN = a2_1;
		OP = 4'b0010; // 0 + a^2
		#60;
		IN = b2_1;
		OP = 4'b0010; // a^2 * b^2
		#60;
		a2b2_1 = OUT; //a^2 + b^2
		OP = 4'b1111; //reset
		#60;
		
		IN = c_1;
		OP = 4'b0010; // 0 + c
		#60;
		IN = c_1;
		OP = 4'b0100; // c * c
		#60;
		IN = a2b2_1;
		OP = 4'b1100; // isRight_1 XOR c*c (should be all 0s if true)
		#60
		IsRight_1 = OUT;
		OP = 4'b1111;
		#60
		/* End TRIANGLE */

 		/* Rectangle */
        /*
            Perimeter = 2(l + w) = (2l + 2w)
            l = 10, w = 8, therefore, Perimeter P should equal 36.
        */
        IN = l_2;
        OP = 4'b0010; // Add 0 + l
        #60;
        IN = w_2;
        OP = 4'b0010; // Add l + w
        #60;
        IN = 16'b0000000000000010; // 2
        OP = 4'b0100; // Multiply 2 w/ (l + w)
        #60;
        P_2 = OUT; // Set Perimeter
        OP = 4'b1111; // RESET
        #60;
        
        /*
            Area = (l * w)
            l = 10, w = 8, therefore, Area A should equal 80.
        */
        IN = l_2;
        OP = 4'b0010; // Add 0 + l
        #60;
        IN = w_2;
        OP = 4'b0100; // Multiply w w/ l for (l * w)
        #60;
        A_2 = OUT; // Set Area
        OP = 4'b1111; // RESET
        
        #60;
        
        /*
           Is square? = (l XNOR w)
		0 = False, otherwise True
		Should be 0 (false) since l != w
        */
        IN = l_2;
		OP = 4'b0010; // 0 + l
		#60;
		IN = w_2;
		OP = 4'b1100; // l XNOR w
		#60;
		IsSquare_2 = OUT; // Set IsSquare
		OP = 4'b1111; // RESET
		#60;
		/* End RECTANGLE */
        
        OP = 4'b1111; // RESET		
		#60
		/* END RECTANGLE */

		/* CIRCLE */
		/* 	
			Circumference = 2 * pi * r
			Area = pi * r * r
		*/
		// Circumference INT Part
		IN = PI; 
		OP = 4'b0010; // Add 0 + Pi
		#60;
		IN = r_3;
		OP = 4'b0100; // Multiply Pi * r
		#60;
		IN = 16'b0000000000000010; // 2
		OP = 4'b0100; // Multiply 2 * Pi * r
		#60;
		IN = hundred;
		OP = 4'b0101; // Divide by 100
		#60
		CIRC_3_INT = OUT;
		OP = 4'b1111; // RESET
		#60;

		// Circumference Decimal part
		IN = PI; 
		OP = 4'b0010; // Add 0 + Pi
		#60;
		IN = r_3;
		OP = 4'b0100; // Multiply Pi * r
		#60;
		IN = 16'b0000000000000010; // 2
		OP = 4'b0100; // Multiply 2 * Pi * r
		#60;
		IN = hundred;
		OP = 4'b0110; // Mod by 100
		#60
		CIRC_3_DEC = OUT;
		OP = 4'b1111; // RESET
		#60;

		// AREA INT part
        IN = PI; 
		OP = 4'b0010; // Add 0 + Pi
		#60;
		IN = r_3;
		OP = 4'b0100; // Multiply Pi * r
		#60;
		IN = r_3; 
		OP = 4'b0100; // Multiply Pi * r * r
		#60;
		IN = hundred;
		OP = 4'b0101; // Divide by 100
		#60
		AREA_3_INT = OUT;
		OP = 4'b1111; // RESET
		#60;
		// AREA DEC part
		IN = PI; 
		OP = 4'b0010; // Add 0 + Pi
		#60;
		IN = r_3;
		OP = 4'b0100; // Multiply Pi * r
		#60;
		IN = r_3; 
		OP = 4'b0100; // Multiply Pi * r * r
		#60;
		IN = hundred;
		OP = 4'b0110; // Mod by 100
		#60
		AREA_3_DEC = OUT;
		OP = 4'b1111; // RESET
		#60;
	
		/* End CIRCLE */


		/* RECTANGULAR PRISM */
		/* 	
			Surface Area = 2 * (h * l + h * w + w * l) = 2 * [(hl) + (hw) + (wl)]
			h = 5, w = 10, l = 4, so Surface Area SA should = 220
		*/
		IN = h_4;
		OP = 4'b0010; // Add 0 + h
		#60;
		IN = l_4;
		OP = 4'b0100; // Multiply h * l, store in hl
		#60;
		hl_4 = OUT;
		OP = 4'b1111; // RESET
		#60;
		IN = h_4; 
		OP = 4'b0010; // Add 0 + h
		#60;
		IN = w_4;
		OP = 4'b0100; // Multiply h * w
		#60;
		hw_4 = OUT;
		OP = 4'b1111; // RESET
		#60;
		IN = w_4; 
		OP = 4'b0010; // Add 0 + h
		#60;
		IN = l_4;
		OP = 4'b0100; // Multiply w * l
		#60;
		wl_4 = OUT;
		OP = 4'b1111; // RESET
		#60;
		IN = hl_4; 
		OP = 4'b0010; // Add 0 + hl
		#60;
		IN = hw_4; 
		OP = 4'b0010; // Add hl + hw
		#60;
		IN = wl_4; 
		OP = 4'b0010; // Add hl + hw + wl
		#60;
		IN = 16'b0000000000000010; // 2
		OP = 4'b0100; // Multiply 2 * (hl + hw + wl)
		#60;
		SA_4 = OUT; // Set Surface Area
		OP = 4'b1111; // RESET
		#60;
		
		/* 
			Volume = l * w * h
			Volume VOL should = 4 * 10 * 5 = 200
		*/
		IN = l_4;
		OP = 4'b0010; // Add 0 + l
		#60;
		IN = w_4;
		OP = 4'b0100; // Multiply l * w
		#60;
		IN = h_4;
		OP = 4'b0100; // Multiply l * w * h
		#60;
		VOL_4 = OUT; // Set volume
		OP = 4'b1111; // RESET
		#60;

		/* 
			Is cube? = (l XNOR w) AND (w XNOR h)
			0 = False, otherwise True
			Should be 0 (false) since l != w != h
		*/
		IN = l_4;
		OP = 4'b0010; // 0 + l
		#60;
		IN = w_4;
		OP = 4'b1100; // l XNOR w
		#60;
		lXNORw_4 = OUT;
		OP = 4'b1111; // RESET
		#60;
		IN = w_4;
		OP = 4'b0010; // 0 + w
		#60;
		IN = h_4;
		OP = 4'b1100; // w XNOR h
		#60;
		wXNORh_4 = OUT;
		OP = 4'b1111; // RESET
		#60;
		IN = lXNORw_4[15:0];
		OP = 4'b0010; // 0 + (l XNOR w)
		#60;
		IN = wXNORh_4[15:0];
		OP = 4'b1000; // (l XNOR w) AND (w XNOR h)
		#60;
		IsCube_4 = OUT;
		OP = 4'b1111; // RESET
		#60;
		/* End RECTANGULAR PRISM */
	
		/* SPHERE / SA = 4* pi * r^2 / V = 4 * pi * r^3 / 3 */
		
		// SA Int part
		IN = PI; 
		OP = 4'b0010; // Add pi
		#60;
		IN = r_5;
		OP = 4'b0100; // Multiply Pi * r
		#60;
		IN = r_5;
		OP = 4'b0100; // Multiply Pi * r ^ 2
		#60;
		IN = 16'b0000000000000100; // 4
		OP = 4'b0100; // Multiply 4 * Pi * r ^ 2
		#60;
		IN = hundred;
		OP = 4'b0101; // Divide by 100
		#60
		SA_5_INT = OUT;
	    OP = 4'b1111; // RESET
		#60;

		// SA Int part
		IN = PI; 
		OP = 4'b0010; // Add pi
		#60;
		IN = r_5;
		OP = 4'b0100; // Multiply Pi * r
		#60;
		IN = r_5;
		OP = 4'b0100; // Multiply Pi * r ^ 2
		#60;
		IN = 16'b0000000000000100; // 4
		OP = 4'b0100; // Multiply 4 * Pi * r ^ 2
		#60;
		IN = hundred;
		OP = 4'b0110; // Mod by 100
		#60
		SA_5_DEC = OUT;
	    OP = 4'b1111; // RESET
		#60;

		// VOL INT part
	    IN = PI; 
		OP = 4'b0010; // Add pi
		#60;
		IN = r_5;
		OP = 4'b0100; // Multiply Pi * r
		#60;
		IN = r_5; 
		OP = 4'b0100; // Multiply Pi * r ^ 2
		#60;
		IN = r_5; 
		OP = 4'b0100; // Multiply Pi * r ^ 3
		#60;
		IN = 16'b0000000000000011; // 3
		OP = 4'b0101; // 4 * pi * r ^ 3 / 3
		#60;
		IN = 16'b0000000000000100; // 4
		OP = 4'b0100; // Multiply 4 * Pi * r ^ 3
		#60;
		IN = hundred;
		OP = 4'b0101; // Divide by 100
		#60
		VOL_5_INT = OUT;
		OP = 4'b1111; // RESET
		#60;

		// VOL DEC part
	    IN = PI; 
		OP = 4'b0010; // Add pi
		#60;
		IN = r_5;
		OP = 4'b0100; // Multiply Pi * r
		#60;
		IN = r_5; 
		OP = 4'b0100; // Multiply Pi * r ^ 2
		#60;
		IN = r_5; 
		OP = 4'b0100; // Multiply Pi * r ^ 3
		#60;
		IN = 16'b0000000000000011; // 3
		OP = 4'b0101; // 4 * pi * r ^ 3 / 3
		#60;
		IN = 16'b0000000000000100; // 4
		OP = 4'b0100; // Multiply 4 * Pi * r ^ 3
		#60;
		IN = hundred;
		OP = 4'b0110; // Mod by 100
		#60
		VOL_5_DEC = OUT;
		OP = 4'b1111; // RESET
		#60;

		/* End SPHERE */

		/* CYLINDER */
		
		/* 	
			Surface Area = 2 * PI * r * (h + r)	         
		*/
	
		IN = h_6;      //Add 0 to h
		OP = 4'b0010;
		#60;
		IN = r_6;      //h + r
		OP = 4'b0010;
		#60;
		IN = r_6;      //r * (h + r)
		OP = 4'b0100;
		#60;
		IN = PI;       //PI * r * (h + r)
		OP = 4'b0100;
		#60;           //2 * PI * r * (h + r)
		IN = 16'b000000000000010; 
		OP = 4'b0100;  //Assign to SURFACE_AREA_6
		#60;           
		SURFACE_AREA_6 = OUT; 
	
		OP = 4'b1111;  //RESET
		#60;
                                                 	   
		/* 
		 Volume = PI * r * r * h
		*/

		IN = h_6;       //0 + h
		OP = 4'b0010;
		#60;
		IN = r_6;       //r * h
		OP = 4'b0100;
		#60;
		IN = r_6;       //r * r * h
		OP = 4'b0100;
		#60;
		IN = PI;        //PI * r * r * h
		OP = 4'b0100;
		#60;            //Assign to VOLUME_6
		VOLUME_6 = OUT;
	
		OP = 4'b1111;   //RESET
		#60;

		/* END CYLINDER */
		
		/* Display Statements */
		$display("============================================================================================");
		$display("    GEOMETRIC SHAPES CALCULATIONS");
		$display("============================================================================================");

		$display("============================================================================================");
		$display("    RECTANGLE");
		$display("    Parameters: length = %1d, width = %1d", l_2, w_2);
		$display("  ________________________________________________________________________________________\n");
		$display("    Perimeter = %1d", P_2);
		$display("    Area = %1d", A_2);	
		$display("    Is a square? (All 1's = True, otherwise False) = %b", IsSquare_2[15:0]);	
		$display("============================================================================================");

		$display("============================================================================================");
      	$display("    TRIANGLE");
      	$display("    Parameters (sides): a = %1d, b = %1d, c = %1d", a_1, b_1, c_1);
		$display("  ________________________________________________________________________________________\n");
		$display("    Perimeter = %1d", PERIMETER_1);
		$display("    AREA = %1d", AREA_1);
		$display("    Is Right Triangle? (All 1's = True, otherwise False): %b", IsRight_1[15:0]);
		$display("============================================================================================");

		$display("============================================================================================");
		$display("    CIRCLE");
		$display("    Parameters: radius = %1d", r_3);
		$display("  ________________________________________________________________________________________\n");
		$display("    Circumference = %1d.%1d", CIRC_3_INT, CIRC_3_DEC);
		$display("    Area = %1d.%1d", AREA_3_INT, AREA_3_DEC);	
		$display("============================================================================================");

		$display("============================================================================================");
		$display("    RECTANGULAR PRISM");
		$display("    Parameters: length = %1d, width = %1d, height = %1d", l_4, w_4, h_4);
		$display("  ________________________________________________________________________________________\n");
		$display("    Surface Area = %1d", SA_4);
		$display("    Volume = %1d", VOL_4);	
		$display("    Is a cube? (All 1's = True, otherwise False) = %b", IsCube_4[15:0]);	
		$display("============================================================================================");
		
		$display("============================================================================================");
		$display("    SPHERE");
		$display("    Parameters: radius = %1d", r_5);
		$display("  ________________________________________________________________________________________\n");
		$display("    Surface Area = %1d.%1d", SA_5_INT, SA_5_DEC);
		$display("    Volume = %1d.%1d", VOL_5_INT, VOL_5_DEC);	
		$display("============================================================================================");

		$display("============================================================================================");
		$display("    CYLINDER");
		$display("    Parameters: radius = %1d, height = %1d", r_6, h_6);
		$display("  ________________________________________________________________________________________\n");
		$display("    Surface Area = %1d", SURFACE_AREA_6);
		$display("    Volume = %1d", VOLUME_6);	
		$display("============================================================================================");
		/* End Display Statements */
		$finish;
	end

	/* Local Variables for Calculations */ 

	// Triangle
	reg [15:0] a_1 = 16'b0000000000000011; // a = 3
  	reg [15:0] b_1 = 16'b0000000000000100; // b = 4
	reg [15:0] c_1 = 16'b0000000000000101; // c = 5
	reg [31:0] PERIMETER_1; 
	reg [31:0] AREA_1; // area
	reg [31:0] a2_1;
	reg [31:0] b2_1;
	reg [31:0] a2b2_1; // a^2 + b^2;
	reg [31:0] IsRight_1; // All 1's = True, otherwise false

	// Rectangle
	reg [15:0] l_2 = 16'b0000000000001010; // length = 10
	reg [15:0] w_2 = 16'b0000000000001000; // length = 8
	reg [31:0] P_2; // perimeter
	reg [31:0] A_2; // area
	reg [31:0] IsSquare_2; // All 1's = True, otherwise false

	// Circle
	reg [15:0] r_3 = 16'b0000000000001000; // Radius = 8
	reg [31:0] CIRC_3_INT; // Circumference INTeger part
	reg [31:0] CIRC_3_DEC; // Circumference DECimal part
	reg [31:0] AREA_3_INT; // Area INTeger part
	reg [31:0] AREA_3_DEC; // Area DECimal part
	
	// Rectangular Prism
	reg [15:0] l_4 = 16'b0000000000000100; // length = 4
	reg [15:0] w_4 = 16'b0000000000001010; // width = 10
	reg [15:0] h_4 = 16'b0000000000000101; // height = 5
	reg [31:0] SA_4; // surface area
	reg [31:0] VOL_4; // volume
	reg [31:0] hl_4; // h * l 
	reg [31:0] hw_4; // h * w
	reg [31:0] wl_4; // w * l
	reg [31:0] IsCube_4; // All 1's = True, otherwise false
	reg [31:0] lXNORw_4; // l XNOR w
	reg [31:0] wXNORh_4; // w XNOR h

	// Sphere
	reg [15:0] r_5 = 16'b0000000000000101; // radius = 5
	reg [31:0] SA_5_INT; // Surface Area INT part
	reg [31:0] SA_5_DEC; // Surface Area DECimal part
	reg [31:0] VOL_5_INT; // Volume INT part
	reg [31:0] VOL_5_DEC; // Volume Decimal Part

	// Cylinder
	reg [15:0] r_6 = 16'b0000000000010110;
	reg [15:0] h_6 = 16'b0000000000101111;
	reg [31:0] VOLUME_6;
	reg [31:0] SURFACE_AREA_6;

	
	/* Pi Constants
	    Pi is restricted to 314 / 100 because any larger would be too large
	    to accurately calculate for our 16-bit input ALU due to truncation of upper 16 bits 
	*/
	reg [15:0] PI = 16'b0000000100111010; // pi = 3.14 * 100 = 31415
	reg [15:0] hundred = 16'b0000000001100100; // 100

endmodule  
