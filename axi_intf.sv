
interface axi_intf #(parameter DATA_WIDTH = 8) (input clk,rst);

    /*
     * AXI input
     */
    logic [DATA_WIDTH-1:0]          s_axis_tdata;
    logic                           s_axis_tvalid;
    logic                           s_axis_tready;

     /*
      *  AXI Optional signals
      */
 
    logic [7:0]                     s_tid; //maximum 8 bits wide
    logic                           s_tlast;
    logic [3:0]                     s_tdest;
    logic [DATA_WIDTH/8 - 1 :0]     s_tstrb;
    logic [DATA_WIDTH/8 - 1 :0]     s_tkeep;

    logic [7:0]                     m_tid; //maximum 8 bits wide
    logic                           m_tlast;
    logic [3:0]                     m_tdest;
    logic [DATA_WIDTH/8 - 1 :0]     m_tstrb;
    logic [DATA_WIDTH/8 - 1 :0]     m_tkeep;
    
    /*
     * AXI output
     */
    logic [DATA_WIDTH-1:0]          m_axis_tdata;
    logic                           m_axis_tvalid;
    logic                           m_axis_tready;

    `ifdef UART
    /*
     * UART interface
     */
    logic                   rxd;
    logic                   txd;

    /*
     * Status
     */
    logic                   tx_busy;
    logic                   rx_busy;
    logic                   rx_overrun_error;
    logic                   rx_frame_error;

    /*
     * Configuration
     */
    logic [15:0]            prescale;
    `endif


    `ifndef UART
        assign m_axis_tdata   = s_axis_tdata;
        assign m_axis_tvalid  = s_axis_tvalid;
        assign s_axis_tready  = m_axis_tready;
        assign m_tid          = s_tid;
        assign m_tstrb        = s_tstrb;
        assign m_tkeep        = s_tkeep;
        assign m_tdest        = s_tdest;
        assign m_tlast        = s_tlast;
    `endif

    `ifndef UART
        assert property((@(posedge clk) $rose(s_axis_tvalid) |->  ##[0:16] s_axis_tready)); //16 clocks maximum time for ready to assert
    `endif





endinterface
