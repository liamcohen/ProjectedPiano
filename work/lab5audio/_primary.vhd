library verilog;
use verilog.vl_types.all;
entity lab5audio is
    port(
        clock_27mhz     : in     vl_logic;
        reset           : in     vl_logic;
        volume          : in     vl_logic_vector(4 downto 0);
        audio_in_data   : out    vl_logic_vector(7 downto 0);
        audio_out_data  : in     vl_logic_vector(7 downto 0);
        ready           : out    vl_logic;
        audio_reset_b   : out    vl_logic;
        ac97_sdata_out  : out    vl_logic;
        ac97_sdata_in   : in     vl_logic;
        ac97_synch      : out    vl_logic;
        ac97_bit_clock  : in     vl_logic
    );
end lab5audio;
