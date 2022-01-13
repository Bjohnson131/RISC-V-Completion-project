library ieee;
use ieee.std_logic_1164.all;

entity reg1b is
  port (
    reg_in             : in  std_logic;
    load, clock, clear : in  std_logic;
    reg_out            : out std_logic
    );
end reg1b;

architecture description of reg1b is
  signal internal_value : std_logic := '0';

  -- SR: Why DONT_TOUCH?

  attribute extract_reset : string;
  attribute extract_enable : string;
  attribute extract_reset of reg_out: signal is "no";
  attribute extract_enable of reg_out: signal is "no";
  attribute gated_clock               : string;
  attribute gated_clock of clock      : signal is "true";
  attribute dont_touch                : string;
  attribute dont_touch of description : architecture is "true";
begin


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
        internal_value <= '0';
      else
        if (load = '1') then
          internal_value <= reg_in;
        else
          internal_value <= internal_value;
        end if;
      end if;
    end if;
  end process;

  -- SR ---
  -- Reg out driven outside of process
  -- SR ---
  reg_out <= internal_value;

end description;
