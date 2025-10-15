--------------------------------------------------------------------------------
-- add_sub top level entity
-- by David Montgomery
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity top is
    port (
        add_sub_sw, clk, reset : in std_logic;
        a, b : in std_logic_vector(2 downto 0);

        result_out, a_out, b_out : out std_logic_vector(6 downto 0)
    );
end entity top;

architecture arch of top is

    component add_sub is
        port (
            reset, clk : in std_logic;
            add_sub_sw : in std_logic; --add = 1, sub = 0
            a, b : in std_logic_vector(2 downto 0);

            result : out std_logic_vector(3 downto 0)
        );
    end component add_sub;

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

    signal a_s_syn : std_logic; -- add/sub enable switch synchronized
    signal a_syn, b_syn : std_logic_vector(2 downto 0); --synchronized a and b vectors
    signal result : std_logic_vector(3 downto 0); --result vector
    signal a_4bit, b_4bit : std_logic_vector(3 downto 0); --a and b after being converted to 4 bit vectors

begin

    a_s : add_sub
        port map (
            reset => reset,
            clk => clk,
            add_sub_sw => a_s_syn,
            a => a_syn,
            b => b_syn,
            result => result
        );

    --a_s_res : rising_edge_synchronizer
    --    port map (
    --        clk => clk,
    --        reset => reset,
    --        input => add_sub_sw,
    --        edge => a_s_en
    --    );

    result_bcd : seven_seg
        port map (
            clk => clk,
            reset => reset,
            bcd => result,
            seven_seg_out => result_out
        );

    a_bcd : seven_seg
        port map (
            clk => clk,
            reset => reset,
            bcd => a_4bit,
            seven_seg_out => a_out
        );

    b_bcd : seven_seg
        port map (
            clk => clk,
            reset => reset,
            bcd => b_4bit,
            seven_seg_out => b_out
        );

    synchronizer : process( a, b, clk )
    begin
        if (rising_edge(clk)) then
            a_syn <= a;
            b_syn <= b;
            a_s_syn <= add_sub_sw;
        end if;
    end process ; -- a_sync

    a_4bit <= '0' & a_syn;
    b_4bit <= '0' & b_syn;

end architecture ; -- arch