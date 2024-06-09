# Calculator on 7 segment display
The calculator, equipped with 16 switches (with 4 switches dedicated to each digit of the 7-segment display), offers four arithmetic operations: addition, subtraction, multiplication, and division. It consists of the following modules:

calculator.vhd: Serving as the top-level module, this file orchestrates the calculator's operation by integrating all other modules and managing its overall functionality.

calc.vhd: Implementing the finite state machine (FSM), this module controls the sequencing of operations based on user input and manages the state transitions required for arithmetic operations.

debounce.vhd: Ensuring the stability of switch contacts during signal transitions, this module prevents erratic behavior due to bouncing contacts and ensures reliable input from the switches.

pulse.vhd: Generating pulses essential for various operations within the calculator, this module controls the timing of signals and ensures proper synchronization between different modules.

seven_segment.vhd: Responsible for displaying digits on the 7-segment display, this module converts input from the calculator logic into signals suitable for driving the display segments to represent numerical digits.

The calculator operates by receiving input from the 16 switches, representing binary values. The FSM processes the input to perform arithmetic operations, including addition, subtraction, multiplication, and division. The stable input signals are ensured by the debounce module, while timing requirements are managed by the pulse generator. Finally, the calculated results are displayed on the 7-segment display through the seven_segment module, providing visual feedback to the user.
