# Monte Carlo Random Walk Simulation

A visual implementation of a Monte Carlo simulation for a financial random walk, built with Godot Engine.

**Run Project:** [https://luera.itch.io/fvc-monte-carlo-simulation](https://luera.itch.io/fvc-monte-carlo-simulation)

*For the best experience, use Google Chrome. Firefox may open the project in a separate window which can cause resolution issues.*

## Project Description

This project fulfills a coding exercise to simulate a random walk of a share price starting at £100. With each step, the price has an equal probability of increasing or decreasing by £1. The application runs a user-defined number of simulations (`N`) for a number of steps (`S`), calculates the resulting probability distribution of final prices, and presents it both visually and in a detailed data table.

I chose Godot to go beyond a simple terminal application and create an interactive, visual experience that demonstrates the Monte Carlo method intuitively. This showcases not only problem-solving skills but also an investment in creating a memorable and user-friendly solution.

## How to Run

1.  **Web (Easiest):** Simply click the "Run Project" button on the [itch.io page](https://luera.itch.io/fvc-monte-carlo-simulation).
2.  **From Source:**
    *   Download or clone this repository.
    *   Open the project folder in Godot Engine (version 4.4 is recommended).
    *   Click the "Run" button in the top-right corner of the editor.

## Technical Implementation

The project's logic is separated into several GDScripts for clarity and maintainability.

*   **`input_control_panel.gd`**: This is the **main script** and the entry point for the application. It handles:
    *   User input validation for `S` (steps) and `N` (walks).
    *   Orchestrating the simulation by sending signals.
    *   Managing the UI state (buttons, progress bar).
*   **`data_controller.gd`**: A **global Autoload script** that acts as the central data bus. It receives the simulation parameters and results from the control panel and distributes them to the visualization components (like the data table).
*   **`data_table.gd`**: Handles the dynamic creation and population of the results table, displaying the final price, frequency, and probability for each outcome.

### GDScript

GDScript is Godot's high-level, Python-like scripting language. It is designed for tight integration with the engine and its scene system, making it exceptionally fast for prototyping and building logic. Key features include its simple syntax, automatic garbage collection, and powerful built-in types for vector math. All code for this project can be found in the `/scripts/` directory.

### Performance & Runtime

The simulation is optimized to handle the maximum required values (`S=100`, `N=100,000`) well under the 10-second requirement.
For `S=10` and `N=10,000`, the simulation runs in a fraction of a second. For `N=100,000`, it typically completes in 1-2 seconds, meeting the performance criteria.

## Answer to the Exercise

When run with `S = 10` steps and `N = 10,000` walks, the probability that the final share price is **£100 is approximately 24.5%**.

---
