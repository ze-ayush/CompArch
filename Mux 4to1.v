module mux (
    input s0,s1,a,b,c,d, 
    output o);
    assign o = s1 ? (s0 ? d : c) : (s0 ? b : a);
endmodule

module mux_tb();
reg s0,s1,a,b,c,d;
wire o;
mux f(s0,s1,a,b,c,d,o);
initial
    begin
     $dumpfile("mux.vcd");
     $dumpvars;
    end
 always begin
        #0 a=0;
        b=1;
        c=0;
        d=0;
        s0=1;
        s1=0;
        #2 $display($time," o=%b", o);
        #4  a=0;
        b=0;
        c=0;
        d=1;
        s0=1;
        s1=1;
        #2 $display($time," o=%b", o); 
        #8 $finish;
    end



endmodule