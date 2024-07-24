library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity tb_multiplier1 is
end tb_multiplier1;

architecture Behavioral of tb_multiplier1 is
    signal clk : STD_LOGIC := '0';
    signal start : STD_LOGIC := '0';
    signal A : STD_LOGIC_VECTOR (31 downto 0) := (others => '0');
    signal B : STD_LOGIC_VECTOR (31 downto 0) := (others => '0');
    signal Product : STD_LOGIC_VECTOR (31 downto 0);
    signal ready : STD_LOGIC;

    component multiplier1 is
        Port (
            clk : in STD_LOGIC;
            start : in STD_LOGIC;
            A : in STD_LOGIC_VECTOR (31 downto 0);
            B : in STD_LOGIC_VECTOR (31 downto 0);
            Product : out STD_LOGIC_VECTOR (31 downto 0);
            ready : out STD_LOGIC
        );
    end component;

begin
    uut: multiplier1 port map (
        clk => clk,
        start => start,
        A => A,
        B => B,
        Product => Product,
        ready => ready
    );

    clk_process :process
    begin
        clk <= '0';
        wait for 10 ns;
        clk <= '1';
        wait for 10 ns;
    end process;

    stim_proc: process
    begin
        wait for 20 ns;
        start <= '1'; A <= "00000000000000000000000000001111"; B <= "00000000000000000000000000001111"; -- Test input values
        wait for 20 ns;
        start <= '0';
        wait;
    end process;

end Behavioral;