library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity seven_seg is
    port (
        clk : in std_logic;
        reset : in std_logic;
        bcd : in std_logic_vector(3 downto 0);

        seven_seg_out : out std_logic_vector(6 downto 0) := "1111111" 
    );   
end entity seven_seg;

architecture arch of seven_seg is

component num_to_ssd is
    port (
        num_in : in STD_LOGIC_VECTOR(3 downto 0);
        Seg_Display : out STD_LOGIC_VECTOR(6 downto 0)
    );
end component num_to_ssd;
    signal num : std_logic_vector(3 downto 0);
begin
    
    process(clk, reset)
    begin
        if (rising_edge(clk)) then
            if (reset = '0') then
                num <= bcd;
            end if;
        end if;
    end process;

    uut: num_to_ssd
        port map (
            num_in => num,
            Seg_Display => seven_seg_out
        );

end architecture ; -- arch