function conv_vector = discrete_conv_anim(x_entry_signal, h_impulse_response)

conv_vector = conv(x_entry_signal, h_impulse_response);
x_dim = length(x_entry_signal); h_dim = length(h_impulse_response);


%%Calculating graph limits
%entry signal graph limits
y_limit_sup_entry = max(x_entry_signal);
y_limit_inf_entry = min([0 x_entry_signal]);

%impulse response graph limits
y_limit_sup_resp = max(h_impulse_response);
y_limit_inf_resp = min([0 h_impulse_response]);

%mult_factor graph limits
y_limit_sup_mult = max(x_entry_signal)*max(h_impulse_response);
y_limit_inf_mult = min([0 min(x_entry_signal)*max(h_impulse_response) max(x_entry_signal)*min(h_impulse_response)]);

%convolution graph limits
y_limit_sup_conv = max(conv_vector);
y_limit_inf_conv = min([0 conv_vector]);


%%Vectors treatment and resizing
zeros_space = 5;
%time reversed impulse response
h_inverted = flip(h_impulse_response);

if x_dim <= h_dim
    h_inverted = [zeros(1, zeros_space + h_dim) h_inverted zeros(1, zeros_space + x_dim)];
    new_h = [zeros(1, zeros_space + h_dim) h_impulse_response zeros(1, zeros_space + x_dim)];
    shift_factor = h_dim + x_dim + zeros_space;
else
    h_inverted = [zeros(1, zeros_space + h_dim) h_inverted zeros(1, zeros_space + x_dim)];
    new_h = [zeros(1, zeros_space + h_dim) h_impulse_response zeros(1, zeros_space + x_dim)];
    shift_factor = x_dim + h_dim + zeros_space;
end

%entry signal treatment
x_entry_signal = [zeros(1, zeros_space+h_dim) x_entry_signal zeros(1, (zeros_space + h_dim))];

h_shifted = circshift(h_inverted, shift_factor);

n = -(h_dim+zeros_space) :1: x_dim + h_dim + zeros_space - 1;


%%Static ploting
%entry signal ploting
subplot(4,1,1)
stem(n, x_entry_signal, 'b', 'LineWidth', 2);
xlim([min(n) max(n)])
ylim([y_limit_inf_entry, y_limit_sup_entry])
grid on;
title('x[n]');
xlabel('n', 'Interpreter', 'latex');
ylabel('Amplitude', 'Interpreter', 'latex')

%impulse response ploting
subplot(4,1,2);
stem(n, new_h,'b', 'LineWidth', 2);
xlim([min(n) max(n)])
ylim([y_limit_inf_resp, y_limit_sup_resp]);
grid on;
title('h[n]');
xlabel('n', 'Interpreter', 'latex');
ylabel('Amplitude', 'Interpreter', 'latex');

pause(4)

%inverted impulse response ploting
subplot(4,1,2);
stem(n, h_inverted,'b', 'LineWidth', 2);
xlim([min(n) max(n)])
ylim([y_limit_inf_resp, y_limit_sup_resp]);
grid on;
title('h[n]');
xlabel('n', 'Interpreter', 'latex');
ylabel('Amplitude', 'Interpreter', 'latex');

pause(2)

%shifted impulse response ploting
subplot(4,1,2);
stem(n, h_shifted,'b', 'LineWidth', 2);
xlim([min(n) max(n)])
ylim([y_limit_inf_resp, y_limit_sup_resp]);
grid on;
title('h[n]');
xlabel('n', 'Interpreter', 'latex');
ylabel('Amplitude', 'Interpreter', 'latex');

pause(1)

convolution = zeros(1, length(n));

%%Animation loop
for ii = 1:length(n)-h_dim

    %shifting inverted impulse response
    h_shifted = circshift(h_shifted, 1);

    %multiplication factor calculation
    mult_factor = x_entry_signal.*h_shifted;

    %convolution iterated calculation
    convolution(ii+h_dim) = sum(mult_factor);

    %shifted impulse response ploting
    subplot(4,1,2);
    stem(n, h_shifted,'b', 'LineWidth', 2);
    xlim([min(n) max(n)])
    ylim([y_limit_inf_resp, y_limit_sup_resp]);
    grid on;
    title('h[n]');
    xlabel('n', 'Interpreter', 'latex');
    ylabel('Amplitude', 'Interpreter', 'latex');

    %multiplication factor ploting
    subplot(4,1,3);
    stem(n, mult_factor, 'b', 'LineWidth', 2);
    xlim([min(n) max(n)])
    ylim([y_limit_inf_mult, y_limit_sup_mult]);
    grid on;
    title('Fator da Soma de Convolução');
    xlabel('n', 'Interpreter', 'latex');
    ylabel('Amplitude', 'Interpreter', 'latex');

    %convolution ploting
    subplot(4,1,4);
    stem(n, convolution, 'b', 'LineWidth', 2);
    xlim([min(n) max(n)])
    ylim([y_limit_inf_conv,y_limit_sup_conv]);
    grid on;
    title('y[n]');
    xlabel('n', 'Interpreter', 'latex');
    ylabel('Amplitude', 'Interpreter', 'latex');

    pause(0.8);
    drawnow;

end