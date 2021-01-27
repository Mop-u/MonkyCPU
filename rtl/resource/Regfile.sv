module Regfile #(
    parameter embedded = 1
)(
    input clk,
    rf_drsw_intf.from_rf RfIntf
);
localparam raddr_w = embedded ? 4 : 5;
reg [31:0] Registers [1:(2**raddr_w)-1];
always_ff @(posedge clk) begin
    if(|RfIntf.RdAddr) begin
        Registers[RfIntf.RdAddr] <= RfIntf.RdData;
    end
end
assign RfIntf.Rs1Data = |RfIntf.Rs1Addr ? Registers[RfIntf.Rs1Addr] : '0;
assign RfIntf.Rs2Data = |RfIntf.Rs2Addr ? Registers[RfIntf.Rs2Addr] : '0;
endmodule