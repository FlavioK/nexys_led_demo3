//====================================================================================
//                        ------->  Revision History  <------
//====================================================================================
//
//   Date     Who   Ver  Changes
//====================================================================================
// 02-May-22  DWW     1  Initial creation
//====================================================================================

/*

     This module bounces a "cylon-eye" pattern back and forth on the 16-LEDs
     on the Nexys-A7.   The delay between LED patterns is specified in 
     milliseconds and is input via the 10 right-most slide-switches.

    The "Up" button serves as a start/pause button
*/


module dance_master # (parameter FREQ_HZ = 100000000, SLAVE_ADDR = 32'h1000)
(

    input wire clk, resetn,

    input button,

    // The delay between LED states, in milliseconds
    input[9:0] ms_delay,

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

// This is the number of clock-cycles per millisecond
localparam CLOCKS_PER_MSEC = FREQ_HZ/1000;

// Constants to represent the direction the cylon-eye is moving
localparam MOVE_LEFT  = 0;
localparam MOVE_RIGHT = 1;

// Constants that represent the LED pattern at either edge 
localparam LEFT_EDGE  = 16'he000;
localparam RIGHT_EDGE = 16'h0007;

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

// This is the state of our state machine
reg[3:0] fsm_state;

// This is a countdown timer for implementing delays
reg[31:0] delay;

// This is the direction the cylon-eye is currently moving
reg direction;

// This is the next pattern to drive out
reg[15:0] pattern;

//==========================================================================
// This state machine uses the button as a "start/stop" mechanism to 
// either set or clear 'running'
//==========================================================================
reg running;
always @(posedge clk) begin
    if (resetn == 0)
        running <= 0;
    else if (button)
        running <= ~running;
end
//==========================================================================



//==========================================================================
// This state machine drives a cylon-eye pattern back and forth across the
// 16 LEDs
//==========================================================================
always @(posedge clk) begin
    
    AMCI_READ <= 0;
    AMCI_WRITE <= 0;
    
    if (delay) delay <= delay - 1;

    if (resetn == 0) begin
        fsm_state <= 0;
    end else case (fsm_state)

        // Set up all the initial conditions
        0:  begin
                AMCI_WADDR <= SLAVE_ADDR;
                AMCI_WDATA <= 0;
                AMCI_WRITE <= 1;
                pattern    <= RIGHT_EDGE;
                direction  <= MOVE_LEFT;
                fsm_state  <= fsm_state + 1;
            end

        // If we're running, drive the desired pattern to the LEDs
        1:  if (running & AMCI_WIDLE) begin
                AMCI_WDATA <= pattern;
                AMCI_WRITE <= 1;
                delay      <= ms_delay * CLOCKS_PER_MSEC;
                fsm_state  <= fsm_state + 1;
            end

        // Compute the next pattern
        2:  begin
                // If the eye is moving left...
                if (direction == MOVE_LEFT) begin
                    if (pattern == LEFT_EDGE)
                        direction <= MOVE_RIGHT;
                    else
                        pattern <= pattern << 1;
                end

                // Otherwise, the eye is moving right...
                else if (pattern == RIGHT_EDGE)
                    direction <= MOVE_LEFT;
                else
                    pattern <= pattern >> 1;
                
                fsm_state <= fsm_state + 1;
            end

        // Once the timer expires, go write the new pattern to the LEDs
        3:  if (delay == 0) fsm_state <= 1;

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