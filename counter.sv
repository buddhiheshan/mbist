module counter #(
    parameter LENGTH = 10
) (
    input logic [LENGTH-1:0] d_in,
    input logic clk, ld, u_d, cen,
    output logic [LENGTH-1:0] q,
    output logic cout
);

logic [LENGTH-1:0] count;

assign q = count;

always_ff @( posedge clk ) begin
    if (cen) begin
        cout <= 1'b0;
        if (ld) 
            count <= d_in;
        else begin
            if (u_d) begin
                if (count === {LENGTH{1'b1}}) cout <= 1'b1;
                count <= count + 1;
            end
            else begin
                if (count === 0) cout <= 1'b1;
                count <= count - 1;
            end
        end
    end
end
    
endmodule