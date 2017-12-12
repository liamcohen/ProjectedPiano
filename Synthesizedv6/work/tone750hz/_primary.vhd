library verilog;
use verilog.vl_types.all;
entity tone750hz is
    port(
        clock           : in     vl_logic;
        ready           : in     vl_logic;
        pcm_data        : out    vl_logic_vector(19 downto 0)
    );
end tone750hz;
