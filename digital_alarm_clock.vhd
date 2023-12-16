library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity DigitalAlarmClock is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           alarm_set : in STD_LOGIC;
           snooze : in STD_LOGIC;
           display : out STD_LOGIC_VECTOR(6 downto 0);
           alarm_out : out STD_LOGIC);
end DigitalAlarmClock;

architecture Behavioral of DigitalAlarmClock is
    signal clock_1hz : STD_LOGIC := '0';
    signal current_time : STD_LOGIC_VECTOR(15 downto 0) := "0000000000000000"; -- Format: HHMMSS
    signal alarm_time : STD_LOGIC_VECTOR(15 downto 0) := "0000000000000000";
    signal snooze_counter : integer range 0 to 10 := 0; -- Change as needed

    constant CLK_FREQUENCY : integer := 50000000; -- Adjust based on your clock frequency
    constant TICKS_PER_SECOND : integer := 1; -- For a 1Hz clock

    -- Add your display and other component signals here

begin
    -- Clock generation process
    process(clk, reset)
    begin
        if reset = '1' then
            clock_1hz <= '0';
        elsif rising_edge(clk) then
            if snooze = '1' and snooze_counter < 10 then
                snooze_counter <= snooze_counter + 1;
            else
                snooze_counter <= 0;
                clock_1hz <= not clock_1hz after CLK_FREQUENCY / (2 * TICKS_PER_SECOND);
            end if;
        end if;
    end process;

    -- Timekeeping process
    process(clk, reset)
    begin
        if reset = '1' then
            current_time <= "0000000000000000";
        elsif rising_edge(clk) then
            if clock_1hz = '1' then
                -- Update current_time logic based on your clock format
                -- Example: current_time <= current_time + 1;
            end if;
        end if;
    end process;

    -- Alarm logic process
    process(clk, reset)
    begin
        if reset = '1' then
            alarm_time <= "0000000000000000";
        elsif rising_edge(clk) then
            -- Update alarm_time logic based on your clock format
            -- Example: alarm_time <= alarm_time + 1;
        end if;
    end process;

    -- Display control process
    -- Implement your display control logic here

    -- Alarm output process
    process(current_time, alarm_time, alarm_set, snooze_counter)
    begin
        alarm_out <= '1' when current_time = alarm_time and alarm_set = '1' and snooze_counter = 0 else '0';
    end process;

end Behavioral;
