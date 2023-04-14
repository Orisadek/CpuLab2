library IEEE;
library lab2;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
USE lab2.aux_package.all;
---------------------------------------------------------
entity tb is
	constant n : integer := 8;
end tb;
---------------------------------------------------------
architecture rtb of tb is
	signal rst,clk : std_logic;
	signal upperBound : std_logic_vector(n-1 downto 0);
	signal countOut : std_logic_vector(n-1 downto 0);
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
				
		gen_upperBound : process
        begin
		  upperBound <= (1=>'1',0=>'0',others => '0');
		  for i in 0 to 6 loop
			wait for 1200 ns;
				upperBound <= upperBound+2;
		  end loop;
        end process;
		  
		gen_rst : process
        begin
		  rst <='1','0' after 100 ns;
		  wait;
        end process; 
		
end architecture rtb;
