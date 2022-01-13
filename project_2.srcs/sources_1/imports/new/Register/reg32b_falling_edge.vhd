library ieee;
use ieee.std_logic_1164.all;

entity reg32b_falling_edge is
  port (
    reg_in             : in  std_logic_vector(31 downto 0);
    load, clock, clear : in  std_logic;
    reg_out            : out std_logic_vector(31 downto 0)
    );
end reg32b_falling_edge;

architecture description of reg32b_falling_edge is
  signal internal_value : std_logic_vector(31 downto 0) := X"00000000";
begin


  -- SR ---
  -- Reg out driven outside of process
  -- SR ---
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

    -- SR ---
    -- Generally most registers in the FPGA aren't equipped to register
    -- on the falling edge
    -- it depends if the device has falling edge capable registers
    -- some do for eg DDR ram.
    -- SR ---
    if rising_edge(clock) then

      if (clear = '1') then
        internal_value <= X"00000000";
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
