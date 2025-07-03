function conv_vector = continuous_conv_anim(x_entry_signal, h_impulse_response)

conv_vector = conv(x_entry_signal, h_impulse_response);
x_dim = length(x_entry_signal); h_dim = length(h_impulse_response); step = 0.5;


%% Calculating graph limits
% Entry signal graph limits
y_limit_sup_entry = max(x_entry_signal);
y_limit_inf_entry = min([0 x_entry_signal]);

% Impulse response graph limits
y_limit_sup_resp = max(h_impulse_response);
y_limit_inf_resp = min([0 h_impulse_response]);

% Mult_factor graph limits
y_limit_sup_mult = max(x_entry_signal)*max(h_impulse_response);
y_limit_inf_mult = min([0 min(x_entry_signal)*max(h_impulse_response) max(x_entry_signal)*min(h_impulse_response)]);

% Convolution graph limits
y_limit_sup_conv = max(conv_vector);
y_limit_inf_conv = min([0 conv_vector]);


%% Vectors treatment and resizing
PADDING_SIZE = 5/step;
% Time reversed impulse response
h_inverted = flip(h_impulse_response);

if x_dim <= h_dim
    h_inverted = [zeros(1, PADDING_SIZE + h_dim) h_inverted zeros(1, PADDING_SIZE + x_dim)];
    h_padded = [zeros(1, PADDING_SIZE + h_dim) h_impulse_response zeros(1, PADDING_SIZE + x_dim)];
    shift_factor = h_dim + x_dim + PADDING_SIZE;
else
    h_inverted = [zeros(1, PADDING_SIZE + h_dim) h_inverted zeros(1, PADDING_SIZE + x_dim)];
    h_padded = [zeros(1, PADDING_SIZE + h_dim) h_impulse_response zeros(1, PADDING_SIZE + x_dim)];
    shift_factor = x_dim + h_dim + PADDING_SIZE;
end

% Entry signal treatment
x_entry_signal = [zeros(1, PADDING_SIZE+h_dim) x_entry_signal zeros(1, (PADDING_SIZE + h_dim))];


h_shifted = circshift(h_inverted, shift_factor);

n = -(h_dim+PADDING_SIZE) :step: x_dim + h_dim + PADDING_SIZE - step;


%% Static ploting
% Entry signal ploting
subplot(4,1,1)
plot(n, x_entry_signal, 'm', 'LineWidth', 1);
xlim([min(n) max(n)])
ylim([y_limit_inf_entry, y_limit_sup_entry])
grid on;
title('x[n]');
xlabel('n', 'Interpreter', 'latex');
ylabel('Amplitude', 'Interpreter', 'latex')

% Impulse response ploting
subplot(4,1,2);
plot(n, h_padded,'m', 'LineWidth', 1);
xlim([min(n) max(n)])
ylim([y_limit_inf_resp, y_limit_sup_resp]);
grid on;
title('h[n]');
xlabel('n', 'Interpreter', 'latex');
ylabel('Amplitude', 'Interpreter', 'latex');

pause(2)

% Inverted impulse response ploting
subplot(4,1,2);
plot(n, h_inverted,'m', 'LineWidth', 1);
xlim([min(n) max(n)])
ylim([y_limit_inf_resp, y_limit_sup_resp]);
grid on;
title('h[n]');
xlabel('n', 'Interpreter', 'latex');
ylabel('Amplitude', 'Interpreter', 'latex');

pause(2)

% Shifted impulse response ploting
subplot(4,1,2);
plot(n, h_shifted,'m', 'LineWidth', 1);
xlim([min(n) max(n)])
ylim([y_limit_inf_resp, y_limit_sup_resp]);
grid on;
title('h[n]');
xlabel('n', 'Interpreter', 'latex');
ylabel('Amplitude', 'Interpreter', 'latex');

pause(1)

convolution = zeros(1, length(n));

%% Animation loop
for ii = 1:length(n)-h_dim

    % Shifting inverted impulse response
    h_shifted = circshift(h_shifted, 1);

    % Multiplication factor calculation
    mult_factor = x_entry_signal.*h_shifted;

    % Convolution iterated calculation
    convolution(ii+h_dim) = sum(mult_factor);

    % Shifted impulse response ploting
    subplot(4,1,2);
    plot(n, h_shifted,'m', 'LineWidth', 1);
    xlim([min(n) max(n)])
    ylim([y_limit_inf_resp, y_limit_sup_resp]);
    grid on;
    title('h[n]');
    xlabel('n', 'Interpreter', 'latex');
    ylabel('Amplitude', 'Interpreter', 'latex');

    % Multiplication factor ploting
    subplot(4,1,3);
    plot(n, mult_factor, 'm', 'LineWidth', 1);
    xlim([min(n) max(n)])
    ylim([y_limit_inf_mult, y_limit_sup_mult]);
    grid on;
    title('Fator da Soma de Convolução');
    xlabel('n', 'Interpreter', 'latex');
    ylabel('Amplitude', 'Interpreter', 'latex');

    % Convolution ploting
    subplot(4,1,4);
    plot(n, convolution, 'r', 'LineWidth', 1);
    xlim([min(n) max(n)])
    ylim([y_limit_inf_conv, y_limit_sup_conv]);
    grid on;
    title('y[n]');
    xlabel('n', 'Interpreter', 'latex');
    ylabel('Amplitude', 'Interpreter', 'latex');

    drawnow limitrate;

end