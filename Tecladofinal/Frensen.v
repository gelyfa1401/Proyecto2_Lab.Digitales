`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:37:33 03/16/2015 
// Design Name: 
// Module Name:    Frensen 
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
module Frensen( 
	input wire rx_cod,clk,rst,inicio_progra1,enable, 
	input wire [7:0] data,
	output carga_R2, en_maq11,
	output [4:0] out_deco 
    );

wire comp_out1, comp_out2, comp_out3, comp_out4;
wire [7:0] out_reg1;
wire carga_R1;
wire brk_code1, w_okay1, valid_key1, enter_ok1;

localparam 
	enter = 8'h5A,
	w = 8'h1D,
	uno = 8'h16,
	dos = 8'h1E,
	tres = 8'h26,
	cuatro = 8'h25,
	cinco = 8'h2E,
	f0 = 8'hF0;
	
compardr #(.N(8)) comp2 (
	.D (data),
	.A (w),
	.L (w_okay1)
);


compardr #(.N(8)) comp1 (
	.D (data),
	.A (f0),
	.L (brk_code1)
);


Deco_validacion deco_valid(
	.Tecla(data),
	.valid_key (valid_key1)
); 


Registro # (.N(8)) regis1 (
	.rst (rst),
	.clk (clk),
	.load (carga_R1),
	.d_in (data),
	.d_out (out_reg1)
);

compardr #(.N(8)) comp4 (
	.D (out_reg1),
	.A (enter),
	.L (enter_ok1)
);

Deco_PS2 decofsm1 (
	.key_code_data(out_reg1),
	.cod_binario(out_deco)
);

fsm_master maquina_principal (
	.en_fsmm (enable),
	.clk (clk),
	.reset (rst),
	.brk_code (brk_code1),
	.w_ok (w_okay1),
	.valid_key (valid_key1),
	.enter_ok (enter_ok1),
	.inicio_progra (inicio_progra1),
	.ready (rx_cod),
	.en_maq1 (en_maq11),
	.l_r1 (carga_R1),
	.l_r2 (carga_R2)
);

endmodule
