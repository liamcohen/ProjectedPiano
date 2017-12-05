library verilog;
use verilog.vl_types.all;
entity ac97 is
    port(
        ready           : out    vl_logic;
        command_address : in     vl_logic_vector(7 downto 0);
        command_data    : in     vl_logic_vector(15 downto 0);
        command_valid   : in     vl_logic;
        left_data       : in     vl_logic_vector(19 downto 0);
        left_valid      : in     vl_logic;
        right_data      : in     vl_logic_vector(19 downto 0);
        right_valid     : in     vl_logic;
        left_in_data    : out    vl_logic_vector(19 downto 0);
        right_in_data   : out    vl_logic_vector(19 downto 0);
        ac97_sdata_out  : out    vl_logic;
        ac97_sdata_in   : in     vl_logic;
        ac97_synch      : out    vl_logic;
        ac97_bit_clock  : in     vl_logic
    );
end ac97;
