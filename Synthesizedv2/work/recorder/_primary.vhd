library verilog;
use verilog.vl_types.all;
entity recorder is
    generic(
        LOGSIZE         : integer := 16;
        WIDTH           : integer := 8
    );
    port(
        clock           : in     vl_logic;
        reset           : in     vl_logic;
        playback        : in     vl_logic;
        ready           : in     vl_logic;
        filter          : in     vl_logic;
        from_ac97_data  : in     vl_logic_vector(7 downto 0);
        to_ac97_data    : out    vl_logic_vector(7 downto 0);
        led             : out    vl_logic_vector(7 downto 0)
    );
end recorder;
