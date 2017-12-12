library verilog;
use verilog.vl_types.all;
entity fir31 is
    generic(
        \WAIT\          : integer := 0;
        INCREMENT       : integer := 1
    );
    port(
        clock           : in     vl_logic;
        reset           : in     vl_logic;
        ready           : in     vl_logic;
        x               : in     vl_logic_vector(7 downto 0);
        y               : out    vl_logic_vector(17 downto 0)
    );
end fir31;
