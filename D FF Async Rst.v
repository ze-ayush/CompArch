module d_async( output reg q, q1, 
                input wire clk, in , rst );
always @(posedge clk or posedge rst ) 
begin
    if (rst) 
      q=0;
    else
      q=in;
    q1=~q; 
end
endmodule

module tb_dasync;
    reg in,clk,rst;
    wire out, out1;
    initial begin
		$dumpfile("dsync.vcd");
		$dumpvars;
	end
    always begin
        #2 clk = ~clk;
    end
    d_async des( out , out1 , clk, in, rst);
    initial begin
        clk = 1'b0;
        in=1;
        #0 
        rst = 1'b1;
        #2 rst = 1'b0;
            in=1;
        #4 rst = 1'b0;
            in=0;    

        #8 $finish;
    end

    initial
		$monitor($time," CLK = %b, RESET = %b, Out = %b , Out'= %b", clk, rst, out, out1 );
endmodule        