library ieee;
use ieee.std_logic_1164.all;

entity reg5b is
  port (
    reg_in             : in  std_logic_vector(4 downto 0);
    load, clock, clear : in  std_logic;
    reg_out            : out std_logic_vector(4 downto 0)
    );
end reg5b;

architecture description of reg5b is
  signal internal_value                   : std_logic_vector(4 downto 0) := "00000";
  attribute keep_hierarchy                : string;
  attribute keep_hierarchy of description : architecture is "yes";
begin
  reg_out <= internal_value;

  -- SR ---
  -- not good practice to have additional signals in process sensitivity list
  -- in addition to clock.
  -- Either the process has clock and hence it is a synchronus process
  -- Or it has no clock and only other signals and is an asynchronus process.
  -- Not good practise to mix and match
  -- SR ---

  --process (clock, clear, load, internal_value)
  process (clock)
  begin

    -- SR ---
    -- move clear into inside of clock if statement
    -- SR ---

    if rising_edge(clock) then
      if (clear = '1') then
        internal_value <= "00000";
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
