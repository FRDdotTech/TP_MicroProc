
LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.numeric_std.all;

entity rom_e is
	port (
		CLK : in std_logic:='0';
		addr : in std_logic_vector(4 downto 0);
		data : out std_logic_vector(8 downto 0):= b"000000000"
	);
end entity;

architecture rom_a of rom_e is
	type mem_t is array (0 to 31) of std_logic_vector(8 downto 0);
	constant mem : mem_t := (
		b"001001000",	-- movi
		b"001010000",	-- movi
		b"001011000",	-- movi
		b"001100000",	-- movi
		b"001101000",	-- movi
		b"001110000",	-- movi
		b"001111000",	-- movi
		b"000111001",	-- mov
		b"010110010",	-- add
		b"010110010",	
		b"011101011",	-- sub
		b"011101011",
		b"000000000",
		b"000000000",
		b"000000000",
		b"000000000",
		b"000000000",
		b"000000000",
		b"000000000",
		b"000000000",
		b"000000000",
		b"000000000",
		b"000000000",
		b"000000000",
		b"000000000",
		b"000000000",
		b"000000000",
		b"000000000",
		b"000000000",
		b"000000000",
		b"000000000",
		b"000000000");

	
	
begin
	
	process (CLK)
		variable prev_addr :  std_logic_vector(4 downto 0):= b"00000";
	begin
	if rising_edge (CLK) then
		if prev_addr = addr then
			data <= mem(to_integer(unsigned(addr)));
		else
			prev_addr := addr;
			data <= mem(to_integer(unsigned(addr))-1);
		end if;
	
	end if;
	end process;
end architecture;


LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.numeric_std.all;

entity rom_bench_e is
end entity;

architecture rom_bench_a of rom_bench_e is
	component rom_e is
		port (
		CLK : in std_logic:='0';
		addr : in std_logic_vector(4 downto 0);
		data : out std_logic_vector(8 downto 0)
	);
	end component;

	component counter_e is
		port (
		CLK, RST : in std_logic:='0';
		Q : out std_logic_vector(4 downto 0)
	);
	end component;
	
	signal T_CLK, T_RST : std_logic:='0';
	signal T_addr : std_logic_vector(4 downto 0);
	signal T_data : std_logic_vector(8 downto 0);
begin
	T_CLK	<= not(T_CLK) after 5 ns;
	cnt	: entity work.counter_e(counter_a) port map(T_CLK, T_RST, T_addr);
	rom	: entity work.rom_e(rom_a) port map(T_CLK, T_addr, T_data);
end architecture;