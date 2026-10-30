
module Ejercicio10 (
    input ix,
    input iCLK,
    input iRST,
    output reg oy
);

    // Declaracion de estados
    reg [1:0] Prstate, Nxtstate;

    parameter S0 = 2'b00,
              S1 = 2'b01,
              S2 = 2'b10,
              S3 = 2'b11;

    // Registro de estado
    always @(posedge iCLK or negedge iRST) begin
        if (!iRST)
            Prstate <= S0;
        else
            Prstate <= Nxtstate;
    end

    // Logica de siguiente estado
    always @(*) begin

        Nxtstate = S0;

        case (Prstate)

            S0: begin
                if (ix)
                    Nxtstate = S1;
                else
                    Nxtstate = S0;
            end

            S1: begin
                if (ix)
                    Nxtstate = S3;
                else
                    Nxtstate = S0;
            end

            S2: begin
                if (!ix)
                    Nxtstate = S0;
                else
                    Nxtstate = S2;
            end

            S3: begin
                if (ix)
                    Nxtstate = S2;
                else
                    Nxtstate = S0;
            end

            default: Nxtstate = S0;

        endcase
    end

    // Logica de salida
    always @(*) begin

        oy = 1'b0;

        case (Prstate)

            S0: oy = 1'b0;

            S1: begin
                if (ix)
                    oy = 1'b0;
                else
                    oy = 1'b1;
            end

            S2: begin
                if (ix)
                    oy = 1'b0;
                else
                    oy = 1'b1;
            end

            S3: begin
                if (ix)
                    oy = 1'b0;
                else
                    oy = 1'b1;
            end

            default: oy = 1'b0;

        endcase
    end

endmodule
