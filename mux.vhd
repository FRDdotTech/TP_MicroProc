
LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.numeric_std.all;

entity mux_e is
	port (
		R0, R1, R2, R3, R4, R5, R6, R7, Din, G : in std_logic_vector(8 downto 0);
		SEL : in std_logic_vector(9 downto 0);
		S : out std_logic_vector(8 downto 0)
	);
end entity;

architecture mux_a of mux_e is

begin
	with SEL select
	S <= 	R0 	when "1000000000",
		R1 	when "0100000000",
		R2 	when "0010000000",
		R3 	when "0001000000",
		R4 	when "0000100000",
		R5 	when "0000010000",
		R6 	when "0000001000",
		R7 	when "0000000100",
		Din 	when "0000000010",
		G 	when "0000000001",
		R0 when others;

	
end architecture;


LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.numeric_std.all;

entity mux_bench_e is
end entity;

architecture mux_bench_a of mux_bench_e is
	component mux_e is
		port (
		R0, R1, R2, R3, R4, R5, R6, R7, Din, G : in std_logic_vector(8 downto 0);
		SEL : in std_logic_vector(9 downto 0);
		S : out std_logic_vector(8 downto 0)
	);
	end component;
	
	signal T_R0, T_R1, T_R2, T_R3, T_R4, T_R5, T_R6, T_R7, T_Din, T_G : std_logic_vector(8 downto 0);
	signal T_SEL : std_logic_vector(9 downto 0);
	signal T_S : std_logic_vector(8 downto 0);
begin
	T_SEL 	<= 	"1000000000" after 10 ns,
			"0100000000" after 20 ns,
			"0010000000" after 30 ns,
			"0001000000" after 40 ns,
			"0000100000" after 50 ns,
			"0000010000" after 60 ns,
			"0000001000" after 70 ns,
			"0000000100" after 80 ns,
			"0000000010" after 90 ns,
			"0000000001" after 100 ns;
	T_R0  	<= "000000001" after 20 ns;
	T_R1  	<= "000000011" after 20 ns;
	T_R2  	<= "000000111" after 20 ns;
	T_R3  	<= "000001111" after 20 ns;
	T_R4  	<= "000011111" after 20 ns;
	T_R5  	<= "000111111" after 20 ns;
	T_R6  	<= "001111111" after 20 ns;
	T_R7  	<= "011111111" after 20 ns;
	T_Din 	<= "111111111" after 20 ns;
	T_G  	<= "101010101" after 20 ns;
	restult : entity work.mux_e(mux_a) port map (T_R0, T_R1, T_R2, T_R3, T_R4, T_R5, T_R6, T_R7, T_Din, T_G, T_SEL, T_S);
end architecture;