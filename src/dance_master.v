//====================================================================================
//                        ------->  Revision History  <------
//====================================================================================
//
//   Date     Who   Ver  Changes
//====================================================================================
// 02-May-22  DWW     1  Initial creation
//====================================================================================

/*

     This module serves as an example of an AXI4-Lite Master

*/


module dance_master # (parameter FREQ_HZ = 100000000, SLAVE_ADDR = 32'h1000)
(

    input wire clk, resetn,

    input button,
    
    // We only use 10 bits. So the max dealy is around ~1s.
    input[9:0] delay_ms,
    
    // 6 bits to define the pattern
    input[5:0] input_pattern,


    //====================  An AXI-Lite Master Interface  ======================

    // "Specify write address"          -- Master --    -- Slave --
    output[31:0]                        M_AXI_AWADDR,   
    output                              M_AXI_AWVALID,  
    input                                               M_AXI_AWREADY,

    // "Write Data"                     -- Master --    -- Slave --
    output[31:0]                        M_AXI_WDATA,      
    output                              M_AXI_WVALID,
    output[3:0]                         M_AXI_WSTRB,
    input                                               M_AXI_WREADY,

    // "Send Write Response"            -- Master --    -- Slave --
    input[1:0]                                          M_AXI_BRESP,
    input                                               M_AXI_BVALID,
    output                              M_AXI_BREADY,

    // "Specify read address"           -- Master --    -- Slave --
    output[31:0]                        M_AXI_ARADDR,     
    output                              M_AXI_ARVALID,
    input                                               M_AXI_ARREADY,

    // "Read data back to master"       -- Master --    -- Slave --
    input[31:0]                                         M_AXI_RDATA,
    input                                               M_AXI_RVALID,
    input[1:0]                                          M_AXI_RRESP,
    output                              M_AXI_RREADY
    //==========================================================================
);


//==========================================================================
// We use these as the AMCI interface to an AXI4-Lite Master
//==========================================================================
reg[31:0]  AMCI_WADDR;
reg[31:0]  AMCI_WDATA;
reg        AMCI_WRITE;
wire[1:0]  AMCI_WRESP;
wire       AMCI_WIDLE;
reg[31:0]  AMCI_RADDR;
reg        AMCI_READ;
wire[31:0] AMCI_RDATA;
wire[1:0]  AMCI_RRESP;
wire       AMCI_RIDLE;
//==========================================================================

//==========================================================================
// We use these to control the start/pause states.
//==========================================================================
reg[0:0] reg_dance;

//==========================================================================
// Controls the start/pause signals for the dancing state machine.
//==========================================================================
always @(posedge clk) begin
   
    // Go to reset state -> dance off!
    if (resetn == 0) begin
            reg_dance <= 0;

    end else if (button) begin
            // If the button gets pressed, start or pause the dancing.
            reg_dance <= ~reg_dance;
    end
end
//==========================================================================

//==========================================================================
// We use these to control the dance_master main state machine
//==========================================================================
// This is the state of our state machine
reg[3:0]  dance_fsm_state;

// 1 means to the right, 0 to the left.
reg       direction;

// Constants to represent the direction the cylon-eye is moving
localparam DIR_LEFT  = 0;
localparam DIR_RIGHT = 1;

reg[15:0] pattern;
localparam MIN_START_PATTERN = 16'h0001;


// Used to handle the delay.
reg[31:0] reg_delay;

//==========================================================================
// This state machine generates the dancing patterns.
//==========================================================================
always @(posedge clk) begin

    AMCI_READ <= 0;
    AMCI_WRITE <= 0;
    
    if(reg_delay) reg_delay <= reg_delay -1;
    
    // Go to reset state in case we get a reset signal or if we read the button and are in on state (LEDs dance is running).
    if (resetn == 0) begin
            dance_fsm_state     <= 0;
            pattern             <= input_pattern | MIN_START_PATTERN;
            direction           <= 0;
            reg_delay           <= 0;  

    end else case (dance_fsm_state)
                   // If the timer has expired, update the pattern       
        0:   if (reg_dance & (reg_delay == 0)) begin
                AMCI_WADDR <= SLAVE_ADDR;
                AMCI_WDATA <= pattern;
                AMCI_WRITE <= 1;
                dance_fsm_state <= dance_fsm_state + 1;                
             end
        1:  begin
                // if we are going left and did not touch the left edge yet:
                if((direction == DIR_LEFT) && !(pattern & 16'h8000)) begin
                    pattern <= (pattern << 1);
                // if we are going right and did not touch the right edge yet:
                end else if((direction == DIR_RIGHT) && !(pattern & 16'h0001)) begin
                    pattern <= (pattern >> 1);
                // otherwise just invert the direction
                end else begin
                    direction <= ~direction;
                end
                dance_fsm_state <= dance_fsm_state + 1;                
            end
             // Wait until the write is done, determine the direction and restart the delay.
        2:   if(AMCI_WIDLE) begin
              
               // One bit of the switches represents a delay of 100us.
               // The clock runs with a 10ns period. Therefore we have to
               // multiply by 100000 to get the needed amount of clock cycles withing 1ms.
               // Mask out the highest 4 bits to avoid too slow delays.
               reg_delay <= delay_ms * 100000;
               dance_fsm_state <= 0;                
             end

    endcase

end
//==========================================================================


//==========================================================================
// This wires a connection to an AXI4-Lite bus master
//==========================================================================
axi4_lite_master
(
    .clk            (clk),
    .resetn         (resetn),
    .AMCI_WADDR     (AMCI_WADDR),
    .AMCI_WDATA     (AMCI_WDATA),
    .AMCI_WRITE     (AMCI_WRITE),
    .AMCI_WRESP     (AMCI_WRESP),
    .AMCI_WIDLE     (AMCI_WIDLE),

    .AMCI_RADDR     (AMCI_RADDR),
    .AMCI_READ      (AMCI_READ ),
    .AMCI_RDATA     (AMCI_RDATA),
    .AMCI_RRESP     (AMCI_RRESP),
    .AMCI_RIDLE     (AMCI_RIDLE),

    .AXI_AWADDR     (M_AXI_AWADDR),
    .AXI_AWVALID    (M_AXI_AWVALID),
    .AXI_AWREADY    (M_AXI_AWREADY),

    .AXI_WDATA      (M_AXI_WDATA),
    .AXI_WVALID     (M_AXI_WVALID),
    .AXI_WSTRB      (M_AXI_WSTRB),
    .AXI_WREADY     (M_AXI_WREADY),

    .AXI_BRESP      (M_AXI_BRESP),
    .AXI_BVALID     (M_AXI_BVALID),
    .AXI_BREADY     (M_AXI_BREADY),

    .AXI_ARADDR     (M_AXI_ARADDR),
    .AXI_ARVALID    (M_AXI_ARVALID),
    .AXI_ARREADY    (M_AXI_ARREADY),

    .AXI_RDATA      (M_AXI_RDATA),
    .AXI_RVALID     (M_AXI_RVALID),
    .AXI_RRESP      (M_AXI_RRESP),
    .AXI_RREADY     (M_AXI_RREADY)
);
//==========================================================================



endmodule