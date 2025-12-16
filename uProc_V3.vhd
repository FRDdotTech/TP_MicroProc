

-- TEST BENCH

LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.numeric_std.all;


entity bench_V3_e is 
end entity;

architecture bench_V3_a of bench_V3_e is 
--
--
--	FSM
--
--
	component FSMV2_e is
		port (
		DIN : in std_logic_vector(8 downto 0);
		CLK, RST, RUN : in std_logic;
		SEL : out std_logic_vector(9 downto 0);
		IRin, AddSub, Gin, Ain, Done : out std_logic;
		R0, R1, R2, R3, R4, R5, R6, R7 : out std_logic;
		PC_En, ADDRin, DOUTin, W_D: out std_logic
	);
	end component;
--
--
--	MUX
--
--
	component mux_e is
		port (
		R0, R1, R2, R3, R4, R5, R6, R7, Din, G : in std_logic_vector(8 downto 0);
		SEL : in std_logic_vector(9 downto 0);
		S : out std_logic_vector(8 downto 0)
	);
	end component;
--
--
--	REG
--
--
	component register_e is
		port (
		CLK, Rin : in std_logic:='0';
		R : in std_logic_vector(8 downto 0);
		Q : out std_logic_vector(8 downto 0)
	);
	end component;


--
--
--	ALU
--
--
	component alu_e is
		port (
		AddSub : in std_logic:='0';
		A, B : in std_logic_vector(8 downto 0);
		S : out std_logic_vector(8 downto 0)
	);
	end component;
	
--
--
--	PC
--
--
	component PC_e is
		port (
		CLK, Rin, En : in std_logic:='0';
		PCin : in std_logic_vector(8 downto 0);
		Q : out std_logic_vector(8 downto 0)
	);
	end component;

--
--
--	SRAM
--
--
	component sram_e is
		port (
		CLK, WR : in std_logic:='0';
		addr : in std_logic_vector(6 downto 0);
		data : in std_logic_vector(8 downto 0);
		Q : out std_logic_vector(8 downto 0)
	);
	end component;

	signal DIN, IR_Q, ComonBus, ALU_A, ALU_S : std_logic_vector(8 downto 0) := B"000000000";
	signal R0_Q, R1_Q, R2_Q, R3_Q, R4_Q, R5_Q, R6_Q, R7_Q, G_Q: std_logic_vector(8 downto 0) := B"000000000";
	signal T_CLK, T_RST, T_RUN : std_logic:='0';
	signal MUX_SEL : std_logic_vector(9 downto 0);
	signal IRin, AddSub, Gin, Ain, Done : std_logic;
	signal R0_in, R1_in, R2_in, R3_in, R4_in, R5_in, R6_in, R7_in : std_logic;
	signal PC_En, ADDRin, DOUTin, W_D: std_logic;
	signal PC_addr : std_logic_vector(8 downto 0);
	signal ADDR, DOUT : std_logic_vector(8 downto 0);



begin
	T_RST <= '1' after 1 ns, '0' after 13 ns;
	T_CLK <= not(T_CLK) after 5 ns;

--
--
--	ENTITY INSTANCES
--
--
	IRreg 	: entity work.register_e(register_a) port map(T_CLK, IRin, DIN, IR_Q);
	FSM 	: entity work.FSMV2_e(FSMV2_a) port map(IR_Q, T_CLK, T_RST, T_RUN, MUX_SEL, IRin, AddSub, Gin, Ain, Done, R0_in, R1_in, R2_in, R3_in, R4_in, R5_in, R6_in, R7_in, PC_En, ADDRin, DOUTin, W_D);
	ALU	: entity work.alu_e(alu_a) port map (AddSub, ALU_A, ComonBus,  ALU_S);
	MUX	: entity work.mux_e(mux_a) port map (R0_Q, R1_Q, R2_Q, R3_Q, R4_Q, R5_Q, R6_Q, PC_addr, DIN, G_Q, MUX_SEL, ComonBus);
	AReg	: entity work.register_e(register_a) port map(T_CLK, Ain, ComonBus, ALU_A);
	GReg	: entity work.register_e(register_a) port map(T_CLK, Gin, ALU_S, G_Q);
	R0_Reg	: entity work.register_e(register_a) port map(T_CLK, R0_in, ComonBus, R0_Q);
	R1_Reg	: entity work.register_e(register_a) port map(T_CLK, R1_in, ComonBus, R1_Q);
	R2_Reg	: entity work.register_e(register_a) port map(T_CLK, R2_in, ComonBus, R2_Q);
	R3_Reg	: entity work.register_e(register_a) port map(T_CLK, R3_in, ComonBus, R3_Q);
	R4_Reg	: entity work.register_e(register_a) port map(T_CLK, R4_in, ComonBus, R4_Q);
	R5_Reg	: entity work.register_e(register_a) port map(T_CLK, R5_in, ComonBus, R5_Q);
	R6_Reg	: entity work.register_e(register_a) port map(T_CLK, R6_in, ComonBus, R6_Q);
-- V3 specific	
	PC	: entity work.PC_e(PC_a) port map(T_CLK, R7_in, PC_En, ComonBus, PC_addr);
	ADDR_Reg: entity work.register_e(register_a) port map(T_CLK, ADDRin, ComonBus, ADDR);
	DOUT_Reg: entity work.register_e(register_a) port map(T_CLK, DOUTin, ComonBus, DOUT);
	SRAM	: entity work.sram_e(sram_a) port map(T_CLK, W_D, ADDR(6 downto 0), DOUT, DIN);
end architecture;