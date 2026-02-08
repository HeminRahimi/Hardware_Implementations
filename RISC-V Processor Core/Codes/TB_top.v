
module TB_top ();

    reg rst, clk;

    Top MUT (clk, rst);

    always #5 clk = ~clk;

    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0, TB_top);
        clk = 0 ; rst = 1;
        #10;
        rst = 0;
        #85;
        $finish;
    end

endmodule
