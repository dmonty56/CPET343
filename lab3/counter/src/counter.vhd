-- top level counter entity
-- by David Montgomery

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity counter is
    port (
            clk, reset : in std_logic;
            seven_seg_out : out std_logic_vector(6 downto 0)
        );    
end entity counter;

architecture arch of counter is

    component generic_adder_beh is
        generic (
            bits    : integer := 4
        );
        port (
            a       : in  std_logic_vector(bits-1 downto 0);
            b       : in  std_logic_vector(bits-1 downto 0);
            cin     : in std_logic;
            sum     : out std_logic_vector(bits-1 downto 0);
            cout    : out std_logic
        );
    end component generic_adder_beh;

    component generic_counter is
        generic (
            max_count       : integer := 3
        );
        port (
            clk             : in  std_logic; 
            reset           : in  std_logic;
            output          : out std_logic
        );  
    end component generic_counter;

    component seven_seg is
        port (
            clk : in std_logic;
            reset : in std_logic;
            bcd : in std_logic_vector(3 downto 0);

            seven_seg_out : out std_logic_vector(6 downto 0) := "1111111" 
        );   
    end component seven_seg;

    signal sum : std_logic_vector(3 downto 0) := "0000";
    signal enable : std_logic;
    signal sum_sig : std_logic_vector(3 downto 0);
begin

    uut1 : generic_adder_beh
        generic map (
            bits => 4
        )
        port map (
            a => sum_sig,
            b => "0001",
            cin => '0',
            sum => sum
        );
    uut2 : generic_counter
        generic map (
            max_count => 50000000
        )
        port map (
            clk => clk,
            reset => reset,
            output => enable
        );
    uut3 : seven_seg
        port map (
            clk => clk,
            reset => reset,
            bcd => sum_sig,
            seven_seg_out => seven_seg_out
        );

    sum_register : process(clk,reset,enable)
        begin
            if (reset = '1') then
                sum_sig <= "0000";
            elsif (clk'event and clk = '1') then
                if (sum = "1010") then
                    sum_sig <= "0000";
                elsif (enable = '1') then
                    sum_sig <= sum;
                end if;
            end if;
    end process sum_register;


end architecture ; -- arch