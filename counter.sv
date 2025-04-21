module counter #(
    parameter length = 10;
) (
    input logic [length-1:0] d_in,
    input logic clk, id, u_d, cen,
    output logic [length-1:0] q,
    output logic cout
);

logic [length-1:0] count = 0;

always_ff @( posedge clk ) begin
    if (cen) begin
        if (ld) 
            count <= d_in;
        else if (u_d)
            count <= count + 1;
        else
            count <= count - 1;
    end
end
    
endmodule