// This file converts a DFF that is used in one of the example designs into an "equivalent" latch. This
// file also adds an extra latch in the recirculation mux loop so that each latch is being fed by
// another latch of the opposite clock.

// From https://github.com/YosysHQ/yosys/blob/main/techlibs/common/simcells.v:
//      "A positive edge D-type flip-flop."
module \$_DFF_P_
(
    input D,
    input C,
    output Q
);

    // dlxtp only has 1 size
    sky130_fd_sc_hd__dlxtp_1 _TECHMAP_REPLACE_
    (
        .D(D),
        .GATE(C),
        .Q(Q)
    );

endmodule

// From https://github.com/YosysHQ/yosys/blob/main/techlibs/common/simcells.v:
//      "A positive edge D-type flip-flop with positive polarity reset."
module \$_DFF_PP0_
(
    input D,
    input C,
    input R,
    output Q
);

    wire inv_reset;
    sky130_fd_sc_hd__inv_1 INV (
        .A(R),
        .Y(inv_reset)
    );

    sky130_fd_sc_hd__dlrtp_1 _TECHMAP_REPLACE_ (
        .GATE(C),
        .RESET_B(inv_reset),
        .D(D),
        .Q(Q)
    );

endmodule
