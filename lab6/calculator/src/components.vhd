library ieee;
use ieee.std_logic_1164.all;

package components is
	component double_dabble is
        port (
            result_padded           : in  std_logic_vector(11 downto 0); 
            ones                    : out std_logic_vector(3 downto 0);
            tens                    : out std_logic_vector(3 downto 0);
            hundreds                : out std_logic_vector(3 downto 0)
          );
    end component double_dabble;

    component rising_edge_synchronizer is
        port (
            clk               : in std_logic;
            reset             : in std_logic;
            input             : in std_logic;
            edge              : out std_logic
          );
    end component rising_edge_synchronizer;

    component seven_seg is
        port (
            clk : in std_logic;
            reset : in std_logic;
            bcd : in std_logic_vector(3 downto 0);

            seven_seg_out : out std_logic_vector(6 downto 0) := "1111111" 
        );
    end component seven_seg;
end components;