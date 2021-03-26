module d_sync( output reg q, q1, 
               input wire clk, in , rst );
always @(posedge clk ) 
begin
    if (rst) 
      q=0;
    else
      q=in;
    q1=~q; 
end
endmodule

module tb_dsync;
    reg in,clk,rst;
    wire out, out1;
    initial begin
		$dumpfile("new.vcd");
		$dumpvars;
	end
    always begin
        #2 clk = ~clk;
    end
    d_sync des( out , out1 , clk, in, rst);
    initial begin
        clk = 1'b0;
        in=1;
        #0 
        rst = 1'b1;
        #2 rst = 1'b0;
            in=1;
        #4 rst = 1'b1;
            in=1;    

        #8 $finish;
    end
initial
		$monitor($time," CLK = %b, RESET = %b, Out = %b , Out'= %b", clk, rst, out, out1 );
endmodule