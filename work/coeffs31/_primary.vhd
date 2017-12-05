library verilog;
use verilog.vl_types.all;
entity coeffs31 is
    port(
        index           : in     vl_logic_vector(4 downto 0);
        coeff           : out    vl_logic_vector(9 downto 0)
    );
end coeffs31;
