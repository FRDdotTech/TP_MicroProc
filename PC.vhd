

LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.numeric_std.all;

entity PC_e is
	port (
		CLK, Rin, En : in std_logic:='0';
		PCin : in std_logic_vector(8 downto 0):= b"000000000";
		Q : out std_logic_vector(8 downto 0):= b"000000000"
	);
end entity;

architecture PC_a of PC_e is

begin
	process (CLK)
		variable prescaler : integer:=2 - 1;
		variable count : integer:=0;
	begin
	if rising_edge(CLK) and En = '1' then
		if Rin = '1' then
			count := to_integer(unsigned(PCin));
		end if;
		if count = 127 then count := 0;
		else count := count + 1;
		end if;
		Q <= std_logic_vector(to_unsigned(count, Q'length));
	end if;
	end process;
end architecture;


LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.numeric_std.all;

entity PC_bench_e is
end entity;

architecture PC_bench_a of PC_bench_e is
	component PC_e is
		port (
		CLK, Rin, En : in std_logic:='0';
		PCin : in std_logic_vector(8 downto 0);
		Q : out std_logic_vector(8 downto 0)
	);
	end component;
	
	signal T_CLK, T_Rin: std_logic:='0';
	signal T_En: std_logic:='1';
	signal T_Q : std_logic_vector(8 downto 0);	
	signal T_In : std_logic_vector(8 downto 0):=b"000110101";
begin
	T_Rin 	<= '1' after 62 ns, '0' after 64 ns;
	T_CLK	<= not(T_CLK) after 1 ns;
	result	: entity work.PC_e(PC_a) port map(T_CLK, T_Rin, T_En, T_In, T_Q);
end architecture;