module carWash(clk, Rssd, Lssd,btn0, btn3, sw5, sw6, sw7);
	
	input clk, sw5, sw6, sw7, btn0, btn3;
	reg [3:0] state;
	output reg [6:0] Rssd, Lssd;
	
	parameter s0 = 4'b0000, s1 = 4'b0001, s2 = 4'b0010, s3 = 4'b0011, s4 = 4'b0100, s5 = 4'b0101, s6 = 4'b0110, s7 = 4'b0111,
				 s8 = 4'b1000, s9 = 4'b1001, s10 = 4'b1010, s11 = 4'b1011, s12 = 4'b1100, s13 = 4'b1101, s14 = 4'b1110, s15 = 4'b1111;
				 
	always @(posedge clk) begin
	
		case(state)
		s0:begin
			Rssd = 7'b0000001;//Displays -
			Lssd = 7'b0000001;//Displays -
		end
		
		s1:begin //Baic program display
		
			Rssd = 7'b1100111;//Displays P
			Lssd = 7'b0011111;//Displays b
		end
		
		s2:begin//Extra program display
		
			Rssd = 7'b1100111;// Displays P
			Lssd = 7'b1001111;// Displays E
		end
		
		s3:begin//Platinum program Display
		
			Rssd = 7'b1100111;// Displays P
			Lssd = 7'b1100111;// Displays P
		end
		
		s4: begin//Rubbing and Scrubbers
		
			Rssd = 7'b1001110;//Displays C
			Lssd = 7'b0000000;
		end
		
		s5:begin//Applying Soap Foam
		
			Rssd = 7'b1000111;//Displays F
			Lssd = 7'b1011011;//Displays 5
		end
		
		s6:begin//Pre Soaking
		
			Rssd = 7'b1011011;// Displays S
			Lssd = 7'b1100111;// Displays P
		end
		
		s7:begin//Rubbing and Scrubbers
		
			Rssd = 7'b1001110;//Displays C
			Lssd = 7'b0000000;//
		end
		
		s8:begin//Rinsing
		
			Rssd = 7'b0110000;//Displays 1
			Lssd = 7'b0000101;//Displays r
		end
		
		s9:begin
			Rssd = 7'b0011111;//Displays 6
			Lssd = 7'b0000000;//
		end
		
		s10:begin//Applying wax
			Rssd = 7'b0111110;//U
			Lssd = 7'b0111110;//U
		end
		
		s11:begin//Rubbing and scrubers
			Rssd = 7'b1001110;//Displays C
			Lssd = 7'b0000000;//
		end
		
		s12:begin
			Rssd = 7'b0110000;//Dsiplays 1
			Lssd = 7'b0000101;
		end
		
		s13:begin//Dryer
			Rssd = 7'b0111101;//Displays d
			Lssd = 7'b0000000;//
	end
		
		s14:begin//Repel SHield
			Rssd = 7'b1011011;//Displays 5
			Lssd = 7'b0000000;//Displays r
		end
		
		s15:begin//Tire Shine
			Rssd = 7'b0110111;//Displays H
			Lssd = 7'b1011011;//Displays 5
		end 
		
		default:begin



			state = s0;
		end
		
		endcase
		
		case(sw7)//Basic Wash
		1:begin
			if(btn3) begin
			case(state)
			s0: state =s1;
			s1: state =s5;//Aplies Soap
			s5: state =s7;//Scrubbers
			s7: state =s8;//Rinsing
			s8: state =s9;//Ends
			s9: state =s0;//" - - "
			default: state = s0;
		endcase 
			end
			end
			
		endcase
		
		case(sw6)//Normal Wash
		1:begin 
			if(btn3) begin
			case (state)
			
			s0: state =s2;
			s2: state =s6;//Pre Soaking
			s6: state =s7;//Scrubbers
			s7: state =s5;//Soap
			s5: state =s4;//Scrubbers
			s4: state =s8;//Rinses
			s8: state =s9;//ends
			s9: state = s0;
			default state = s0;
		endcase 
				end
				end
		endcase 
		
		case(sw5)//Platinum Wash
		1:begin 
			if(btn3) begin
			case (state)
			s0: state =s3;
			s3: state =s6;
			s6: state =s7;
			s7: state =s5;
			s5: state =s4;
			s4: state =s8;
			s8: state =s10;
			s10: state = s11;
			s11: state =s12;
			s12: state =s13;
			s13: state =s14;
			s14: state =15;
			s15: state =9;
			s9: state =0;
		
			default state = s0;
		endcase 
				end
				end
		endcase
		
		case(btn0)
		1: begin
		state = s0;
		end
		endcase
		
		end
	endmodule


/////////////////////const

Net "sw[5]" LOC="B16" | IOSTANDARD = LVCMOS33;
Net "sw[6]" LOC="D16" | IOSTANDARD = LVCMOS33;
Net "sw[7]" LOC="E14" | IOSTANDARD = LVCMOS33;
Net "btn0" LOC="C10" | IOSTANDARD = LVCMOS33;//paid
Net "btn3" LOC="C13" | IOSTANDARD = LVCMOS33;//reset
Net "Rssd[6]" LOC="E3" | IOSTANDARD = LVCMOS33 | SLEW = SLOW | DRIVE = 8;  //SEGA R
Net "Rssd[5]" LOC="E1" | IOSTANDARD = LVCMOS33 | SLEW = SLOW | DRIVE = 8;  //SEGB R 
Net "Rssd[4]" LOC="G5" | IOSTANDARD = LVCMOS33 | SLEW = SLOW | DRIVE = 8;  //SEGC R
Net "Rssd[3]" LOC="D1" | IOSTANDARD = LVCMOS33 | SLEW = SLOW | DRIVE = 8;  //SEGD R
Net "Rssd[2]" LOC="E4" | IOSTANDARD = LVCMOS33 | SLEW = SLOW | DRIVE = 8;  //SEGE R
Net "Rssd[1]" LOC="C1" | IOSTANDARD = LVCMOS33 | SLEW = SLOW | DRIVE = 8;  //SEGF R
Net "Rssd[0]" LOC="C2" | IOSTANDARD = LVCMOS33 | SLEW = SLOW | DRIVE = 8;  //SEGG R
Net "Lssd[6]" LOC="H6" | IOSTANDARD = LVCMOS33 | SLEW = SLOW | DRIVE = 8;  //SEGA L
Net "Lssd[5]" LOC="K2" | IOSTANDARD = LVCMOS33 | SLEW = SLOW | DRIVE = 8;  //SEGB L
Net "Lssd[4]" LOC="H3" | IOSTANDARD = LVCMOS33 | SLEW = SLOW | DRIVE = 8;  //SEGC L
Net "Lssd[3]" LOC="K1" | IOSTANDARD = LVCMOS33 | SLEW = SLOW | DRIVE = 8;  //SEGD L
Net "Lssd[2]" LOC="G4" | IOSTANDARD = LVCMOS33 | SLEW = SLOW | DRIVE = 8;  //SEGE L
Net "Lssd[1]" LOC="J2" | IOSTANDARD = LVCMOS33 | SLEW = SLOW | DRIVE = 8;  //SEGF L
Net "Lssd[0]" LOC="G3" | IOSTANDARD = LVCMOS33 | SLEW = SLOW | DRIVE = 8;  //SEGG L
Net "clk" LOC="A10" | IOSTANDARD = LVCMOS33 | SLEW = SLOW | DRIVE = 8 | CLOCK_DEDICATED_ROUTE = FALSE; //GPIO0 
NET "paid" CLOCK_DEDICATED_ROUTE = FALSE;