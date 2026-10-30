module Ejercicio9 (
    input iJ,
    input iK,
    input iCLK,
    output oQ,
    output oQnot
);

reg rQ;

assign oQ = rQ;
assign oQnot = ~rQ;

always @(posedge iCLK)
begin
    if ((iJ == 1'b0) && (iK == 1'b0))
        rQ <= rQ;
    else if ((iJ == 1'b0) && (iK == 1'b1))
        rQ <= 1'b0;
    else if ((iJ == 1'b1) && (iK == 1'b0))
        rQ <= 1'b1;
    else
        rQ <= ~rQ;
end

endmodule