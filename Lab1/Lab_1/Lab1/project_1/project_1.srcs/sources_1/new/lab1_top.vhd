library IEEE;
use IEEE.STD_LOGIC_1164.ALL;                                        --Library instantiation, work.all allows usage of direct component instantiation later on.
use work.all;

entity lab1_top is port (                                           --Declaring entity lab1_top with its various input/output ports
    --Push Buttons
    BTNC : in STD_LOGIC;                                            --Center button
    BTND : in STD_LOGIC;                                            --Down Buttons
    BTNU : in STD_LOGIC;                                            --Up button
    --Switches (16 Switches)
    SW : in STD_LOGIC_VECTOR (15 downto 0);                         --Input Vector that corresponds to the switches on the dev board
    --LEDs (16 LEDs)
    LED : out STD_LOGIC_VECTOR (15 downto 0);                       --Input vector that corresponds to the LEDs that are beneath the switches
    --Seg7 Display Signals
    SEG7_CATH : out STD_LOGIC_VECTOR (7 downto 0);                  --Output vector that corresponds to the cathodes for the 7 segment display
    AN : out STD_LOGIC_VECTOR (7 downto 0));                        --Output vector that corresponds to the anodes for the 7 segment display
end lab1_top;                                                       --ends the entity declaration

architecture Behavioral of lab1_top is                              --lab1_top corresponding architecture
signal display_digits : STD_LOGIC_VECTOR(3 downto 0);               --architechture signal instantiation that will go to the sub component

begin
u1 : entity seg7_hex port map (digit =>display_digits,  seg7 => SEG7_CATH);  --sending lab1_top signals to the seg7 component for the cathode hex conversion

display_digits <=                                                   --seg7_hex mux, sends zeroes (highest priority) with center button pressed
    "0000" when btnc = '1' else
    SW(3 downto 0);                                                 --otherwise, send value of Switches 3 to 0

AN <=
    "00000000" when BTNC = '1' else                                 --Anode conditional statements, setting values based on button priority set by design constraints
    "00001111" when BTNU = '1' else
    "11110000" when BTND = '1' else
    not SW(11 downto 4);

LED <= SW;                                                          --activates LEDs based on switch values


end Behavioral;
