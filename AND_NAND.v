
module NAND(output reg Y, input A, B);
 
 always @ (A or B) begin
    if(A == 1'b1 & B ==1'b1) begin
        Y = 1'b0;
    end
    else
        Y = 1'b1;
    
    end
endmodule


module NAND_tb;
    reg A, B;
    wire Y;
    NAND Indtance0 (Y, A, B);
initial begin
    A = 0; B = 0;
 #1 A = 0; B = 1;
 #1 A = 1; B = 0;
 #1 A = 1; B = 1;   
end
initial begin
    $monitor ("%t | A = %d| B = %d| Y = %d", $time, A, B, Y);
    $dumpfile("dump.vcd");
    $dumpvars();
end
endmodule

module AND(output reg Y, input A, B);
 
 always @ (A or B) begin
    if(A == 1'b1 & B ==1'b1) begin
        Y = 1'b1;
    end
    else
        Y = 1'b0;
    
    end
endmodule


module AND_tb;
    reg A, B;
    wire Y;
    AND Indtance0 (Y, A, B);
initial begin
    A = 0; B = 0;
 #1 A = 0; B = 1;
 #1 A = 1; B = 0;
 #1 A = 1; B = 1;   
end
initial begin
    $monitor ("%t | A = %d| B = %d| Y = %d", $time, A, B, Y);
    $dumpfile("dump.vcd");
    $dumpvars();
end
endmodule

