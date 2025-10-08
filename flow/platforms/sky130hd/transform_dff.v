// This file converts a DFF into an "equivalent" DFF, making it more suitable for two-phase clocking. 
// This file also adds an extra DFF in the recirculation mux loop so that each DFF is being fed by 
// another DFF of the opposite clock.

// Note that each DFF in this file will be converted to a latch in another techmap pass

// From https://github.com/YosysHQ/yosys/blob/main/techlibs/common/simcells.v:
//      "A positive edge D-type flip-flop with positive polarity enable."
module \$_DFFE_PP_
(
    input D,
    input C,
    input E,
    output Q
);

    wire mux_latch_output;
    \$_DFF_P_ _TECHMAP_REPLACE_.mux_latch
    (
        .C(C),
        .D(Q),
        .Q(mux_latch_output)
    );

    wire mux_output;
    \$_MUX_ MUX
    (
        .A(mux_latch_output),
        .B(D),
        .S(E),
        .Y(mux_output)
    );

    // dlxtp only has a size of 1
    \$_DFF_P_ _TECHMAP_REPLACE_.main_latch (
        .C(C),
        .D(mux_output),
        .Q(Q)
    );

endmodule

// From https://github.com/YosysHQ/yosys/blob/main/techlibs/common/simcells.v:
//      "A positive edge D-type flip-flop with negative polarity synchronous reset and positive 
//      polarity clock enable (with reset having priority)".
module \$_SDFFE_PN0P_
(
    input D,
    input C,
    input R,
    input E,
    output Q
);

    wire mux_latch_output;
    \$_DFF_P_ _TECHMAP_REPLACE_.mux_latch
    (
        .C(C),
        .D(Q),
        .Q(mux_latch_output)
    );

    wire mux_output_1;
    \$_MUX_ MUX_1
    (
        .A(mux_latch_output),
        .B(D),
        .S(E),
        .Y(mux_output_1)
    );

    wire mux_output_2;
    \$_MUX_ MUX_2
    (
        .A(1'b0),
        .B(mux_output_1),
        .S(R),
        .Y(mux_output_2)
    );
    
    \$_DFF_P_ _TECHMAP_REPLACE_ (
        .C(C),
        .D(mux_output_2),
        .Q(Q)
    );

endmodule

// From https://github.com/YosysHQ/yosys/blob/main/techlibs/common/simcells.v:
//      "A positive edge D-type flip-flop with positive polarity synchronous reset and positive
//      polarity clock enable (with reset having priority)."
module \$_SDFFE_PP0P_
(
    input D,
    input C,
    input R,
    input E,
    output Q
);

    wire mux_latch_output;
    \$_DFF_P_ _TECHMAP_REPLACE_.mux_latch
    (
        .C(C),
        .D(Q),
        .Q(mux_latch_output)
    );

    wire mux_output_1;
    \$_MUX_ MUX_1
    (
        .A(mux_latch_output),
        .B(D),
        .S(E),
        .Y(mux_output_1)
    );

    wire mux_output_2;
    \$_MUX_ MUX_2
    (
        .A(mux_output_1),
        .B(1'b0),
        .S(R),
        .Y(mux_output_2)
    );
    
    \$_DFF_P_ _TECHMAP_REPLACE_ (
        .C(C),
        .D(mux_output_2),
        .Q(Q)
    );

endmodule

// From https://github.com/YosysHQ/yosys/blob/main/techlibs/common/simcells.v:
//      "A positive edge D-type flip-flop with positive polarity synchronous reset."
module \$_SDFF_PP0_
(
    input D,
    input C,
    input R,
    output Q
);

    wire mux_output;
    \$_MUX_ MUX
    (
        .A(D),
        .B(1'b0),
        .S(R),
        .Y(mux_output)
    );

    \$_DFF_P_ _TECHMAP_REPLACE_ (
        .C(C),
        .D(mux_output),
        .Q(Q)
    );

endmodule

// From https://github.com/YosysHQ/yosys/blob/main/techlibs/common/simcells.v:
//      "A positive edge D-type flip-flop with positive polarity synchronous set."
module \$_SDFF_PP1_
(
    input D,
    input C,
    input R,
    output Q
);

    wire mux_output;
    \$_MUX_ MUX
    (
        .A(D),
        .B(1'b1),
        .S(R),
        .Y(mux_output)
    );

    \$_DFF_P_ _TECHMAP_REPLACE_ (
        .C(C),
        .D(mux_output),
        .Q(Q)
    );

endmodule

// From https://github.com/YosysHQ/yosys/blob/main/techlibs/common/simcells.v:
//      "A positive edge D-type flip-flop with positive polarity reset and positive polarity clock
//      enable."
module \$_DFFE_PP0P_
(
    input D,
    input C,
    input R,
    input E,
    output Q
);

    wire mux_latch_output;
    \$_DFF_P_ _TECHMAP_REPLACE_.mux_latch
    (
        .C(C),
        .D(Q),
        .Q(mux_latch_output)
    );

    wire mux_output;
    \$_MUX_ MUX
    (
        .A(mux_latch_output),
        .B(D),
        .S(E),
        .Y(mux_output)
    );

    \$_DFF_PP0_ _TECHMAP_REPLACE_ (
        .C(C),
        .R(R),
        .D(mux_output),
        .Q(Q)
    );

endmodule
