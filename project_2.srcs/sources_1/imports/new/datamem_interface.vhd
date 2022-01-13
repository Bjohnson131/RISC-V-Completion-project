library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.all;
library riscv;
use riscv.all;			   


entity datamem_interface is
	port (
		input_data : in std_logic_vector(31 downto 0);
		byte_address : in std_logic_vector(31 downto 0);
		data_format : in std_logic_vector(2 downto 0);
		clock, load : in std_logic;
		output_data : out std_logic_vector(31 downto 0)
	);
end entity datamem_interface;

architecture behavioural of datamem_interface is
    attribute DONT_TOUCH : string;
    attribute DONT_TOUCH of behavioural : architecture is "true";

	signal internal_load : std_logic_vector(3 downto 0);
	
    signal unsgned_address : unsigned(31 downto 0);
	signal membank_address : std_logic_vector(31 downto 0);
	signal byte_starting_position : std_logic_vector(1 downto 0) := "00";
	
  COMPONENT blk_mem_gen_0 IS
  PORT (
    clka : IN STD_LOGIC;
    ena : IN STD_LOGIC;
    wea : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    addra : IN STD_LOGIC_VECTOR(16 DOWNTO 0);
    dina : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    douta : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
  );
  END COMPONENT;

begin
	
    --blockRam_mem: blk_mem_gen_0 
    --port map(
    --clka=>clock, 
    ----rsta=>'0', 
    --ena=>'1',
    --wea(0)=>internal_load(0),
    --wea(1)=>internal_load(1),
    --wea(2)=>internal_load(2),
    --wea(3)=>internal_load(3), 
    --addra=>membank_address(16 downto 0), 
    --dina=>input_data, 
    --douta=>output_data);
    
    membank_address <= "00"&byte_address(31 downto 2);
    byte_starting_position <= byte_address(1 downto 0);
    
    internal_load <=
    "1111" when (data_format = "000" and byte_starting_position = "00") else
    "0011" when ((data_format = "001" or data_format = "010") and byte_starting_position = "00") else
    "1100" when ((data_format = "001" or data_format = "010") and byte_starting_position = "10") else
    "0001" when ((data_format = "011" or data_format = "100") and byte_starting_position = "00") else
    "0010" when ((data_format = "011" or data_format = "100") and byte_starting_position = "01") else
    "0100" when ((data_format = "011" or data_format = "100") and byte_starting_position = "10") else
    "1000" when ((data_format = "011" or data_format = "100") and byte_starting_position = "11") else
    "0000";
    
    unsgned_address <= unsigned(byte_address);
    
end architecture behavioural;