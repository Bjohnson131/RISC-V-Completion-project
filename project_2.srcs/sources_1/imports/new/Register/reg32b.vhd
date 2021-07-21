library ieee;
use ieee.std_logic_1164.all;

entity reg32b is
	port (
		reg_in : in std_logic_vector(31 downto 0);
		load, clock, clear : in std_logic;
		reg_out : out std_logic_vector(31 downto 0)
	);
end reg32b;

architecture description of reg32b is
	signal internal_value : std_logic_vector(31 downto 0) := X"00000000";
    attribute keep_hierarchy : string;
    attribute keep_hierarchy of description : architecture is "yes";
begin
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


  process (clock)
  begin
    if rising_edge(clock) then

      if (clear = '1') then
        -- drive all bits to 0 using (others => '0')
        internal_value <= (others => '0');
      else
        if (load = '1') then
          internal_value <= reg_in;
        else
          -- OK to have internal value drive itself here inside clocked process
          internal_value <= internal_value;
        end if;
      end if;
    end if;
  end process;


  reg_out <= internal_value;

end description;
