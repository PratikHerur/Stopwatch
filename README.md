# Digital Stopwatch
## Control FSM Overview

The stopwatch is controlled using a simple Finite State Machine (FSM).  
The FSM decides when the stopwatch should count time, pause or reset.

The FSM has three states:

### 1. IDLE (00)
- Initial state after reset
- Stopwatch time is 00:00
- Counters are disabled
- Enters this state when the stopwatch has been reset from any state.

### 2. RUNNING (01)
- Stopwatch is actively counting
- Seconds and minutes counters are enabled
- Enters this state when it starts from idle or resumes from a paused state.

### 3. PAUSED (10)
- Stopwatch is paused
- Time value is held (no counting)
- Enters this state when paused. 

### Reset Behavior
- `reset = 1` from any state forces the FSM back to **IDLE**
- Time is cleared to 00:00

## FSM Output
- The FSM generates a `count_enable` signal
- `count_enable = 1` only in the RUNNING state
- This signal controls whether the counters increment
