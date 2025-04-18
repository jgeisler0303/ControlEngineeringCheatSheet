arrowscale= 0.3;
fs= 7;
icon_width= 2;
icon_height= 2;

name= 'IT1';
G= tf(1, [1 1 0]);


%% Step
t= 0:0.01:4;
y= step(G, t);

clf
axes('Position', [0.18 0.14 0.8 0.8])
hold on
plot(t+1, t, 'm', 'LineWidth', 0.2)
plot([2 3]-0.3, [1 1]-0.3, 'm', 'LineWidth', 0.2)
plot([3 3]-0.3, [1 2]-0.3, 'm', 'LineWidth', 0.2)
plot(t, y, 'b')

xlabel('$t$', 'Interpreter', 'latex', 'FontSize', fs, 'Position', [t(end) 0], 'HorizontalAlignment', 'right')
ylabel('$h(t)$', 'Interpreter', 'latex', 'FontSize', fs)

xlim([0 t(end)])
ylim([0 y(end)])
set(gca, 'XTick', [])
set(gca, 'YTick', [])
set(gca, 'Box', 'off')

set(gcf, 'PaperSize', [icon_width icon_height])
set(gcf, 'PaperPosition', [0 0 get(gcf, 'PaperSize')])

text(1, 0, '$T$', 'Color','red', 'FontSize', fs, 'Interpreter', 'latex', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'top')
text(2.5-0.3, 1-0.3, '$1$', 'Color','red', 'FontSize', fs, 'Interpreter', 'latex', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'top')
text(3-0.3+0.05, 1.5-0.3, '$K$', 'Color','red', 'FontSize', fs, 'Interpreter', 'latex', 'HorizontalAlignment', 'left', 'VerticalAlignment', 'middle')

print(['IconStep_' name], '-dpdf', '-r300', '-vector')

%% Nyquist
[re, im]= nyquist(G, {.2 10});
re= squeeze(re);
im= squeeze(im);

clf
axes('Position', [0.1 0.1 0.85 0.8])
hold on
plot(-[1 1], [im(1) 0], 'm', 'LineWidth', 0.2)
plot(0, 0, 'rx', 'MarkerSize', 3)
plot(re, im, 'b')


ylim([im(1) -im(1)/3])
xlim([1.2*re(1) -re(1)/3])
set(gca, 'XAxisLocation', 'origin', 'YAxisLocation', 'origin')

xlabel('$\textrm{Re}$', 'Interpreter', 'latex', 'FontSize', fs, 'Position', [-re(1)/3 0], 'HorizontalAlignment', 'right')
ylabel('$\textrm{Im}$', 'Interpreter', 'latex', 'FontSize', fs, 'Position', [0.02 -im(1)/3], 'HorizontalAlignment', 'right', 'VerticalAlignment', 'bottom', 'Rotation', 90)

set(gca, 'XTick', [])
set(gca, 'YTick', [])
set(gca, 'Box', 'off')

set(gcf, 'PaperSize', [icon_width icon_height])
set(gcf, 'PaperPosition', [0 0 get(gcf, 'PaperSize')])

text(-0.8, 0, '$T\cdot K$', 'Color','red', 'FontSize', fs, 'Interpreter', 'latex', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom')
text(-0.07, -0.27, '$\omega=\infty$', 'Color','red', 'FontSize', fs, 'Interpreter', 'latex', 'HorizontalAlignment', 'right', 'VerticalAlignment', 'middle', 'Rotation', 45)

print(['IconNyquist_' name], '-dpdf', '-r300', '-vector')

%% Bode Amp
[A, phi, om]= bode(G*10);
A= 20*log10(squeeze(A));
phi= squeeze(phi);

clf
axes('Position', [0.2 0.1 0.78 0.8])
semilogx([1 1], [0 30], 'r:', 'LineWidth', 0.2)
hold on
semilogx(om, A, 'b')
semilogx([1 om(end)], [20 20-40*log10(om(end))], 'r', 'LineWidth', 0.2)
semilogx([om(1) 1], [60 60+20*log10(om(1))], 'r', 'LineWidth', 0.2)

% ylim([-13 27])
xlim([om(1) om(end)*0.5])
set(gca, 'XAxisLocation', 'origin')

xlabel('$\omega$', 'Interpreter', 'latex', 'FontSize', fs, 'Position', [om(end)*0.95*0.5 0], 'HorizontalAlignment', 'right', 'VerticalAlignment', 'bottom')
ylabel('$|G(s)|_{\textrm{dB}}$', 'Interpreter', 'latex', 'FontSize', fs) %, 'Position', [0 0.2])

set(gca, 'XTick', [])
set(gca, 'YTick', [])
set(gca, 'FontSize', fs)
set(gca, 'TickLabelInterpreter', 'latex')
set(gca, 'Box', 'off')

set(gcf, 'PaperSize', [icon_width icon_height])
set(gcf, 'PaperPosition', [0 0 get(gcf, 'PaperSize')])

text(0.035, 41, '$-20\ \textrm{dB/Dek}$', 'Color','red', 'FontSize', fs, 'Interpreter', 'latex', 'HorizontalAlignment', 'left', 'VerticalAlignment', 'bottom')
text(23, -30, '$-40\ \textrm{dB/Dek}$', 'Color','red', 'FontSize', fs, 'Interpreter', 'latex', 'HorizontalAlignment', 'right', 'VerticalAlignment', 'top')
text(1, 0, '$1/T$', 'Color','red', 'FontSize', fs, 'Interpreter', 'latex', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'top')

print(['IconBodeA_' name], '-dpdf', '-r300', '-vector')

%% Bode phi
clf
axes('Position', [0.25 0.06 0.73 0.88])
semilogx(om, om*0-135, 'm:', 'LineWidth', 0.2)
hold on
semilogx(om, om*0-90, 'm', 'LineWidth', 0.2)
semilogx(om, om*0-180, 'm', 'LineWidth', 0.2)
semilogx(om, phi, 'b')
semilogx([1 1], [-135 0], 'r:', 'LineWidth', 0.2)
semilogx([1*0.7 1/0.7], [-135 -135], 'r', 'LineWidth', 0.2)

ylim([-180 40])
xlim([om(1) om(end)])
set(gca, 'XAxisLocation', 'origin')

xlabel('$\omega$', 'Interpreter', 'latex', 'FontSize', fs, 'Position', [om(end)*0.95 0], 'HorizontalAlignment', 'right', 'VerticalAlignment', 'top')
ylabel('$\angle G(s) / \circ$', 'Interpreter', 'latex', 'FontSize', fs, 'Position', [0.01 50], 'HorizontalAlignment', 'right', 'VerticalAlignment', 'bottom')

set(gca, 'XTick', [])
set(gca, 'YTick', [])
set(gca, 'FontSize', fs)
set(gca, 'TickLabelInterpreter', 'latex')
set(gca, 'Box', 'off')

set(gcf, 'PaperSize', [icon_width icon_height])
set(gcf, 'PaperPosition', [0 0 get(gcf, 'PaperSize')])

text(1, 0, '$1/T$', 'Color','red', 'FontSize', fs*0.6, 'Interpreter', 'latex', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom')
text(0.01, -90, '$-90$', 'Color','red', 'FontSize', fs, 'Interpreter', 'latex', 'HorizontalAlignment', 'right', 'VerticalAlignment', 'middle')
text(0.01, -180, '$-180$', 'Color','red', 'FontSize', fs, 'Interpreter', 'latex', 'HorizontalAlignment', 'right', 'VerticalAlignment', 'middle')

print(['IconBodeP_' name], '-dpdf', '-r300', '-vector')

%% Pole Zero
[p, z] = pzmap(G);

clf
axes('Position', [0.05 0.1 0.85 0.8])
plot([-1 -1], [0.05 0.5], 'm', 'LineWidth', 0.2)
hold on
plot(real(p), imag(p), 'xb')

ylim([-1 1])
xlim([-2 0.3])
set(gca, 'XAxisLocation', 'origin', 'YAxisLocation', 'origin')

xlabel('$\sigma$', 'Interpreter', 'latex', 'FontSize', fs, 'Position', [0.2 0], 'HorizontalAlignment', 'center')
ylabel('$\textrm{j}\omega$', 'Interpreter', 'latex', 'FontSize', fs, 'Position', [0 1], 'Rotation', 90)

set(gca, 'XTick', [])
set(gca, 'YTick', [])
set(gca, 'Box', 'off')

set(gcf, 'PaperSize', [icon_width icon_height])
set(gcf, 'PaperPosition', [0 0 get(gcf, 'PaperSize')])

[ax, ay]= annotCoords([-1 0], [0.4 0.4]);
annotation('doublearrow', ax, ay, 'Head1Length', 10*arrowscale, 'Head1Width', 10*arrowscale, 'Head2Length', 10*arrowscale, 'Head2Width', 10*arrowscale, 'Color','red')
text(-0.5, 0.4, '$1/T$', 'Color','red', 'FontSize', fs, 'Interpreter', 'latex', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom')

print(['IconPoleZero_' name], '-dpdf', '-r300', '-vector')