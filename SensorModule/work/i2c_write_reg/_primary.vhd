library verilog;
use verilog.vl_types.all;
entity i2c_write_reg is
    generic(
        S_RESET         : integer := 0;
        S_VALIDATE_BUS  : integer := 1;
        S_VALIDATE_TIMEOUT: integer := 2;
        S_WRITE_REG_ADDRESS_0: integer := 3;
        S_WRITE_REG_ADDRESS_1: integer := 4;
        S_WRITE_REG_ADDRESS_TIMEOUT: integer := 5;
        S_WRITE_DATA_0  : integer := 6;
        S_WRITE_DATA_1  : integer := 7;
        S_WRITE_DATA_TIMEOUT: integer := 8;
        S_CHECK_I2C_FREE: integer := 9;
        S_CHECK_I2C_FREE_TIMEOUT: integer := 10
    );
    port(
        dev_address     : in     vl_logic_vector(5 downto 0);
        reg_address     : in     vl_logic_vector(7 downto 0);
        data            : in     vl_logic_vector(7 downto 0);
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        start           : in     vl_logic;
        done            : out    vl_logic;
        timer_exp       : in     vl_logic;
        timer_start     : out    vl_logic;
        timer_param     : out    vl_logic_vector(3 downto 0);
        i2c_data_in_ready: in     vl_logic;
        i2c_cmd_ready   : in     vl_logic;
        i2c_bus_busy    : in     vl_logic;
        i2c_bus_control : in     vl_logic;
        i2c_bus_active  : in     vl_logic;
        i2c_missed_ack  : in     vl_logic;
        i2c_data_out    : out    vl_logic_vector(7 downto 0);
        i2c_dev_address : out    vl_logic_vector(5 downto 0);
        i2c_cmd_start   : out    vl_logic;
        i2c_cmd_write_multiple: out    vl_logic;
        i2c_cmd_stop    : out    vl_logic;
        i2c_cmd_valid   : out    vl_logic;
        i2c_data_in_valid: out    vl_logic;
        i2c_data_in_last: out    vl_logic;
        state_out       : out    vl_logic_vector(3 downto 0);
        message_failure : out    vl_logic;
        i2c_control     : out    vl_logic;
        i2c_relinquish  : in     vl_logic
    );
end i2c_write_reg;