library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity top is
    port (
        clk : in std_logic;
        reset : in std_logic;
        a, b : in std_logic_vector(7 downto 0);
        btn : in std_logic;

        HEX_hun, HEX_ten, HEX_one : out std_logic_vector(6 downto 0)
    );
end entity top;

architecture arch of top is

    component double_dabble is
        port (
            result_padded           : in  std_logic_vector(11 downto 0); 
            ones                    : out std_logic_vector(3 downto 0);
            tens                    : out std_logic_vector(3 downto 0);
            hundreds                : out std_logic_vector(3 downto 0)
          );
    end component double_dabble;
    component rising_edge_syncrhonizer is
        port (
            clk               : in std_logic;
            reset             : in std_logic;
            input             : in std_logic;
            edge              : out std_logic
          );
    end component rising_edge_syncrhonizer;
    component seven_seg is
        port (
            clk : in std_logic;
            reset : in std_logic;
            bcd : in std_logic_vector(3 downto 0);

            seven_seg_out : out std_logic_vector(6 downto 0) := "1111111" 
        );
    end component seven_seg;

    constant in_a : std_logic_vector(3 downto 0) := "0001";
    constant in_b : std_logic_vector(3 downto 0) := "0010";
    constant add  : std_logic_vector(3 downto 0) := "0100";
    constant sub  : std_logic_vector(3 downto 0) := "1000";

    signal state_reg        : std_logic_vector(3 downto 0);
    signal state_next       : std_logic_vector(3 downto 0);
    signal btn_sig          : std_logic;
    signal s_out            : std_logic_vector(11 downto 0);
    signal add_res, sub_res : std_logic_vector(3 downto 0); -- signal results of both math possibilities
    signal ones, tens, huns : std_logic_vector(3 downto 0); -- signals from double dabble to SSDs

begin
    --math
    add_res <= std_logic_vector(unsigned('0' & a) + unsigned('0' & b));
    sub_res <= std_logic_vector(unsigned('0' & a) - unsigned('0' & b));
    
    state_register : process( clk, reset )  
    begin
        if (reset = '1') then 
            state_reg <= in_a;
        elsif (clk'event and clk = '1') then
            state_reg <= state_next;
        end if;
    end process ; -- state_register

    state_machine : process( state_reg, btn_sig )
    begin
        state_next <= state_reg;
        case (state_reg) is
            when in_a =>                -- input a
                s_out <= "0000" & a;
                if (btn_sig = '1') then
                    state_next <= in_b;
                end if;

            when in_b =>                -- input b
                s_out <= "0000" & b;
                if (btn_sig = '1') then
                    state_next <= add;
                end if;

            when add =>                 -- sum a and b
                s_out <= add_res;
                if (btn_sig = '1') then
                    state_next <= sub;
                end if;

            when sub =>                 -- diff a and b
                s_out <= sub_res;
                if (btn_sig = '1') then
                    state_next <= in_a;
                end if;
        end case;
    end process ; -- state_machine

    btn_res : rising_edge_syncrhonizer
        port map (
            clk => clk,
            reset => reset,
            input => btn,
            edge => btn_sig
        );
    d_d : double_dabble
        port map (
            result_padded => s_out,
            ones => ones,
            tens => tens,
            hundreds => huns
        );
    ones_bcd : seven_seg
        port map (
            clk => clk,
            reset => reset,
            bcd => ones,
            seven_seg_out => HEX_one
        );
    tens_bcd : seven_seg
        port map (
            clk => clk,
            reset => reset,
            bcd => tens,
            seven_seg_out => HEX_ten
        );
    huns_bcd : seven_seg
        port map (
            clk => clk,
            reset => reset,
            bcd => huns,
            seven_seg_out => HEX_hun
        );

end architecture ; -- arch