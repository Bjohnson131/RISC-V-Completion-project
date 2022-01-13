library ieee;
use ieee.std_logic_1164.all;

entity reg32b is
    generic (N : std_logic_vector(31 downto 0) := X"00000000");
	port (
		reg_in : in std_logic_vector(31 downto 0);
		load, clock, clear : in std_logic;
		reg_out : out std_logic_vector(31 downto 0)
	);
end reg32b;

architecture description of reg32b is
	signal internal_value : std_logic_vector(31 downto 0) := N;
begin

  reg_out <= internal_value;
  
  process (clock)
  begin
    if rising_edge(clock) then
      if (clear = '1') then
        -- drive all bits to N when reset.
        internal_value <= N;
      else
        if (load = '1') then
          internal_value <= reg_in;
        else
          internal_value <= internal_value;
        end if;
      end if;
    end if;
  end process;
end description;
  -- Zeroes when clear is 1,
  -- Reg in when load signal is high
  -- otherwise, maintain value.

  -- SR --
  -- This infers a latch, which is generally bad practice
  -- internal_value driven by itself (as in the else case) outside of a clocked
  -- process is not recommended.
  -- Instead, move this into the clocked process (where this is fine)
  -- and move the  reg_out <= internal_value; out of it
  -- the same as the other reg modules
  -- SR --
  --internal_value <=    X"00000000" when ( clear = '1') else
  --                     reg_in      when ( load = '1' ) else
  --                     internal_value;

  --process (clock)
  --begin
  --  if rising_edge(clock) then
  --    reg_out <= internal_value;
  --  end if;
  --end process;
