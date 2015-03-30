`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:27:31 03/15/2015 
// Design Name: 
// Module Name:    Captura_Dato 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////

//module Captura_Dato(
  //  );

module  Captura_Dato #(parameter W_SIZE  =  2)  //  2-W-SIZE  words  in  FIFO 
( 
	input wire clk, rst,  
   input wire datoTeclado, clockTeclado, leer_codigo_tecla, 
	output wire   [7:0]  codigo_tecla, 
	output wire   kb_buf_empty, 
); 

//  c o n s t a n t   d e c l a r a t i o n  

localparam BRK  =  8'hf0;   //  b r e a k   c o d e  

//  s y m b o l i c   s t a t e   d e c l a r a t i o n  

localparam   
	wait_brk  =  1'b0, 
	get_code  =  1'b1; 
	
//  s i g n a l   d e c l a r a t i o n  

reg   state_reg, state_next; 
wire  [7:0] scan_out  ; 
reg got_code_tick; 
wire scan_done_tick; 

//  bodv 
...................................................... 
//  i n s t a n t i a t i o n  
........................................................ 
//  i n s t a n t i a t e   ps2  r e c e i v e r  
ps2_rx  ps2_rx_unit 
	(.clk(clk), .rst(rst),.rx_en(1'b1), 
	.datoTeclado(datoTeclado),  .clockTeclado(clockTeclado), 
	.rx_done_tick(scan_done_tick),  .dout(scan_out)); 
	
//  i n s t a n t i a t e   f i f o   b u f f e r  
fifo  #(.B(8),  .W(W-SIZE))  fife-key-unit 
(.clk(clk),  .rst(rst),  .rd(rd-key-code), 
. wr  (got-code-tick) ,  . w-data(scan-out), 
. empty  (kb-buf -empty),  .  full  , 
.r-data(key-code)); 

......................................................... 
//  FSM  t o   g e t   t h e   scan  code  a f t e r   FO  r e c e i v e d  
...ww25w
...................................................... 
//  s t a t e   r e g i s t e r s  
always @(posedge clk,  posedge rst) 
	if (rst) 
		state_reg <= wait_brk; 
	else  
		state_reg <= state_next; 
//  n e x t - s t a t e   l o g i c  

always @*  
begin  
	got_code_tick = 1'b0; 
	state_next = state_reg; 
	case (state_reg) 
		wait_brk:  //  wait  f o r   FO  of  break  code 
			if (scan_done_tick == 1'b1  &&  scan_out == BRK) 
				state_next  =  get_code; 
		get_code:  //  g e t   t h e   f o l l o w i n g   scan  code 
			if (scan-done-tick) 
				begin  
					got_code_tick = 1'b1; 
					state_next  =  wait_brk; 
				end 
	end case  
end 
endmodule 
//endmodule
