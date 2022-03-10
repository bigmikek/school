----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/29/2022 09:25:21 AM
-- Design Name: 
-- Module Name: lab1_top - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;                                        --Library instantiation

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity lab1_top is port (                                           --Declaring entity lab1_top with its various input/output ports
    --Push Buttons
    BTNC : in STD_LOGIC;
    BTND : in STD_LOGIC;
    BTNU : in STD_LOGIC;
    --Switches (16 Switches)
    SW : in STD_LOGIC_VECTOR (15 downto 0);
    --LEDs (16 LEDs)
    LED : out STD_LOGIC_VECTOR (15 downto 0);
    --Seg7 Display Signals
    SEG7_CATH : out STD_LOGIC_VECTOR (7 downto 0);
    AN : out STD_LOGIC_VECTOR (7 downto 0));
end lab1_top;

architecture Behavioral of lab1_top is                              --lab1_top corresponding architecture
signal digits : std_logic_vector (3 downto 0);                      --architechture signal instantiation
signal display_digits : STD_LOGIC_VECTOR(3 downto 0);
signal anodes : std_logic_vector(7 downto 0);

component seg7_hex PORT (                                           --seg7_hex component instantiation
    digit : in std_logic_vector(3 downto 0);
    seg7: out std_logic_vector(7 downto 0)
    );
end component;
begin
u1 : seg7_hex port map (                                            --sending lab1_top signals to the seg7 component for the cathode hex conversion
        digit =>display_digits,
        seg7 => SEG7_CATH
          );
display_digits <=                                                   --seg7_hex mux, sends zeroes (highest priority) with center button pressed
    "0000" when btnc = '1' else         
    SW(3 downto 0);                                                 --otherwise, send value of Switches 3 to 0

anodes <=
    "00000000" when BTNC = '1' else                                 --Anode conditional statements, setting values based on button priority set by design constraints 
    "00001111" when BTNU = '1' else
    "11110000" when BTND = '1' else
    not SW(11 downto 4);

LED <= SW;                                                          --activates LEDs based on switch values
AN <= anodes;                                                       --sets intermediate value to lab1_top output port
     
  
end Behavioral;
