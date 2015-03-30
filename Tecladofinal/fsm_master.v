`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:54:38 03/15/2015 
// Design Name: 
// Module Name:    fsm_master 
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
module fsm_master(
	input wire en_fsmm, clk, reset, brk_code, w_ok, valid_key, enter_ok, inicio_progra,
	input wire ready,
	output wire en_maq1, l_r1, l_r2
    );

localparam[3:0] s0=4'b0000,    // Definición de los estados
					 s1=4'b0001,
					 s2=4'b0010,
					 s3=4'b0011,
					 s4=4'b0100,    
					 s5=4'b0101,
					 s6=4'b0110,
					 s7=4'b0111,    
					 s8=4'b1000,
					 s9=4'b1001,
					 s10=4'b1010,    
					 s11=4'b1011;

reg[3:0] st_reg, st_next;

/*initial 
	begin
		en_maq1 = 1'b0;
		l_r1 = 1'b0;
		l_r2 = 1'b0;
	end*/

always @ (posedge clk, posedge reset)
	if (reset)
	st_reg <= s0;              // cuando hay una señal de reset el estado actual es sO 'b00
	else
	st_reg <= st_next;   // al estado siguiente le asigno el siguiente 


always @*  
	begin
		//st_next = st_reg;  
		
		case(st_reg)
			s0:  
			    if (en_fsmm)
					st_next = s1;
				 else
					st_next = s0;
			s1: 
			    if (w_ok)       // Cuando recibe la señal de activación de la alarma el estado siguiente pasa a ser s2
					st_next = s2;
				 else
					st_next = s1;
				
			s2:  
				 if (brk_code == 1 && ready)
					st_next = s3;
				 else
					st_next = s2;
					
			s3: 
			    if (ready)           // Si la lectura está habilitada el estado siguiente es s1
					st_next = s4;
				 else				 
					st_next = s3;
				
			s4: begin 
					st_next = s5;
				 end
				 
			s5: 
			    if (valid_key)       // Cuando recibe la señal de activación de la alarma el estado siguiente pasa a ser s2
					st_next = s6;
				 else
					st_next = s2;
				
			s6: begin 
			    st_next = s7;
				 end
				 
			s7: begin 
			   
				 st_next = s8;
				 end
				 
			s8: 
			    if (enter_ok)
					st_next = s10;
				else
					st_next = s9;
			
			s9: begin 
				 st_next = s11;
				 end
				 
			s10:  
			     if (inicio_progra)
					st_next = s1;
				  else
					st_next = s10;
					
			s11: begin 
				  st_next = s2;
				  end
			
			default:
				begin
				st_next = s0;
				end
					
		endcase 
		
end

assign en_maq1 = (st_reg == s10);
assign l_r1 = (st_reg == s6);
assign l_r2 = (st_reg == s9);

	/*		
//Logica de Salidas
always@*  
	case(st_reg)
	s0:                                  // En este estado el enable de la alarma y del ventilador está apagado y el estado es 0
		begin
		en_maq1 = 1'b0;
		l_r1 = 1'b0;
		l_r2 = 1'b0;
		end
	s1:
		begin                                // En este estado la alarma y el ventilador están apagados y es el estado 1
		en_maq1 = 1'b0;
		l_r1 = 1'b0;
		l_r2 = 1'b0;
		end
	s2:
		begin
		en_maq1 = 1'b0;
		l_r1 = 1'b0;
		l_r2 = 1'b0;                 // Estado 2 decimal
		end
	s3:
		begin
		en_maq1 = 1'b0;
		l_r1 = 1'b0;
		l_r2 = 1'b0;            // Estado 3 decimal
		end
	s4:
		begin                                // En este estado la alarma y el ventilador están apagados y es el estado 1
		en_maq1 = 1'b0;
		l_r1 = 1'b0;
		l_r2 = 1'b0;
		end
	s5:
		begin
		en_maq1 = 1'b0;
		l_r1 = 1'b0;
		l_r2 = 1'b0;                 // Estado 2 decimal
		end
	s6:
		begin
		en_maq1 = 1'b0;
		l_r1 = 1'b1;
		l_r2 = 1'b0;            // Estado 3 decimal
		end
	s7:                                  // En este estado el enable de la alarma y del ventilador está apagado y el estado es 0
		begin
		en_maq1 = 1'b0;
		l_r1 = 1'b0;
		l_r2 = 1'b0;
		end
	s8:
		begin                                // En este estado la alarma y el ventilador están apagados y es el estado 1
		en_maq1 = 1'b0;
		l_r1 = 1'b0;
		l_r2 = 1'b0;
		end
	s9:
		begin
		en_maq1 = 1'b0;
		l_r1 = 1'b0;
		l_r2 = 1'b1;                 // Estado 2 decimal
		end
	s10:
		begin
		en_maq1 = 1'b1;
		l_r1 = 1'b0;
		l_r2 = 1'b1;            // Estado 3 decimal
		end                                  // En este estado el enable de la alarma y del ventilador está apagado y el estado e
	s11:
		begin                                // En este estado la alarma y el ventilador están apagados y es el estado 1
		en_maq1 = 1'b0;
		l_r1 = 1'b0;
		l_r2 = 1'b0;
		end
	endcase
*/
			
endmodule
