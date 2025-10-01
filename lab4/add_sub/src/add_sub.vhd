--------------------------------------------------------------------------------
-- add_sub functional entity
-- by David Montgomery
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity add_sub is
    port (
        reset, clk : in std_logic;
        add_sub_sw : in std_logic; --add = 1, sub = 0
        a, b : in std_logic_vector(2 downto 0);

        result : out std_logic_vector(3 downto 0)
    );
end entity add_sub;

architecture top of add_sub is
    
    signal add_res, sub_res : std_logic_vector(3 downto 0); --signal results of both math possibilities
begin

    result : process( add_sub_sw, clk )
    begin
        if (rising_edge(clk)) then
            if add_sub_sw = '1' then --add
                result <= add_res;
            elsif add_sub_sw = '0' then --subtract
                result <= sub_res;
            end if;
        end if;
    end process ; -- result

    --math
    add_res <= std_logic_vector(unsigned('0' & a) + unsigned('0' & b));
    sub_res <= std_logic_vector(unsigned('0' & a) - unsigned('0' & b));

end architecture top;