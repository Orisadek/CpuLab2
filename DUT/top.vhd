LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
USE work.aux_package.all;
------------------------------------------------------------------
entity top is
	generic ( n : positive := 8 ); 
	port( rst,clk : in std_logic;
		  upperBound : in std_logic_vector(n-1 downto 0);
		  countOut : out std_logic_vector(n-1 downto 0));
end top;
------------------------------------------------------------------
architecture arc_sys of top is
	signal cnt_slow :std_logic_vector(n-1 downto 0);
	
begin
	----------------------- fast counter process ------------------
	proc1 : process(clk,rst)
	begin
	variable res:std_logic_vector(n-1 downto 0);
	variable input:std_logic_vector(n-1 downto 0);
	variable carry:std_logic_vector(n-1 downto 0);
	
	if(rst='0' and clk'EVENT and clk='1') then
		if((countOut='X' or countOut='Z') or (res=cnt_slow)) then
			res:=0;
		else
		input:=countOut;
		carry(0):='0';
		res(0):=input(0) xor '1';
		carry(1):= input(0);
		for_proc1:for i in 1 to n-1 loop
			res(i):=input(i) xor carry(i);
			carry(i+1):= input(i) and carry(i);
		end loop;
		end if;
	countOut<=res;
	elsif (clk'EVENT and clk='1') then
	countOut<= others=>'0';
	end if;
	end process;
	---------------------- slow counter process ------------------
	proc2 : process(clk,rst)
	begin
	--variable en std_logic;
	variable res:std_logic_vector(n-1 downto 0);
	variable input:std_logic_vector(n-1 downto 0);
	variable carry:std_logic_vector(n-1 downto 0);
	
	if(rst='0' and clk'EVENT and clk='1') then
		if(not(countOut='X' or countOut='Z') and cnt_slow=countOut and cnt_slow<upperBound) then 
			input:=cnt_slow;
			carry(0):='0';
			res(0):=input(0) xor '1';
			carry(1):= input(0);
			for_proc2:for i in 1 to n-1 loop
				res(i):=input(i) xor carry(i);
				carry(i+1):= input(i) and carry(i);
			end loop;
			cnt_slow<=res;
		elsif(not(countOut='X' or countOut='Z') and cnt_slow=countOut and cnt_slow=upperBound) then
			cnt_slow<=others=>'0';
		else
			cnt_slow<=others=>'0';
		end if;
	elsif clk'EVENT and clk='1') then
		cnt_slow<=others=>'0';
	end if;
	
	end process;
	--------------------------------------------------------------
	
	
	
	
	
end arc_sys;







