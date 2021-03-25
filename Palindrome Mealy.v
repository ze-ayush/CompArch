module mealy(output reg y, input clk,rst,din);

parameter idle = 3'b000,
got0=3'b001,
got1=3'b010,
got00=3'b011,
got01=3'b100,
got10=3'b101,
got11=3'b110;

reg [2:0] pres,next;

always @(posedge clk ) begin
    if (rst)
    pres <= idle;
    else
    pres <= next;
end

always @(pres, din) 
begin
y=1'b0;
case (pres)
    idle : y=0;
    got0 : y=0;
    got1 : y=0;
    got00 : y=din?0:1;
    got01 : y=din?0:1;
    got10 : y=din?1:0;
    got11 : y=din?1:0;
endcase
end

always @(pres, din) begin
next=pres;
case (pres)
    idle : next=din?got1:got0;
    got0 : next=din?got01:got00;
    got1 : next=din?got11:got10;
    got00 : next=din?got01:got00;
    got01 : next=din?got11:got10;
    got10 : next=din?got01:got00;
    got11 : next=din?got11:got01;
endcase
end

endmodule

module test();
wire y ;
reg rst, in, clk ; 

initial begin
    $dumpfile("mealy.vcd");
	$dumpvars;
end

mealy m(y,clk, rst ,in);

always    
    forever #5 clk = ~clk ;   

initial  
$monitor($time, "Input=%b Output=%b ", in,y );


initial
begin
    clk=1'b0;
    #10 rst=1'b1;
    #10 rst=1'b0;
    #40 rst=1'b0;
    #200 rst=1'b1;
    #1000 $finish;
end

initial repeat(20) @(posedge clk ) in=$random; 

endmodule