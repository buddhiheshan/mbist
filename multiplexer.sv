module multiplexer #(
   parameter WIDTH
) (
    input logic [WIDTH-1:0] normal_in, bist_in,
    input logic Nbart,

    output logic [WIDTH-1:0] out
);

assign out = Nbart ? bist_in : normal_in;
    
endmodule