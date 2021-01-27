module DualWriteRegfile #(
    parameter embedded = 1
)(
    input clk,
    rf_drdw_intf.from_rf RfIntf
);
localparam raddr_w = embedded ? 4 : 5;
reg [31:0] Registers [1:(2**raddr_w)-1];
always_ff @(posedge clk) begin
    if(|RfIntf.Rd1Addr) begin
        Registers[RfIntf.Rd1Addr] <= RfIntf.Rd1Data;
    end
end
always_ff @(posedge clk) begin
    if(|RfIntf.Rd2Addr) begin
        Registers[RfIntf.Rd2Addr] <= RfIntf.Rd2Data;
    end
end
assign RfIntf.Rs1Data = |RfIntf.Rs1Addr ? Registers[RfIntf.Rs1Addr] : '0;
assign RfIntf.Rs2Data = |RfIntf.Rs2Addr ? Registers[RfIntf.Rs2Addr] : '0;
endmodule