module OR(output reg Y, input A, B);
 
 always @ (A or B) begin
    if(A == 1'b1 | B ==1'b1) begin
        Y = 1'b1;
    end
    else
        Y = 1'b0;
    
    end
endmodule


module NOR(output reg Y, input A, B);
 
 always @ (A or B) begin
    if(A == 1'b0 & B ==1'b0) begin
        Y = 1'b1;
    end
    else
        Y = 1'b0;
    
    end
endmodule



module NOT(output reg Y, input A);
 
 always @ (A) begin
    if(A == 1'b1) begin
        Y = 1'b0;
    end
    else
        Y = 1'b1;
    
    end
endmodule

