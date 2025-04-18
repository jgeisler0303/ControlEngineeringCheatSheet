arrowscale= 0.3;
fs= 7;
icon_width= 2;
icon_height= 2;

name= 'PDT1';
G= 1 + tf([1 0], [0.5 1]);


%% Step
[y, t]= step(G);
y= [0; y];
t= [0; t];

clf
axes('Position', [0.3 0.14 0.68 0.8])
hold on
plot([0 t(end)], [1 1], 'm', 'LineWidth', 0.2)
plot([-0.1 0], [3 3], 'r:', 'LineWidth', 0.2)
plot(t, y, 'b')
plot([0 0.5], [3 1], 'r', 'LineWidth', 0.2)

xlabel('$t$', 'Interpreter', 'latex', 'FontSize', fs, 'Position', [t(end) 0], 'HorizontalAlignment', 'right')
ylabel('$h(t)$', 'Interpreter', 'latex', 'FontSize', fs)

set(gca, 'FontSize', fs)
set(gca, 'TickLabelInterpreter', 'latex')
set(gca, 'XTick', 0)
set(gca, 'YTick', [])
set(gca, 'Box', 'off')
xlim([-0.1 t(end)])
% ylim([0 3])

set(gcf, 'PaperSize', [icon_width icon_height])
set(gcf, 'PaperPosition', [0 0 get(gcf, 'PaperSize')])

[ax, ay]= annotCoords([2.7 2.7], [0 1]);
annotation('doublearrow', ax, ay, 'Head1Length', 10*arrowscale, 'Head1Width', 10*arrowscale, 'Head2Length', 10*arrowscale, 'Head2Width', 10*arrowscale, 'Color','red')
text(2.65, 0.5, '$K_R$', 'Color','red', 'FontSize', fs, 'Interpreter', 'latex', 'HorizontalAlignment', 'right', 'VerticalAlignment', 'middle')
text(0.5, 1, '$T_p$', 'Color','red', 'FontSize', fs, 'Interpreter', 'latex', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'top')
text(-0.12, 3, '$\frac{K_R\cdot T_V}{T_p}$', 'Color','red', 'FontSize', fs, 'Interpreter', 'latex', 'HorizontalAlignment', 'right', 'VerticalAlignment', 'top')

print(['IconStep_' name], '-dpdf', '-r300', '-vector')

%% Nyquist
[re, im]= nyquist(G);
re= squeeze(re);
im= squeeze(im);

clf
axes('Position', [0.18 0.1 0.8 0.8])
hold on
plot(1, 0, 'ro', 'MarkerSize', 3)
plot(re, im, 'b')

ylim(3*[-0.3 1])
xlim([0 1.3*3])
set(gca, 'XAxisLocation', 'origin', 'YAxisLocation', 'origin')

xlabel('$\textrm{Re}$', 'Interpreter', 'latex', 'FontSize', fs, 'Position', 3*[1.3 0.0], 'HorizontalAlignment', 'right', 'VerticalAlignment', 'top')
ylabel('$\textrm{Im}$', 'Interpreter', 'latex', 'FontSize', fs, 'Position', 3*[0 1], 'HorizontalAlignment', 'right')

set(gca, 'XTick', [])
set(gca, 'YTick', [])
set(gca, 'Box', 'off')

set(gcf, 'PaperSize', [icon_width icon_height])
set(gcf, 'PaperPosition', [0 0 get(gcf, 'PaperSize')])

% [ax, ay]= annotCoords([0 1], -[0.2 0.2]);
% annotation('doublearrow', ax, ay, 'Head1Length', 10*arrowscale, 'Head1Width', 10*arrowscale, 'Head2Length', 10*arrowscale, 'Head2Width', 10*arrowscale, 'Color','red')
text(1, -0.1, '$K_R$', 'Color','red', 'FontSize', fs, 'Interpreter', 'latex', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'top')
text(0.8, 0.2, '$\omega=0$', 'Color','red', 'FontSize', fs, 'Interpreter', 'latex', 'HorizontalAlignment', 'right', 'VerticalAlignment', 'middle', 'Rotation', -70)

print(['IconNyquist_' name], '-dpdf', '-r300', '-vector')

%% Bode Amp
G= tf([1 1], [0.01 1]);
[A, phi, om]= bode(G*10);
A= 20*log10(squeeze(A));
phi= squeeze(phi);

clf
axes('Position', [0.2 0.16 0.78 0.78])
semilogx(om, om*0+20, 'm', 'LineWidth', 0.2)
hold on
semilogx(om, om*0+60, 'm', 'LineWidth', 0.2)
semilogx([100 100], [0 60], 'r:', 'LineWidth', 0.2)
semilogx([1 1], [0 20], 'r:', 'LineWidth', 0.2)
semilogx(om, A, 'b')
semilogx([1 100], [20 60], 'r', 'LineWidth', 0.2)

ylim([0 60])
xlim([0.1 1000])
set(gca, 'XAxisLocation', 'origin')

xlabel('$\omega$', 'Interpreter', 'latex', 'FontSize', fs, 'Position', [om(end)*0.95 0], 'HorizontalAlignment', 'right', 'VerticalAlignment', 'top')
ylabel('$|G(s)|_{\textrm{dB}}$', 'Interpreter', 'latex', 'FontSize', fs) %, 'Position', [0 0.2])

set(gca, 'XTick', [])
set(gca, 'YTick', [])
set(gca, 'FontSize', fs)
set(gca, 'TickLabelInterpreter', 'latex')
set(gca, 'Box', 'off')

set(gcf, 'PaperSize', [icon_width icon_height])
set(gcf, 'PaperPosition', [0 0 get(gcf, 'PaperSize')])

[ax, ay]= annotCoords([600 600], [0 20]);
annotation('doublearrow', ax, ay, 'Head1Length', 10*arrowscale, 'Head1Width', 10*arrowscale, 'Head2Length', 10*arrowscale, 'Head2Width', 10*arrowscale, 'Color','red')
text(20, 10, '$K_R$', 'Color','red', 'FontSize', fs, 'Interpreter', 'latex', 'HorizontalAlignment', 'righ', 'VerticalAlignment', 'middle')

[ax, ay]= annotCoords([900 900], [0 60]);
annotation('doublearrow', ax, ay, 'Head1Length', 10*arrowscale, 'Head1Width', 10*arrowscale, 'Head2Length', 10*arrowscale, 'Head2Width', 10*arrowscale, 'Color','red')
text(300, 30, '$\frac{K_R\cdot T_V}{T_p}$', 'Color','red', 'FontSize', fs, 'Interpreter', 'latex', 'HorizontalAlignment', 'righ', 'VerticalAlignment', 'middle')

text(28, 59, '$20\ \textrm{dB/Dek}$', 'Color','red', 'FontSize', fs, 'Interpreter', 'latex', 'HorizontalAlignment', 'right', 'VerticalAlignment', 'middle', 'Rotation', 53)
text(1, 0, '$1/T_V$', 'Color','red', 'FontSize', fs, 'Interpreter', 'latex', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'top')
text(100, 0, '$1/T_p$', 'Color','red', 'FontSize', fs, 'Interpreter', 'latex', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'top')

print(['IconBodeA_' name], '-dpdf', '-r300', '-vector')

%% Bode phi
clf
axes('Position', [0.2 0.1 0.78 0.8])
semilogx(om, om*0+90, 'm', 'LineWidth', 0.2)
hold on
semilogx(om, phi, 'b')

ylim([-20 90])
xlim([om(1) om(end)])
set(gca, 'XAxisLocation', 'origin')

xlabel('$\omega$', 'Interpreter', 'latex', 'FontSize', fs, 'Position', [om(end)*0.95 0], 'HorizontalAlignment', 'right', 'VerticalAlignment', 'top')
ylabel('$\angle G(s) / \circ$', 'Interpreter', 'latex', 'FontSize', fs, 'Position', [0.01 45], 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom')

set(gca, 'XTick', [])
set(gca, 'YTick', 0)
set(gca, 'FontSize', fs)
set(gca, 'TickLabelInterpreter', 'latex')
set(gca, 'Box', 'off')

set(gcf, 'PaperSize', [icon_width icon_height])
set(gcf, 'PaperPosition', [0 0 get(gcf, 'PaperSize')])

text(0.01, 90, '$90$', 'Color','red', 'FontSize', fs, 'Interpreter', 'latex', 'HorizontalAlignment', 'right', 'VerticalAlignment', 'middle')

print(['IconBodeP_' name], '-dpdf', '-r300', '-vector')

%% Pole Zero
G= tf([1 1], [1/1.7 1]);
[p, z] = pzmap(G);

clf
axes('Position', [0.05 0.1 0.85 0.8])
plot([-1 -1], [0.05 0.5], 'm', 'LineWidth', 0.2)
hold on
plot([-1.7 -1.7], -[0.05 0.5], 'm', 'LineWidth', 0.2)
plot(real(p), imag(p), 'xb')
plot(real(z), imag(z), 'ob')

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
text(-0.5, 0.4, '$1/T_V$', 'Color','red', 'FontSize', fs, 'Interpreter', 'latex', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom')

[ax, ay]= annotCoords([-1.7 0], -[0.4 0.4]);
annotation('doublearrow', ax, ay, 'Head1Length', 10*arrowscale, 'Head1Width', 10*arrowscale, 'Head2Length', 10*arrowscale, 'Head2Width', 10*arrowscale, 'Color','red')
text(-0.5, -0.4, '$1/T_p$', 'Color','red', 'FontSize', fs, 'Interpreter', 'latex', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'top')

print(['IconPoleZero_' name], '-dpdf', '-r300', '-vector')