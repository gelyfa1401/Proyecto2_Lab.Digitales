`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:05:18 03/10/2015 
// Design Name: 
// Module Name:    Teclado_Recep 
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

module Teclado_Recep(
	input wire clk,
	input wire rst, 
	input wire datoTeclado, clockTeclado, enable_rx, 
	output reg rx_listo, 
	output wire q_act_0,
	output wire [7:0] codigo_tecla
    );

//Parámetros iniciales

	localparam [1:0]
	hold_rx = 2'b00, 
	paq_dat = 2'b01, 
	fin_rx = 2'b10; 
	
//Declaración de señales para la máquina de estados

	reg [1:0] est_act,est_sig; 
   reg [10:0] paq_act,paq_sig; 
	reg [3:0] cont_paq_act, cont_paq_sig; 

//Declaración de señales para el filtro detector de flancos

	reg [7:0] filter_reg;
	wire [7:0] filter_next;
	reg f_ps2c_reg;
	wire f_ps2c_next;
	wire fall_edge;
	
//--------------------------------------------------------------------------------//
//Cuerpo del filtro detector de flancos

always @(posedge clk, posedge rst) 
if(rst)
	begin
		filter_reg <= 0;
		f_ps2c_reg <= 0;
	end
else
	begin
		filter_reg <= filter_next;
		f_ps2c_reg <= f_ps2c_next;
	end

assign filter_next = {clockTeclado, filter_reg[7:1]};
assign f_ps2c_next = (filter_reg == 8'b11111111) ? 1'b1:
							(filter_reg == 8'b00000000) ? 1'b0:
							f_ps2c_reg;
							
assign fall_edge = f_ps2c_reg & ~f_ps2c_next;

//--------------------------------------------------------------------------------//

//FSM que controla el módulo de recepción

always @(posedge clk, posedge rst) begin
if(rst) 
	begin
		est_act <= hold_rx; 
		paq_act <= 0; 
		cont_paq_act <= 0; 
	end
else 
	begin
		est_act <= est_sig; 
		paq_act <= paq_sig; 
		cont_paq_act <= cont_paq_sig; 
	end
end


always @*
begin
	est_sig = est_act; 
	rx_listo = 1'b0; 
	paq_sig = paq_act;  
	cont_paq_sig = cont_paq_act;
	
	case(est_act)  
	
		hold_rx: begin 
			if(fall_edge && enable_rx)  
				begin 
					paq_sig = {datoTeclado, paq_act[10:1]}; 
					cont_paq_sig = 4'b1001; 
					est_sig = paq_dat;
				end
		end		
		
		paq_dat: begin 
			if(fall_edge) 
				begin 
					if(cont_paq_act > 0)
					paq_sig = {datoTeclado, paq_act[10:1]}; 
					if(cont_paq_act == 0) begin 
						est_sig = fin_rx; 
					end
					else begin 
						cont_paq_sig = cont_paq_act - 1'b1;
					end
				end
		end
		
		fin_rx: begin  
				est_sig = hold_rx;
				rx_listo = 1'b1;
		end
			
	endcase
end
 
assign codigo_tecla= paq_act[8:1] ; 
assign q_act_0 = paq_act[0] ;

endmodule

