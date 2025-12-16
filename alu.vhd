LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.numeric_std.all;

entity alu_e is
	port (
		AddSub : in std_logic:='0';
		A, B : in std_logic_vector(8 downto 0);
		S : out std_logic_vector(8 downto 0)
	);
end entity;

architecture alu_a of alu_e is
begin
	process (A, B)
		begin
		if AddSub = '1' then
			S <= std_logic_vector(signed(A) - signed(B));
		else
			S <= std_logic_vector(signed(A) + signed(B));
		end if;
	end process;
end architecture;

LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.numeric_std.all;

entity alu_bench_e is
end entity;

architecture alu_bench_a of alu_bench_e is
	component alu_e is
		port (
		AddSub : in std_logic:='0';
		A, B : in std_logic_vector(8 downto 0);
		S : out std_logic_vector(8 downto 0)
	);
	end component;
	
	signal T_SEL : std_logic:='0';
	signal T_A, T_B : std_logic_vector(8 downto 0);
	signal T_S : std_logic_vector(8 downto 0);
begin
	T_A <= "011111111" after 10 ns;
	T_B <= "000000001" after 20 ns;
	T_SEL <= '1' after 50 ns, '0' after 80 ns;
	restult : entity work.alu_e(alu_a) port map (T_SEL, T_A, T_B,  T_S);
end architecture;
