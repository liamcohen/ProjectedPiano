library verilog;
use verilog.vl_types.all;
entity ac97commands is
    port(
        clock           : in     vl_logic;
        ready           : in     vl_logic;
        command_address : out    vl_logic_vector(7 downto 0);
        command_data    : out    vl_logic_vector(15 downto 0);
        command_valid   : out    vl_logic;
        volume          : in     vl_logic_vector(4 downto 0);
        source          : in     vl_logic_vector(2 downto 0)
    );
end ac97commands;
