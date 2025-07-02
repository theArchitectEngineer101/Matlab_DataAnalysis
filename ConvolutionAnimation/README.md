# 🌊 Convolution Animations (Continuous and Discrete) in MATLAB

This repository contains MATLAB scripts designed to visually demonstrate the step-by-step process of signal convolution, covering both discrete and continuous-time domains. These tools serve as excellent educational aids for understanding fundamental concepts in Signals and Systems, Digital Signal Processing, and Linear Systems.

## 🚀 Functionality

This project includes two main animation scripts:

* **`discrete_conv_anim.m`**: Animates the discrete convolution of two input signals (`x_entry_signal` and `h_impulse_response`). The animation dynamically displays the signal inversion, shifting, element-wise multiplication, and cumulative summation to form the output convoluted signal.
* **`continuous_conv_anim.m`**: Animates the continuous convolution of two input signals (`x_entry_signal` and `h_impulse_response`). This is simulated using discrete samples to visualize the signal inversion, shifting, element-wise multiplication, and the integration-like accumulation process that forms the output convoluted signal.

## ▶️ How to Use

To run the animations, ensure both `.m` files are in your MATLAB path. Then, call the desired function from the MATLAB command window.

**Example for Discrete Convolution:**
```matlab
% Define your input signal and impulse response
x_disc = [1 1 1 1]; % Input signal
h_disc = [1 1];     % Impulse response

% Call the function to start the discrete convolution animation
conv_result_discrete = discrete_conv_anim(x_disc, h_disc);
