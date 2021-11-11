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
		/* Rectangular Prism */


		/* 	Surface Area = 2 * (h * l + h * w + w * l) = 2 * [(hl) + (hw) + (wl)]
			h = 5, w = 10, l = 4, so Surface Area SA should = 220
		*/
		IN = h;
		OP = 4'b0010; // Add 0 + h
		#60;
		IN = l;
		OP = 4'b0100; // Multiply h * l, store in hl
		#60;
		hl = OUT;
		$display("hl = %b (%d)", hl, hl);
		OP = 4'b1111; // RESET
		#60;
		IN = h; 
		OP = 4'b0010; // Add 0 + h
		#60;
		IN = w;
		OP = 4'b0100; // Multiply h * w
		#60;
		hw = OUT;
		OP = 4'b1111; // RESET
		#60;
		IN = w; 
		OP = 4'b0010; // Add 0 + h
		#60;
		IN = l;
		OP = 4'b0100; // Multiply w * l
		#60;
		wl = OUT;
		OP = 4'b1111; // RESET
		#60;
		IN = hl; 
		OP = 4'b0010; // Add 0 + hl
		#60;
		IN = hw; 
		OP = 4'b0010; // Add hl + hw
		#60;
		IN = wl; 
		OP = 4'b0010; // Add hl + hw + wl
		#60;
		IN = 16'b0000000000000010; // 2
		OP = 4'b0100; // Multiply 2 * (hl + hw + wl)
		#60;
		SA = OUT;
		$display("Surface Area = %b (%d)", SA, SA);

		

		$finish;
	end

	/* Local Variables for Calculations */ 

	// Rectangular Prism
	reg [15:0] l = 16'b0000000000000100; // length = 4
	reg [15:0] w = 16'b0000000000001010; // width = 10
	reg [15:0] h = 16'b0000000000000101; // height = 5
	reg [31:0] SA; // surface area
	reg [31:0] VOL; // volume
	reg [31:0] hl; // h * l 
	reg [31:0] hw; // h * w
	reg [31:0] wl; // w * l

endmodule  