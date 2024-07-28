`timescale 1ns / 1ps


module RISC_V_TB();
logic clk,reset;
Pipeline_top riscv( 
.clk(clk) ,
 .reset(reset)
);
always begin 
 clk = 1'b0;
 #10;
  clk = 1'b1;
 #10;
 end
 
 
 initial begin 
  reset =1'b1;
#80;
  reset =1'b0;
 #3000;
 
end

endmodule