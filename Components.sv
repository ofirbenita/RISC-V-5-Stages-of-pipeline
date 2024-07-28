`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.07.2024 19:36:22
// Design Name: 
// Module Name: Components
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module FETCH_Components(

    );
endmodule

module Mux (a,b,s,c);

    input [31:0]a,b;
    input s;
    output [31:0]c;

    assign c = (~s) ? a : b ;
    
endmodule

module Mux_3_by_1 (a,b,c,s,d);
    input [31:0] a,b,c;
    input [1:0] s;
    output [31:0] d;

    assign d = (s == 2'b00) ? a : (s == 2'b01) ? b : (s == 2'b10) ? c : 32'h00000000;
    
endmodule

module PC_Adder (a,b,c);

    input [31:0]a,b;
    output [31:0]c;

    assign c = a + b;
    
endmodule


module Instruction_Memory(rst,A,RD);

  input rst;
  input [31:0]A;
  output [31:0]RD;

  reg [31:0] Imemory [1023:0];
  
  assign RD = (rst == 1'b0) ? {32{1'b0}} : Imemory[A[31:0]];

  initial begin
  Imemory[0] <= 32'h00500113; // addi x2=5 
    Imemory[32'h4] <= 32'h00500113; // addi x2=5 
    Imemory[32'h8] <= 32'h00c00193; // addi x3=12   
    Imemory[32'hc] <= 32'hff718393; // addi x7 = 12-9=3     
    Imemory[32'h10] <= 32'h0023E233; // or x4=3or5=7
    Imemory[32'h14] <= 32'h0041f2b3; // and x5=12 and 7 =4
    Imemory[32'h18] <= 32'h004282b3; // add x5=4+7=11   
    Imemory[32'h1c] <= 32'h02728863; // beq should not be taken    
    Imemory[32'h20] <= 32'h00020463; // beq should not be taken    
    Imemory[32'h1c] <= 32'h00000293; // addi x5=0+0=0   
    Imemory[32'h20] <= 32'h005203b3; // add x7=7+0=7    
    Imemory[32'h24] <= 32'h402383b3; // sub x7=7-5=2   
    Imemory[32'h28] <= 32'h0471aa23; // sw [96]=2    
    Imemory[32'h2c] <= 32'h06002103; // lw x2=[96]=2   
    Imemory[32'h30] <= 32'h005104b3; // add x9=2+0=2  
    Imemory[32'h34] <= 32'h008001ef; // jal jump to end , x3=0x3c   
    //Imemory[32'h38] <= 32'h00100113; //  should not execute   
    Imemory[32'h3c] <= 32'h00910133; // add x2=2+2=4    
    Imemory[32'h40] <= 32'h0221a023; // sw [92]=4    
    Imemory[32'h44] <= 32'h00210063; // beq infinite loop     end
end

/*
  initial begin
    //mem[0] = 32'hFFC4A303;
    //mem[1] = 32'h00832383;
    // mem[0] = 32'h0064A423;
    // mem[1] = 32'h00B62423;
    mem[0] = 32'h0062E233;
    // mem[1] = 32'h00B62423;

  end
*/
endmodule

module PC_Module(clk,rst,PC,PC_Next);
    input clk,rst;
    input [31:0]PC_Next;
    output [31:0]PC;
    reg [31:0]PC;

    always @(posedge clk)
    begin
        if(rst == 1'b0)
            PC <= {32{1'b0}};
        else
            PC <= PC_Next;
    end
endmodule




















