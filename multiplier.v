//Algoritmul lui Booth
module booth(
	output signed[14:0] out,
	input signed[7:0] nr1,
	input signed[7:0] nr2);
	
reg[16:0] A;	
reg[16:0] S;
reg signed[16:0] P;

reg signed[7:0] m;  //multiplicand
reg signed[7:0] r;  //multiplier
integer i;          //variabila integer pentru contorizarea pasilor
reg signed[14:0] rez; //rezultatul final

always @(nr1,nr2)
begin
	//Etapa 1 de initializare conform algoritmului
	m = nr1; 
	r = nr2;
	
	A = {m, 9'b0};
	S = {-m, 9'b0};
	P = {8'b0, r, 1'b0};
	
	//Numerele sunt pe 8 biti, deci se vor efectua 8 iteratii
	for(i = 0;i < 8;i = i + 1)
	begin
		case(P[1:0])
			2'b01: P=P+A;
			
			2'b10: P=P+S;
			
			2'b00: P=P; 
			
			2'b11: P=P;
		endcase
		P=P >>> 1;
		rez={P[16],P[14:1]};
	end
	
end

assign out=rez;

endmodule



////==================================================
module multiplier(
	output[14:0] product,
	input [14:0] x,
	input [14:0] y);
	
	
reg[6:0] x0; //se vor stoca aici bitii de la 0 la 6 din x
reg[6:0] x1; //se vor stoca aici bitii de la 7 la 13 din x
reg x2; //se va stoca aici bitul 14 din x

reg[6:0] y0; //se vor stoca aici bitii de la 0 la 6 din y
reg[6:0] y1; //se vor stoca aici bitii de la 7 la 13 din y
reg y2;  //se va stoca aici bitul 14 din y

reg x_semn; //semnul x
reg[3:0] X_unitati; //cifra unitatilor din x
reg[3:0] X_zecimal; //cifra zecilor din x

reg y_semn;  //semnul y
reg[3:0] Y_unitati; //cifra unitatilor din y
reg[3:0] Y_zecimal; //cifra zecilor din y


reg[6:0] X_bin;  //x binar
reg[6:0] Y_bin;  //y binar

reg[7:0] x_i;  //x cod indirect
reg[7:0] y_i;  //y cod indirect

reg signed[7:0] X_c2;  //x complement 2
reg signed[7:0] Y_c2;  //y complement 2

always @(x)
begin
	x0 = x[6:0];
	x1 = x[13:7];
	x2 = x[14];
	
	case(x0)
	
	7'b1111110: X_unitati = 0;
	7'b0110000: X_unitati = 1;
	7'b1101101: X_unitati = 2;
	7'b1111001: X_unitati = 3;
	7'b0110011: X_unitati = 4;
	7'b1011011: X_unitati = 5;
	7'b1011111: X_unitati = 6;
	7'b1110000: X_unitati = 7;
	7'b1111111: X_unitati = 8;
	7'b1111011: X_unitati = 9;
	endcase
	
	case(x1)
	7'b1111110: X_zecimal = 0;
	7'b0110000: X_zecimal = 1;
	7'b1101101: X_zecimal = 2;
	7'b1111001: X_zecimal = 3;
	7'b0110011: X_zecimal = 4;
	7'b1011011: X_zecimal = 5;
	7'b1011111: X_zecimal = 6;
	7'b1110000: X_zecimal = 7;
	7'b1111111: X_zecimal = 8;
	7'b1111011: X_zecimal = 9;
	endcase
	
	case(x2)
	1'b0: x_semn = 0;
	1'b1: x_semn = 1;
	endcase
	
	X_bin = (X_zecimal *4'd10) + X_unitati; //trandormarea din BCD in binar a lui x
	
	//transformarea din binar in complement fata de 2 a lui x
	if(x_semn == 0)
	begin
		X_c2 = {x_semn,X_bin};
	end
	else if(x_semn == 1)
	begin
		x_i = {x_semn,~X_bin};
		X_c2 = x_i +8'b00000001;
	end

end

always @(y)
begin
	y0 = y[6:0];
	y1 = y[13:7];
	y2 = y[14];
	
	case(y0)
	
	7'b1111110: Y_unitati = 0;
	7'b0110000: Y_unitati = 1;
	7'b1101101: Y_unitati = 2;
	7'b1111001: Y_unitati = 3;
	7'b0110011: Y_unitati = 4;
	7'b1011011: Y_unitati = 5;
	7'b1011111: Y_unitati = 6;
	7'b1110000: Y_unitati = 7;
	7'b1111111: Y_unitati = 8;
	7'b1111011: Y_unitati = 9;
	endcase
	
	case(y1)
	7'b1111110: Y_zecimal = 0;
	7'b0110000: Y_zecimal = 1;
	7'b1101101: Y_zecimal = 2;
	7'b1111001: Y_zecimal = 3;
	7'b0110011: Y_zecimal = 4;
	7'b1011011: Y_zecimal = 5;
	7'b1011111: Y_zecimal = 6;
	7'b1110000: Y_zecimal = 7;
	7'b1111111: Y_zecimal = 8;
	7'b1111011: Y_zecimal = 9;
	endcase
	
	case(y2)
	1'b0: y_semn = 0;
	1'b1: y_semn = 1;
	endcase
	
	Y_bin = (Y_zecimal *4'd10) + Y_unitati; //trandormarea din BCD in binar a lui x
	
	//transformarea din binar in complement fata de 2 a lui x
	if(y_semn == 0)
	begin
		Y_c2 = {y_semn,Y_bin};
	end
	else if(y_semn == 1)
	begin
		y_i = {y_semn,~Y_bin};
		Y_c2 = y_i +8'b00000001;
	end

end

//Aplicare algoritm pentru x si y in cod complement fata de 2
booth b(product,X_c2, Y_c2);


endmodule
