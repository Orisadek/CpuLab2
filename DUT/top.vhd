LIBRARY ieee;
library work;
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
	signal cnt_fast :std_logic_vector(n-1 downto 0);
	signal en :std_logic;
begin
	----------------------- fast counter process ------------------
	proc1 : process(clk,rst)
	variable res:std_logic_vector(n-1 downto 0);
	variable input:std_logic_vector(n-1 downto 0);
	variable carry:std_logic_vector(n-1 downto 0);
	variable zeroes:std_logic_vector(n-1 downto 0);
	begin
	zeroes:=(others=>'0');
	if(rst='1') then -- asynchronic state
		countOut <= zeroes; -- in the case of asynchronic state output is zeros as requested
		cnt_fast<=(others=>'0'); --reseting the fast counter 
		en<='0';
	elsif( clk'EVENT and clk='1') then --upon rising edge
		if(rst='0') then --synchronic state
			if(cnt_slow = zeroes or res=cnt_slow) then --handling the case where slow counter is zeros vector
				if(res = cnt_slow) then --
				en<='1'; --this is the signal that enables the counting of the slow counter
				end if;
				res:=(others => '0');
			else        -- slow counter isn't the zeros vector
				input:=cnt_fast; --save the value of slow counter in a variable 
				carry(0):='0'; --in order to count we implemented FA
				res(0):=input(0) xor '1';
				carry(1):= input(0);
			for_proc1:for i in 1 to n-2 loop
				res(i):=input(i) xor carry(i);
				carry(i+1):= input(i) and carry(i);
			end loop;
				res(n-1):=input(n-1) xor carry(n-1);
				en<='0';
				end if;
			cnt_fast<=res;
			countOut<=res;
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
		cnt_slow<=(others=>'0'); --reset the slow counter
	elsif(clk'EVENT  and clk='1') then -- upon rising edge
		if(rst='0') then
			if( cnt_slow = cnt_fast and cnt_slow<upperBound) then --both counters engage but counting didn't reach its upper limit
				input:=cnt_slow; --store the slow counter in a variable
				carry(0):='0'; --in order to add to the counter we implemented FA
				res(0):=input(0) xor '1';
				carry(1):= input(0);
				for_proc2:for i in 1 to n-2 loop
					res(i):=input(i) xor carry(i);
					carry(i+1):= input(i) and carry(i);
				end loop;
				res(n-1):=input(n-1) xor carry(n-1);
				cnt_slow<=res;
			elsif(cnt_slow>cnt_fast) then -- as long as counters don't meet
				null;
			else
				cnt_slow<=(others=>'0'); -- for all other casses 
			end if;
		end if;
	end if;
	end process;
	--------------------------------------------------------------
end arc_sys;







