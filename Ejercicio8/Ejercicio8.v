module Ejercicio8 (iJ, iK, iCLK, oQ, oQnot); 
	output oQ,oQnot; 
	input iJ,iK,iCLK; 
	reg oQ; 
	assign oQnot = ~oQ; 
	always @ (posedge iCLK) 
		case ({iJ,iK}) 
			2'b00: oQ = oQ; 
			2'b01: oQ = 1'b0; 
			2'b10: oQ = 1'b1; 
			2'b11: oQ = ~oQ; 
		endcase 
endmodule 