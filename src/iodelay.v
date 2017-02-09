/////////////////////////// INCLUDE /////////////////////////////
`include "./globals.v"

////////////////////////////////////////////////////////////////
//
//  Module  : iodelay.v
//  Designer: Hoki
//  Company : HWorks
//  Date    : 2017/1/3
//
////////////////////////////////////////////////////////////////
// 
//  Description: MIPI IO delay module
//
////////////////////////////////////////////////////////////////
// 
//  Revision: 1.0

/////////////////////////// DEFINE /////////////////////////////

/////////////////////////// MODULE //////////////////////////////
module iodelay
(
   clk,
   rst_n,
   in_dio,
   in_delay,
   in_delay_we,
   out_dio
);

   ///////////////// PARAMETER ////////////////
   parameter P_DELAY_NBIT = `MIPI_IODELAY_NBIT;

   ////////////////// PORT ////////////////////
   input                      clk;
   input                      rst_n;
   input                      in_dio;
   input  [P_DELAY_NBIT-1:0]  in_delay;
   input                      in_delay_we;
   output                     out_dio;

   ////////////////// ARCH ////////////////////

   reg [P_DELAY_NBIT-1:0]     io_delay_num=`MIPI_IODELAY_NBIT'd16;
   reg [2**P_DELAY_NBIT-1:0]  io_delay;
   
   always@(posedge clk) begin
      if(~rst_n) begin
         io_delay <= 0;
      end
      else begin
         io_delay <= {io_delay[2**P_DELAY_NBIT-2:0],in_dio};
         if(in_delay_we) begin
            io_delay_num <= in_delay;
            io_delay <= 0;
         end
      end
   end
   
   assign out_dio = io_delay[io_delay_num];
   
endmodule