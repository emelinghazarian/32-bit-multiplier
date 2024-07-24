library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity multiplier1 is
    Port (
        clk : in STD_LOGIC;
        start : in STD_LOGIC;
        A : in STD_LOGIC_VECTOR (31 downto 0);
        B : in STD_LOGIC_VECTOR (31 downto 0);
        Product : out STD_LOGIC_VECTOR (31 downto 0);
        ready : out STD_LOGIC
    );
end multiplier1;

architecture Behavioral of multiplier1 is
    signal Multiplicand : STD_LOGIC_VECTOR (31 downto 0);
    signal Multiplier : STD_LOGIC_VECTOR (15 downto 0);
    signal counter : STD_LOGIC_VECTOR (4 downto 0);
    signal adder_output : STD_LOGIC_VECTOR (31 downto 0);
    signal product_write_enable : STD_LOGIC;
    signal sig_ready:std_logic;
    signal sig_product:STD_LOGIC_VECTOR (31 downto 0);
    
    
begin
    adder_output <= Multiplicand + sig_product;
    product_write_enable <= Multiplier(0);
    sig_ready    <= counter(4);    
    ready        <= sig_ready;
    Product      <= sig_product;
    
    process (clk)
    begin
        if rising_edge(clk) then
            if start = '1' then
                counter <= "00000";
                Multiplicand <= A;
                Multiplier <= B(15 downto 0);
                sig_product <= "00000000000000000000000000000000";
            elsif sig_ready = '0' then
                counter <= counter + 1;
                Multiplier <= '0' & Multiplier(15 downto 1);      --right shift
                Multiplicand <= Multiplicand(30 downto 0) & '0';  --left shift
                if product_write_enable = '1' then                
                    sig_product <= adder_output;
                end if;
            end if;
        end if;
    end process;
end Behavioral;