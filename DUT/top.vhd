LIBRARY ieee;
library lab2;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
USE lab2.aux_package.all;
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
	signal cnt_fast :std_logic_vector(n-1 downto 0);

begin
	----------------------- fast counter process ------------------
	proc1 : process(clk,rst)
	variable res:std_logic_vector(n-1 downto 0);
	variable input:std_logic_vector(n-1 downto 0);
	variable carry:std_logic_vector(n-1 downto 0);
	variable zeroes:std_logic_vector(n-1 downto 0);
	begin
	zeroes:=(others=>'0');
	if(rst='1') then
		countOut <= zeroes;
		cnt_fast<=(others=>'0');
	elsif( clk'EVENT and clk='1') then
		if(rst='0') then
			if(cnt_slow = zeroes or res=cnt_slow) then
				res:=(others => '0');
			else
				input:=cnt_fast;
				carry(0):='0';
				res(0):=input(0) xor '1';
				carry(1):= input(0);
			for_proc1:for i in 1 to n-2 loop
				res(i):=input(i) xor carry(i);
				carry(i+1):= input(i) and carry(i);
			end loop;
				res(n-1):=input(n-1) xor carry(n-1);
			end if;
			cnt_fast<=res;
			countOut<=res;
		--else 
		--	countOut <= zeroes;
			--cnt_fast<=zeroes;
		end if;
	end if;
	end process;
	---------------------- slow counter process ------------------
	proc2 : process(clk,rst)
	variable res:std_logic_vector(n-1 downto 0);
	variable input:std_logic_vector(n-1 downto 0);
	variable carry:std_logic_vector(n-1 downto 0);
	begin
	if(rst='1') then
		cnt_slow<=(others=>'0');
	elsif(clk'EVENT  and clk='1') then
		if(rst='0') then
			if( cnt_slow=cnt_fast and cnt_slow<upperBound) then 
				input:=cnt_slow;
				carry(0):='0';
				res(0):=input(0) xor '1';
				carry(1):= input(0);
				for_proc2:for i in 1 to n-2 loop
					res(i):=input(i) xor carry(i);
					carry(i+1):= input(i) and carry(i);
				end loop;
				res(n-1):=input(n-1) xor carry(n-1);
				cnt_slow<=res;
			elsif(cnt_slow>cnt_fast and cnt_slow<=upperBound) then
				null;
			else
				cnt_slow<=(others=>'0');
			end if;
		end if;
	end if;
	end process;
	--------------------------------------------------------------
end arc_sys;







