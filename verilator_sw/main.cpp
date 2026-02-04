#include <verilated.h>
#include "Vstopwatch_top.h"
#include <iostream>
#include <iomanip>

vluint64_t sim_time = 0;

// Clock toggle helper
void tick(Vstopwatch_top* dut) {
    dut->clk = 0;
    dut->eval();
    sim_time++;

    dut->clk = 1;
    dut->eval();
    sim_time++;
}

int main(int argc, char** argv) {
    Verilated::commandArgs(argc, argv);

    Vstopwatch_top* dut = new Vstopwatch_top;

    // Initial values
    dut->clk   = 0;
    dut->rst_n = 0;
    dut->start = 0;
    dut->stop  = 0;
    dut->reset = 0;

    // Apply reset
    tick(dut);
    dut->rst_n = 1;
    tick(dut);

    std::cout << "Reset done\n";

    // Start stopwatch
    dut->start = 1;
    tick(dut);
    dut->start = 0;

    std::cout << "Stopwatch started\n";

    // Run for some cycles
    for (int i = 0; i < 120; i++) {
        tick(dut);

        if (i % 10 == 0) {
            std::cout << "Time = "
                      << std::setw(2) << std::setfill('0') << (int)dut->minutes
                      << ":"
                      << std::setw(2) << std::setfill('0') << (int)dut->seconds
                      << "  State=" << (int)dut->status
                      << std::endl;
        }
    }

    // Pause stopwatch
    dut->stop = 1;
    tick(dut);
    dut->stop = 0;

    std::cout << "Stopwatch paused\n";

    // Hold paused
    for (int i = 0; i < 20; i++)
        tick(dut);

    // Resume stopwatch
    dut->start = 1;
    tick(dut);
    dut->start = 0;

    std::cout << "Stopwatch resumed\n";

    for (int i = 0; i < 60; i++) {
        tick(dut);

        if (i % 10 == 0) {
            std::cout << "Time = "
                      << std::setw(2) << std::setfill('0') << (int)dut->minutes
                      << ":"
                      << std::setw(2) << std::setfill('0') << (int)dut->seconds
                      << std::endl;
        }
    }

    // Reset stopwatch
    dut->reset = 1;
    tick(dut);
    dut->reset = 0;

    std::cout << "Stopwatch reset\n";
    std::cout << "Final Time = "
              << std::setw(2) << std::setfill('0') << (int)dut->minutes
              << ":"
              << std::setw(2) << std::setfill('0') << (int)dut->seconds
              << std::endl;

    delete dut;
    return 0;
}
