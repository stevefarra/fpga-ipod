`default_nettype none
module simple_ipod_solution(
    CLOCK_50,
    LEDR,
    KEY,
    SW,
    HEX0,
    HEX1,
    HEX2,
    HEX3,
    HEX4,
    HEX5,
    AUD_ADCDAT,
    AUD_ADCLRCK,
    AUD_BCLK,
    AUD_DACDAT,
    AUD_DACLRCK,
    AUD_XCK,
    FPGA_I2C_SCLK,
    FPGA_I2C_SDAT,
    PS2_CLK,
    PS2_DAT,
    DRAM_ADDR,
    DRAM_BA,
    DRAM_CAS_N,
    DRAM_CKE,
    DRAM_CLK,
    DRAM_CS_N,
    DRAM_DQ,
    DRAM_LDQM,
    DRAM_UDQM,
    DRAM_RAS_N,
    DRAM_WE_N,
    GPIO_0,
    GPIO_1
);

`define zero_pad(width,signal)  {{((width)-$size(signal)){1'b0}},(signal)}

//=======================================================
//  Port declarations
//=======================================================

//////////// CLOCK //////////
input                       CLOCK_50;
//////////// LED //////////
output           [9:0]      LEDR;
//////////// KEY //////////
input            [3:0]      KEY;
//////////// SW //////////
input            [9:0]      SW;
//////////// SEG7 //////////
output           [6:0]      HEX0;
output           [6:0]      HEX1;
output           [6:0]      HEX2;
output           [6:0]      HEX3;
output           [6:0]      HEX4;
output           [6:0]      HEX5;
//////////// Audio //////////
input                       AUD_ADCDAT;
inout                       AUD_ADCLRCK;
inout                       AUD_BCLK;
output                      AUD_DACDAT;
inout                       AUD_DACLRCK;
output                      AUD_XCK;
//////////// I2C for Audio  //////////
output                      FPGA_I2C_SCLK;
inout                       FPGA_I2C_SDAT;
//////////// PS2 //////////
inout                       PS2_CLK;
inout                       PS2_DAT;
//////////// GPIO //////////
inout           [35:0]      GPIO_0;
inout           [35:0]      GPIO_1;       
//////////// SDRAM //////////
output          [12:0]      DRAM_ADDR;
output          [1:0]       DRAM_BA;
output                      DRAM_CAS_N;
output                      DRAM_CKE;
output                      DRAM_CLK;
output                      DRAM_CS_N;
inout           [15:0]      DRAM_DQ;
output                      DRAM_LDQM;
output                      DRAM_UDQM;
output                      DRAM_RAS_N;
output                      DRAM_WE_N;

//=======================================================
//  Reg/wire declarations
//=======================================================

// Input and output declarations
logic        CLK_50M;
logic  [9:0] LED;

assign CLK_50M   = CLOCK_50;
assign LEDR[9:0] = LED[9:0];

//Character definitions

//numbers
parameter character_0 =8'h30;
parameter character_1 =8'h31;
parameter character_2 =8'h32;
parameter character_3 =8'h33;
parameter character_4 =8'h34;
parameter character_5 =8'h35;
parameter character_6 =8'h36;
parameter character_7 =8'h37;
parameter character_8 =8'h38;
parameter character_9 =8'h39;


//Uppercase Letters
parameter character_A =8'h41;
parameter character_B =8'h42;
parameter character_C =8'h43;
parameter character_D =8'h44;
parameter character_E =8'h45;
parameter character_F =8'h46;
parameter character_G =8'h47;
parameter character_H =8'h48;
parameter character_I =8'h49;
parameter character_J =8'h4A;
parameter character_K =8'h4B;
parameter character_L =8'h4C;
parameter character_M =8'h4D;
parameter character_N =8'h4E;
parameter character_O =8'h4F;
parameter character_P =8'h50;
parameter character_Q =8'h51;
parameter character_R =8'h52;
parameter character_S =8'h53;
parameter character_T =8'h54;
parameter character_U =8'h55;
parameter character_V =8'h56;
parameter character_W =8'h57;
parameter character_X =8'h58;
parameter character_Y =8'h59;
parameter character_Z =8'h5A;

//Lowercase Letters
parameter character_lowercase_a= 8'h61;
parameter character_lowercase_b= 8'h62;
parameter character_lowercase_c= 8'h63;
parameter character_lowercase_d= 8'h64;
parameter character_lowercase_e= 8'h65;
parameter character_lowercase_f= 8'h66;
parameter character_lowercase_g= 8'h67;
parameter character_lowercase_h= 8'h68;
parameter character_lowercase_i= 8'h69;
parameter character_lowercase_j= 8'h6A;
parameter character_lowercase_k= 8'h6B;
parameter character_lowercase_l= 8'h6C;
parameter character_lowercase_m= 8'h6D;
parameter character_lowercase_n= 8'h6E;
parameter character_lowercase_o= 8'h6F;
parameter character_lowercase_p= 8'h70;
parameter character_lowercase_q= 8'h71;
parameter character_lowercase_r= 8'h72;
parameter character_lowercase_s= 8'h73;
parameter character_lowercase_t= 8'h74;
parameter character_lowercase_u= 8'h75;
parameter character_lowercase_v= 8'h76;
parameter character_lowercase_w= 8'h77;
parameter character_lowercase_x= 8'h78;
parameter character_lowercase_y= 8'h79;
parameter character_lowercase_z= 8'h7A;

//Other Characters
parameter character_colon = 8'h3A;          //':'
parameter character_stop = 8'h2E;           //'.'
parameter character_semi_colon = 8'h3B;     //';'
parameter character_minus = 8'h2D;          //'-'
parameter character_divide = 8'h2F;         //'/'
parameter character_plus = 8'h2B;           //'+'
parameter character_comma = 8'h2C;          // ','
parameter character_less_than = 8'h3C;      //'<'
parameter character_greater_than = 8'h3E;   //'>'
parameter character_equals = 8'h3D;         //'='
parameter character_question = 8'h3F;       //'?'
parameter character_dollar = 8'h24;         //'$'
parameter character_space=8'h20;            //' '     
parameter character_exclaim=8'h21;          //'!'

wire Clock_1KHz, Clock_1Hz;
wire Sample_Clk_Signal;

//=====================================================================================
//
// My code            
//
//=====================================================================================

wire [15:0] half_num_clk_cycles;
wire        clk_sample_async;
wire        clk_sample_sync;
wire        gen_addr;
wire        data_en;

wire        playpause;
wire        dir;

wire        flash_mem_read;
wire        flash_mem_waitrequest;
wire [22:0] flash_mem_address;
wire [31:0] flash_mem_readdata;
wire        flash_mem_readdatavalid;

freq_ctrl freq_ctrl_inst(
  .clk                 (CLK_50M),
  .speed_up            (speed_up_event),
  .speed_down          (speed_down_event),
  .speed_rst           (speed_reset_event),
  .freq_base           (16'h2af8),
  .half_num_clk_cycles (half_num_clk_cycles));

clk_divider gen_clk_sample(
  .rst                 (~KEY[3]),
  .half_num_clk_cycles (half_num_clk_cycles),
  .clk_in              (CLK_50M),
  .clk_out             (clk_sample_async)
);

clk_synchronizer sync_clk_sample(
  .clk       (CLK_50M),
  .clk_async (clk_sample_async),
  .clk_sync  (clk_sample_sync)
);

kbd_fsm kbd_fsm_inst(
  .clk       (CLK_50M),
  .rst       (~KEY[3]),
  .key       (kbd_received_ascii_code),
  .playpause (playpause),
  .dir       (dir)
);

addr_ctrl addr_ctrl_inst(
  .clk       (CLK_50M),
  .rst       (~KEY[3]),
  .en        (gen_addr),
  .playpause (playpause),
  .dir       (dir),
  .addr      (flash_mem_address)
);

flash_fsm flash_fsm_inst(
  .clk           (CLK_50M),
  .rst           (~KEY[3]),
  .start         (clk_sample_sync),
  .readdatavalid (flash_mem_readdatavalid),
  .gen_addr      (gen_addr),
  .read          (flash_mem_read),
  .data_en       (data_en)
);

flash flash_inst(
  .clk_clk                 (CLK_50M),
  .reset_reset_n           (1'b1),
  .flash_mem_write         (1'b0),
  .flash_mem_burstcount    (6'b000001),
  .flash_mem_waitrequest   (flash_mem_waitrequest),
  .flash_mem_read          (flash_mem_read),
  .flash_mem_address       (flash_mem_address),
  .flash_mem_writedata     (32'b0),
  .flash_mem_readdata      (flash_mem_readdata),
  .flash_mem_readdatavalid (flash_mem_readdatavalid),
  .flash_mem_byteenable    (4'b1111)
);

assign Sample_Clk_Signal = Clock_1KHz;

reg [15:0] audio_data; //generate signed sample audio signal

always @(posedge CLK_50M)
  if (data_en)
    audio_data = flash_mem_address[0] ? flash_mem_readdata[31:16] : flash_mem_readdata[15:0];

// Pacoblaze I/O & ROM signals
wire [9:0]  address;
wire [17:0] instruction;
wire [7:0]  port_id;
wire [7:0]  out_port;
reg  [7:0]  in_port;
wire        write_strobe;
wire        read_strobe;
reg         interrupt;
wire        interrupt_ack;

// Interrupt signals
reg [26:0] int_count;
reg        event_1hz;

// LCD operation signals
reg       lcd_rw_control;
reg [7:0] lcd_output_data;

wire [19:0] raw_instruction;

always @(posedge CLK_50M)
  instruction <= raw_instruction[17:0];

pacoblaze_instruction_memory pacoblaze_instruction_memory_inst(
  .addr    (address),
  .outdata (raw_instruction)
);

pacoblaze3 pacoblaze3_inst(
  .address       (address),
  .instruction   (instruction),
  .port_id       (port_id),
  .write_strobe  (write_strobe),
  .out_port      (out_port),
  .read_strobe   (read_strobe),
  .in_port       (in_port),
  .interrupt     (interrupt),
  .interrupt_ack (interrupt_ack),
  .reset         (1'b0),
  .clk           (CLK_50M)
);

// Blinking LED toggle
always @(posedge CLK_50M)
  if (write_strobe && port_id[0])
    LED[0] = out_port[0];

// Interrupt register
always @(posedge CLK_50M)
  if      (interrupt_ack) interrupt = 1'b0;
  else if (data_en)       interrupt = 1'b1;

assign in_port = audio_data;

// Filtering LED toggle
always @(posedge CLK_50M)
  if (write_strobe && port_id[2])
    LED[9:2] = out_port;

//=====================================================================================
//
//  Seven-Segment and speed control
//
//=====================================================================================

wire speed_up_event,
     speed_down_event;

//Generate 1 KHz Clock
Generate_Arbitrary_Divided_Clk32 Gen_1KHz_clk(
    .inclk         (CLK_50M),
    .outclk        (Clock_1KHz),
    .outclk_Not    (),
    .div_clk_count (32'h61A6), //change this if necessary to suit your module
    .Reset         (1'h1)
); 

wire speed_up_raw,
     speed_down_raw;

doublesync key0_doublsync(
    .indata  (!KEY[0]),
    .outdata (speed_up_raw),
    .clk     (Clock_1KHz),
    .reset   (1'b1)
);

doublesync key1_doublsync(
    .indata  (!KEY[1]),
    .outdata (speed_down_raw),
    .clk     (Clock_1KHz),
    .reset   (1'b1)
);

parameter num_updown_events_per_sec             = 10;
parameter num_1KHZ_clocks_between_updown_events = 1000/num_updown_events_per_sec;

reg [15:0] updown_counter = 0;

always @(posedge Clock_1KHz) begin
    if (updown_counter >= num_1KHZ_clocks_between_updown_events) begin
        if (speed_up_raw)
            speed_up_event_trigger <= 1;           
        if (speed_down_raw)
            speed_down_event_trigger <= 1;             
        updown_counter <= 0;
    end else begin 
        updown_counter <= updown_counter + 1;
        speed_up_event_trigger <=0;
        speed_down_event_trigger <= 0;
    end     
end

wire speed_up_event_trigger,
     speed_down_event_trigger;

async_trap_and_reset_gen_1_pulse make_speedup_pulse(
    .async_sig(speed_up_event_trigger), 
    .outclk(CLK_50M), 
    .out_sync_sig(speed_up_event), 
    .auto_reset(1'b1), 
    .reset(1'b1)
);
 
async_trap_and_reset_gen_1_pulse make_speedown_pulse(
    .async_sig(speed_down_event_trigger), 
    .outclk(CLK_50M), 
    .out_sync_sig(speed_down_event), 
    .auto_reset(1'b1), 
    .reset(1'b1)
);

wire speed_reset_event; 

doublesync key2_doublsync(
    .indata(!KEY[2]),
    .outdata(speed_reset_event),
    .clk(CLK_50M),
    .reset(1'b1)
);

parameter oscilloscope_speed_step = 100;

wire [15:0] speed_control_val;  

speed_reg_control speed_reg_control_inst(
    .clk(CLK_50M),
    .up_event(speed_up_event),
    .down_event(speed_down_event),
    .reset_event(speed_reset_event),
    .speed_control_val(speed_control_val)
);

logic     [15:0] scope_sampling_clock_count;
parameter [15:0] default_scope_sampling_clock_count = 12499; // 2 KHz


always @ (posedge CLK_50M) 
    scope_sampling_clock_count <= default_scope_sampling_clock_count+{{16{speed_control_val[15]}},speed_control_val};
        
logic [7:0] Seven_Seg_Val[5:0];
logic [3:0] Seven_Seg_Data[5:0];
    
SevenSegmentDisplayDecoder SevenSegmentDisplayDecoder_inst0(.ssOut(Seven_Seg_Val[0]), .nIn(Seven_Seg_Data[0]));
SevenSegmentDisplayDecoder SevenSegmentDisplayDecoder_inst1(.ssOut(Seven_Seg_Val[1]), .nIn(Seven_Seg_Data[1]));
SevenSegmentDisplayDecoder SevenSegmentDisplayDecoder_inst2(.ssOut(Seven_Seg_Val[2]), .nIn(Seven_Seg_Data[2]));
SevenSegmentDisplayDecoder SevenSegmentDisplayDecoder_inst3(.ssOut(Seven_Seg_Val[3]), .nIn(Seven_Seg_Data[3]));
SevenSegmentDisplayDecoder SevenSegmentDisplayDecoder_inst4(.ssOut(Seven_Seg_Val[4]), .nIn(Seven_Seg_Data[4]));
SevenSegmentDisplayDecoder SevenSegmentDisplayDecoder_inst5(.ssOut(Seven_Seg_Val[5]), .nIn(Seven_Seg_Data[5]));

assign HEX0 = Seven_Seg_Val[0];
assign HEX1 = Seven_Seg_Val[1];
assign HEX2 = Seven_Seg_Val[2];
assign HEX3 = Seven_Seg_Val[3];
assign HEX4 = Seven_Seg_Val[4];
assign HEX5 = Seven_Seg_Val[5];
            
wire Clock_2Hz;
            
Generate_Arbitrary_Divided_Clk32 Gen_2Hz_clk(
    .inclk         (CLK_50M),
    .outclk        (Clock_2Hz),
    .outclk_Not    (),
    .div_clk_count (32'h17D7840 >> 1),
    .Reset         (1'h1)
); 
        
logic [23:0] actual_7seg_output;
reg   [23:0] regd_actual_7seg_output;

always @(posedge Clock_2Hz) begin
    regd_actual_7seg_output <= actual_7seg_output;
    Clock_1Hz               <= ~Clock_1Hz;
end

assign Seven_Seg_Data[0] = regd_actual_7seg_output[3:0];
assign Seven_Seg_Data[1] = regd_actual_7seg_output[7:4];
assign Seven_Seg_Data[2] = regd_actual_7seg_output[11:8];
assign Seven_Seg_Data[3] = regd_actual_7seg_output[15:12];
assign Seven_Seg_Data[4] = regd_actual_7seg_output[19:16];
assign Seven_Seg_Data[5] = regd_actual_7seg_output[23:20];
    
assign actual_7seg_output =  scope_sampling_clock_count;

//=======================================================================================================================
//
//   Audio controller code - do not touch
//
//========================================================================================================================

wire [$size(audio_data)-1:0] actual_audio_data_left, actual_audio_data_right;
wire                         audio_left_clock, audio_right_clock;

to_slow_clk_interface interface_actual_audio_data_right(
    .indata(audio_data),
    .outdata(actual_audio_data_right),
    .inclk(CLK_50M),
    .outclk(audio_right_clock)
);
   
to_slow_clk_interface interface_actual_audio_data_left(
    .indata(audio_data),
    .outdata(actual_audio_data_left),
    .inclk(CLK_50M),
    .outclk(audio_left_clock)
);

audio_controller audio_control(
  // Clock Input (50 MHz)
  .iCLK_50(CLK_50M), // 50 MHz
  .iCLK_28(),        // 27 MHz
  //  7-SEG Displays
  // I2C
  .I2C_SDAT(FPGA_I2C_SDAT),  // I2C Data
  .oI2C_SCLK(FPGA_I2C_SCLK), // I2C Clock
  // Audio CODEC
  .AUD_ADCLRCK       (AUD_ADCLRCK),                   //  Audio CODEC ADC LR Clock
  .iAUD_ADCDAT       (AUD_ADCDAT),                    //  Audio CODEC ADC Data
  .AUD_DACLRCK       (AUD_DACLRCK),                   //  Audio CODEC DAC LR Clock
  .oAUD_DACDAT       (AUD_DACDAT),                    //  Audio CODEC DAC Data
  .AUD_BCLK          (AUD_BCLK),                      //  Audio CODEC Bit-Stream Clock
  .oAUD_XCK          (AUD_XCK),                       //  Audio CODEC Chip Clock
  .audio_outL        ({actual_audio_data_left,8'b1}), 
  .audio_outR        ({actual_audio_data_right,8'b1}),
  .audio_right_clock (audio_right_clock), 
  .audio_left_clock  (audio_left_clock)
);
endmodule
