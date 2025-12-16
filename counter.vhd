
LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.numeric_std.all;

entity counter_e is
	port (
		CLK, RST : in std_logic:='0';
		Q : out std_logic_vector(4 downto 0):= b"00000"
	);
end entity;

architecture counter_a of counter_e is

begin
	
	process (CLK)
		variable prescaler : integer:=2 - 1;
		variable clk_count, count : integer:=0;
	begin
	if RST = '1' then
		count := 0;
	end if;
	if rising_edge(CLK) and RST = '0' then
		if clk_count = prescaler then
			if count = 31 then count := 0;
			else count := count + 1;
			end if;
			clk_count := 0;
			Q <= std_logic_vector(to_unsigned(count, Q'length));
		else 
			clk_count := clk_count + 1;
		end if;
	end if;
	end process;
end architecture;


LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.numeric_std.all;

entity counter_bench_e is
end entity;

architecture counter_bench_a of counter_bench_e is
	component counter_e is
		port (
		CLK, RST : in std_logic:='0';
		Q : out std_logic_vector(4 downto 0)
	);
	end component;
	
	signal T_CLK, T_RST: std_logic:='0';
	signal T_Q : std_logic_vector(4 downto 0);
begin
	T_CLK	<= not(T_CLK) after 5 ns;
	result	: entity work.counter_e(counter_a) port map(T_CLK, T_RST, T_Q);
end architecture;