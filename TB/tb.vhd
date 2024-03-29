library IEEE;
library lab2;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
USE lab2.aux_package.all;
---------------------------------------------------------
entity tb is
	constant n : integer := 8;
	constant max_range: integer :=7;
end tb;
---------------------------------------------------------
architecture rtb of tb is
	type matrix is array (0 to max_range) of std_logic_vector(n-1 downto 0);
	signal rst,clk : std_logic;
	signal upperBound : std_logic_vector(n-1 downto 0);
	signal countOut : std_logic_vector(n-1 downto 0);
	SIGNAL upperBound_options : matrix := ("00000101","00000001","00000111","00001000","00000010","00001011","00001000",
	"00000011");
begin
	L0 : top generic map (n) port map(rst,clk,upperBound,countOut);
    
	--------- start of stimulus section ------------------	
        gen_clk : process
        begin
		  clk <= '0';
		  wait for 50 ns;
		  clk <= not clk;
		  wait for 50 ns;
        end process;
		
		---upperBound <= (2 =>'1',1 =>'0',0 =>'1', others =>'0');
		upperBound_rst : process
		begin
		for j in 0 to max_range loop
			upperBound <= upperBound_options(j);
			wait for 1000 ns;
		  end loop; 
        end process; 
		
		gen_rst : process
		begin
		  rst <= '1';
		  wait for 50 ns;
		  rst <= not rst;
		  wait for 4000 ns;
        end process; 
		
end architecture rtb;
