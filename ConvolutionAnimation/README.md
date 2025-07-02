# 🌊 Discrete Convolution Animation in MATLAB

This MATLAB script visualizes the step-by-step process of discrete convolution between two signals. It's an excellent educational tool for understanding fundamental concepts in Digital Signal Processing and Linear Systems.

## 🚀 Functionality

* `discrete_conv_anim.m`: Animates the discrete convolution of two input signals, `x_entry_signal` and `h_impulse_response`. The animation dynamically displays the signal inversion, shifting, element-wise multiplication, and cumulative summation to form the output convoluted signal.

## ▶️ How to Use

To run the animation, open the `discrete_conv_anim.m` file in MATLAB and call the function from the command window.

**Example:**
```matlab
% Define your input signal and impulse response
x = [1 1 1 1]; % Input signal
h = [1 1];     % Impulse response

% Call the function to start the animation
conv_result_disc = discrete_conv_anim(x, h);
